module RemindersHelper
  def queries_for_options(project_id)
    (Query.find_all_by_project_id(project_id) | Query.find_all_by_is_public(true)).
      collect {|q| [q.name, q.id]}
  end

  def reminders_intervals_for_options
    Reminder.intervals.collect {|i| [l(i).capitalize, i.to_s]}
  end
end
