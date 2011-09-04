class RemindersController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @reminders = Reminder.find_all_by_project_id(@project)
    @reminder = Reminder.new
  end

  def create
    reminder = Reminder.new(params[:reminder])
    reminder.interval_value = params[:interval_value].to_i
    if reminder.save
      Role.find_all_givable.each do |role|
        if params[role.name.downcase]
          rr = ReminderRole.new
          rr.reminder = reminder
          rr.role = role
          rr.save
        end
      end
      
      flash[:notice] = "Reminder successfully created"
    else
      flash[:error] = "Reminder not created"
    end
    render(:update) {|page| page.call 'location.reload'}
  end

  def update
    
  end

  def destroy
    reminder = Reminder.find(params[:id])
    if reminder
      reminder.destroy
    end
    render(:update) {|page| page.call 'location.reload'}
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
