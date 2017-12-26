class Admin::ReportsController < ApplicationController
  before_action :find_report, only: :destroy

  def index
    @reports = Report.all
  end

  def destroy
    if report.destroy
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    end
  end

  private

  attr_reader :report

  def find_report
    @report = Report.find_by id: params[:id]
  end
end
