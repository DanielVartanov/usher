require 'lib/compat'
require 'lib/usher'

route_set = Usher::Interface.for(:rails2)

def build_request_mock(path, method, params)
  request = mock "Request"
  request.should_receive(:path).any_number_of_times.and_return(path)
  request.should_receive(:method).any_number_of_times.and_return(method)
  params = params.with_indifferent_access
  request.should_receive(:path_parameters=).any_number_of_times.with(params)
  request.should_receive(:path_parameters).any_number_of_times.and_return(params)
  request
end

SampleController = Object.new

describe "Usher (for rails) route recognition" do

  before(:each) do
    route_set.reset!
  end

  it "should recognize a simple request" do
    route_set.add_route('/sample', :controller => 'sample', :action => 'action')
    route_set.recognize(build_request_mock('/sample', 'get', {:controller => 'sample', :action => 'action'})).should == SampleController
  end

  it "should interpolate action :index" do
    route_set.add_route('/sample', :controller => 'sample')
    route_set.recognize(build_request_mock('/sample', 'get', {:controller => 'sample', :action => 'index'})).should == SampleController
  end

  it "should correctly distinguish between multiple request methods" do
    route_set.add_route('/sample', :controller => 'not_sample', :conditions => {:method => :get})
    correct_route = route_set.add_route('/sample', :controller => 'sample', :conditions => {:method => :post})
    route_set.add_route('/sample', :controller => 'not_sample', :conditions => {:method => :put})
    route_set.recognize(build_request_mock('/sample', :post, {:controller => 'sample', :action => 'index'})).should == SampleController
  end

  it "should prefer the static route to the dynamic route" do
    route_set.add_route('/sample/:action', :controller => 'not_sample')
    route_set.add_route('/sample/test', :controller => 'sample', :action => 'action')
    route_set.recognize(build_request_mock('/sample/test', 'get', {:controller => 'sample', :action => 'action'})).should == SampleController
  end
  
  it "should raise based upon an invalid param" do
    route_set.add_named_route(:sample, '/sample/:action', :controller => 'sample', :requirements => {:action => /\d+/})
    proc { route_set.recognize(build_request_mock('/sample/asdqwe', :post, {})) }.should raise_error
  end
  
  it "should add /:controller and /:controller/:action if /:controller/:action/:id is added" do
    route_set.add_route('/:controller/:action/:id')
    route_set.route_count.should == 3
  end
  
  it "should correctly recognize a format (dynamic path path with . delimiter)" do
    route_set.add_route('/:controller/:action/:id.:format')
    route_set.recognize(build_request_mock('/sample/test/123.html', 'get', {:controller => 'sample', :action => 'test', :id => '123', :format => 'html'})).should == SampleController
  end
  
  it "should support root nodes" do
    route_set.add_route('/', :controller => 'sample')
    route_set.recognize(build_request_mock('/', :get, {:controller => 'sample', :action => 'index'})).should == SampleController
  end
  
  it "should default action to 'index' when controller (and not index) is specified" do
    route_set.add_route('/:controller/:action')
    route_set.recognize(build_request_mock('/sample', :get, {:controller => 'sample', :action => 'index'})).should == SampleController
  end
  
  
end