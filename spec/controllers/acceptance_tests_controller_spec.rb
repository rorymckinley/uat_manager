require 'spec_helper'

describe AcceptanceTestsController do
  it "should create an instance of an AcceptanceTest" do
    post :create, :name => 'Testing creation of an AcceptanceTest', :context => 'UAT Manager', :starting_point => 'Start Page'
    response.should be_success
  end
end
