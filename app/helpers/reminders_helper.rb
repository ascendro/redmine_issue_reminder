module RemindersHelper
  def queries_for_options(project_id)
    (Query.find(:all, :conditions => ['is_public = ? AND (project_id = ? OR project_id is null)', true, project_id])).
      collect {|q| [q.name, q.id]}
  end

  def reminders_intervals_for_options
    Reminder.intervals.collect {|i| [l(i).capitalize, i.to_s]}
  end

  def content_for_column(column, issue)
    value = column.value(issue)

    case value.class.name
    when 'String'
      if column.name == :subject
        link_to issue.subject, issue_url(issue)
      else
        h(value)
      end
    when 'Time'
      format_time(value)
    when 'Date'
      format_date(value)
    when 'Fixnum', 'Float'
      if column.name == :done_ratio
        progress_bar(value, :width => '80px')
      else
        h(value.to_s)
      end
    when 'User'
      link_to "#{value.firstname} #{value.lastname}", user_url(value)
    when 'Project'
      link_to value.name, project_url(value)
    when 'Version'
      h(value)
    when 'TrueClass'
      l(:general_text_Yes)
    when 'FalseClass'
      l(:general_text_No)
    when 'Issue'
      link_to value.subject, issue_url(value)
    else
      h(value)
    end
  end
end
