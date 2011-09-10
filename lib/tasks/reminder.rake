namespace :reminder do
  desc "Executes all reminders that fulfill time conditions."
  task :exec => :environment do
    mail_data = {}
    Reminder.all.select {|rem| rem.execute?}.sort{|l,r| l.project_id <=> r.project_id}.each do |rem|
      puts "Checking reminder #{rem.id}"
      rem.roles.each do |role|
        role.members.each do |member|
          mail_data[member.user] = [] if mail_data[member.user].nil?
          mail_data[member.user] << [rem.project, rem.query] unless mail_data[member.user].include? [rem.project, rem.query]
        end
      end
    end

    mail_data.each do |user, queries_data|
      queries_data.each do |data|
        puts "#{user.name}: #{data[0].name}, #{data[1].name}"
      end
      ReminderMailer.deliver_issues_reminder(user, queries_data)
    end
  end
end
