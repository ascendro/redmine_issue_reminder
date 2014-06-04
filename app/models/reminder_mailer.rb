class ReminderMailer < ActionMailer::Base
  helper :application
  helper :issues
  helper :reminders
  include Redmine::I18n

  # Fixed: reminder mails are not sent when delivery_method is :async_smtp (#5058).
  def self.with_synched_deliveries(&block)
    saved_method = ActionMailer::Base.delivery_method
    if m = saved_method.to_s.match(%r{^async_(.+)$})
      synched_method = m[1]
      ActionMailer::Base.delivery_method = synched_method.to_sym
      ActionMailer::Base.send "#{synched_method}_settings=", ActionMailer::Base.send("async_#{synched_method}_settings")
    end
    yield
  ensure
    ActionMailer::Base.delivery_method = saved_method
  end

  def issues_reminder(user, queries_data)
    @user = user
    @queries_data = queries_data
    User.current = @user

    default_url_options[:host] = Setting.host_name
    headers['X-Mailer'] = 'Redmine'
    headers['X-Redmine-Host'] = Setting.host_name
    headers['X-Redmine-Site'] = Setting.app_title
    headers['X-Auto-Response-Suppress'] = 'OOF'
    headers['Auto-Submitted'] = 'auto-generated'
    headers['From'] = Setting.mail_from
    headers['List-Id'] = "<#{Setting.mail_from.to_s.gsub('@', '.')}>"

    set_language_if_valid user.language
    mail :to => user.mail,
      :from => Setting.mail_from,
      :subject => Setting.plugin_redmine_issue_reminder['issue_reminder_mail_subject'] || "Issue Reminder"
  end
end
