require File.join(File.dirname(__FILE__), 'rails2_2_interface', 'mapper')

class Usher
  module Interface
    class Rails22Interface
      
      attr_reader :usher
      attr_accessor :configuration_file

      def initialize
        reset!
      end
      
      def reset!
        @usher ||= Usher.new(:generator => Usher::Util::Generators::URL.new, :request_methods => [:protocol, :domain, :port, :query_string, :remote_ip, :user_agent, :referer, :method, :subdomains])
        @module ||= Module.new
        @module.instance_methods.each do |selector|
          @module.class_eval { remove_method selector }
        end
        @controller_action_route_added = false
        @controller_route_added = false
        @usher.reset!
      end
      
      def add_route(path, options = {})
        if !@controller_action_route_added && path =~ %r{^/?:controller/:action/:id$}
          add_route('/:controller/:action', options.dup)
          @controller_action_route_added = true 
        end

        if !@controller_route_added && path =~ %r{^/?:controller/:action$}
          add_route('/:controller', options.merge({:action => 'index'}))
          @controller_route_added = true 
        end
        
        options[:action] = 'index' unless options[:action]

        path[0, 0] = '/' unless path[0] == ?/
        route = @usher.add_route(path, options)
        raise "your route must include a controller" unless (route.paths.first.dynamic_keys && route.paths.first.dynamic_keys.include?(:controller)) || route.destination.include?(:controller)
        route
      end
      
      def recognize(request)
        node = @usher.recognize(request)
        params = node.params.inject({}){|h,(k,v)| h[k]=v; h }
        request.path_parameters = (node.params.empty? ? node.path.route.destination : node.path.route.destination.merge(params)).with_indifferent_access
        "#{request.path_parameters[:controller].camelize}Controller".constantize
      rescue
        raise ActionController::RoutingError, "No route matches #{request.path.inspect} with #{request.inspect}"
      end
      
      def add_named_route(name, route, options = {})
        @usher.add_route(route, options).name(name)
      end
        
      def route_count
        @usher.route_count
      end  
      
      def empty?
        @usher.route_count.zero?
      end
      
      def generate(options, recall = {}, method = :generate, route_name = nil)
        route = if(route_name)
          @usher.named_routes[route_name]
        else
          merged_options = options
          merged_options[:controller] = recall[:controller] unless options.key?(:controller)
          unless options.key?(:action)
            options[:action] = ''
          end
          path_for_options(merged_options)
        end
        case method
        when :generate
          merged_options ||= recall.merge(options)
          url = generate_url(route, merged_options)
          url.slice!(-1) if url[-1] == ?/
          url 
        else
          raise "method #{method} not recognized"
        end
      end
      
      def generate_url(route, params)
        @usher.generator.generate(route, params)
      end
      
      def path_for_options(options)
        @usher.path_for_options(options)
      end
      
      def named_routes
        @usher.named_routes
      end

      def reload
        @usher.reset!
        if @configuration_file
          Kernel.load(@configuration_file)
        else
          @usher.add_route ":controller/:action/:id"
        end
      end

      def load_routes!
        reload
      end

      def draw
        reset!
        yield Mapper.new(self)
        install_helpers
      end

      def install_helpers(destinations = [ActionController::Base, ActionView::Base], regenerate_code = false)
        #*_url and hash_for_*_url
        Array(destinations).each do |d| d.module_eval { include Helpers } 
          @usher.named_routes.keys.each do |name|
            @module.module_eval <<-end_eval # We use module_eval to avoid leaks
              def #{name}_url(options = {})
                ActionController::Routing::UsherRoutes.generate(options, {}, :generate, :#{name})
              end
            end_eval
          end
          d.__send__(:include, @module)
        end
      end
      
    end
  end
end
