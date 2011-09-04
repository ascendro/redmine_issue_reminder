class RemindersController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @reminders = Reminder.find(:all)
    @reminder = Reminder.new
  end

  def create
    
  end

  def update
    
  end

  def destroy
    
  end

  def update_interval_values
    vals = Reminder.interval_values_for(params[:interval])
    render :update do |page|
      page.replace_html "interval_values",
      :partial => 'interval_values',
      :object => Reminder.interval_values_for(params[:interval])
    end
  end
end
