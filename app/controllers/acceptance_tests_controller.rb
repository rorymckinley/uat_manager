class AcceptanceTestsController < ApplicationController
  def create
    render :text => AcceptanceTest.create(params[:acceptance_test]).id, :status => :ok
  end
end
