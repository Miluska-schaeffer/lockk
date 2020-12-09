require 'csv'
class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_server
  def handle
    # need process csv file sent in the request
    report = params[:report].open
    csv_options = { col_sep: ',', headers: :first_row }
    CSV.parse(report, csv_options) do |row|
      p row
   end
    render json: { message: "test" }
  end

  def authenticate_server
    code_name = request.headers["X-Server-CodeName"]
    server = Server.find_by(code_name: code_name)
    access_token = request.headers["X-Server-Token"]
    unless server && server.access_token == access_token
      render json: { message: "Wrong Credentials" }
    end
  end

end
