require 'spec_helper'

describe AcceptanceTestsController do
  before(:each) do
    AcceptanceTest.delete_all
  end
  it "should create an instance of an AcceptanceTest" do
    post :create, :acceptance_test => { :name => 'Testing creation of an AcceptanceTest', :context => 'UAT Manager', :starting_point => 'Start Page' }
    response.should be_success
    AcceptanceTest.count.should == 1
    AcceptanceTest.find(response.body.to_i).should_not be_nil
  end
  it "should return data for an instance of an AcceptanceTest" do
    post :create, :acceptance_test => { :name => 'Testing creation of an AcceptanceTest', :context => 'UAT Manager', :starting_point => 'Start Page' }
    created_id = response.body.to_i
    get :show, :id => created_id
    response.should be_success
    response.body.should == AcceptanceTest.find(created_id).to_json
  end
end
