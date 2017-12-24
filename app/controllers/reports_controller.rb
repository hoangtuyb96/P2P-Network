class ReportsController < ApplicationController
  before_action :check_logged_in
  before_action :find_reportable

  def create
    @report = @reportable.reports.new report_params
    report.user_id = current_user.id

    if @reportable.class.name == "User"
      @report.reportable_id = @reportable.id
      @report.reportable_type = @reportable.class
    end

    if report.save
      redirect_to current_user
    end
  end

  private

  attr_reader :report

  def report_params
    params.require(:report).permit :content
  end

  def find_reportable
    if params[:status_id].present?
      @reportable = Status.find_by id: params[:status_id]
    elsif params[:image_id].present?
      @reportable = Image.find_by id: params[:image_id]
    else
      @reportable = User.find_by id: params[:user_id]
    end
  end
end
