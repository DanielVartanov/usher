require 'lib/compat'
require 'lib/usher'

route_set = Usher.new

describe "Usher route adding" do

  before(:each) do
    route_set.reset!
  end

  it "should be empty after a reset" do
    route_set.add_route('/sample', :controller => 'sample')
    route_set.empty?.should == false
    route_set.reset!
    route_set.empty?.should == true
  end
  
  it "shouldn't allow routes without a controller to be added" do
    proc { route_set.add('/bad/route') }.should raise_error
  end

  it "should allow named routes to be added" do
    route_set.add_named_route(:route, '/bad/route', :controller => 'sample').should == route_set.named_routes[:route]
  end

end