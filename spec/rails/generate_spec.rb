require 'lib/compat'
require 'lib/usher'

route_set = Usher::Interface.for(:rails2)

describe "Usher (for rails) URL generation" do
  
  before(:each) do
    route_set.reset!
  end

  it "should fill in the controller from recall" do
    route_set.add_route(':controller/:action/:id')
    route_set.generate({:action => 'thingy'}, {:controller => 'sample', :action => 'index', :id => 123}, :generate).should == '/sample/thingy'
  end

  it "should skip the action if not provided" do
    route_set.add_route(':controller/:action/:id')
    route_set.generate({:controller => 'thingy'}, {:controller => 'sample', :action => 'index', :id => 123}, :generate).should == '/thingy'
  end

  it "should pick the correct param from optional parts" do
    route_set.add_route(':controller/:action(.:format)')
    route_set.generate({:action => 'thingy', :format => 'html'}, {:controller => 'sample', :action => 'index', :id => 123}, :generate).should == '/sample/thingy.html'
    route_set.generate({:action => 'thingy'}, {:controller => 'sample', :action => 'index', :id => 123}, :generate).should == '/sample/thingy'
  end

end