module RemindersHelper
  def queries_for_options(project_id)
    (Query.find(:all, :conditions => ['is_public = ? AND (project_id = ? OR project_id is null)', true, project_id])).
      collect {|q| [q.name, q.id]}
  end

  def reminders_intervals_for_options
    Reminder.intervals.collect {|i| [l(i).capitalize, i.to_s]}
  end
end
