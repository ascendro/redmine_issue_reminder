namespace :reminder do
  desc "Executes all reminders that fulfill time conditions."
  task :exec => :environment do
    mail_data = {}
    Reminder.all.select {|rem| rem.execute?}.sort{|l,r| l.project_id <=> r.project_id}.each do |rem|
      if rem.project.enabled_module_names.include?('issue_reminder') && rem.query
        rem.roles.each do |role|
          role.members.select {|m| m.project_id == rem.project_id}.each do |member|
            mail_data[member.user] = [] if mail_data[member.user].nil?
            mail_data[member.user] << [rem.project, rem.query] unless mail_data[member.user].include? [rem.project, rem.query]
            rem.executed_at = Time.now
            rem.save
          end
        end
      end
    end

    mail_data.each do |user, queries_data|	
      ReminderMailer.deliver_issues_reminder(user, queries_data)
    end
  end
end
