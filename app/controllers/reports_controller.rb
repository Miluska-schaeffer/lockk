class ReportsController < ApplicationController
  def handle
    render json: { message: "test" }
  end
end
