class ReminderMailer < ActionMailer::Base
  helper :application
  helper :queries
  helper :reminders
  include Redmine::I18n
  
  def issues_reminder(user, queries_data)
    default_url_options[:host] = Setting.host_name
    default_url_options[:protocol] = "http"
    recipients user.mail
    from Setting.mail_from
    content_type "text/html"
    subject "Issues Reminder Mail"
    body :queries_data => queries_data
  end
end
