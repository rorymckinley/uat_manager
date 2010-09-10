require 'spec_helper'

describe AcceptanceTestsController do
  before(:each) do
    AcceptanceTest.delete_all
  end
  it "should create an instance of an AcceptanceTest" do
    post :create, :acceptance_test => { :name => 'Testing creation of an AcceptanceTest', :context => 'UAT Manager', :starting_point => 'Start Page' }
    response.should be_success
    AcceptanceTest.all.size.should == 1
    AcceptanceTest.find(response.body.to_i).should_not be_nil
  end
end
