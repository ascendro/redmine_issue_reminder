class ReminderMailer < ActionMailer::Base
  helper :application
  helper :queries
  helper :reminders
  include Redmine::I18n
  
  def self.default_url_options
    h = Setting.host_name
    h = h.to_s.gsub(%r{\/.*$}, '') unless Redmine::Utils.relative_url_root.blank?
    { :host => h, :protocol => Setting.protocol }
  end
  
  def issues_reminder(user, queries_data)
	User.current = user  
    default_url_options[:host] = Setting.host_name
    default_url_options[:protocol] = "http"
	set_language_if_valid user.language
    recipients user.mail
    from Setting.mail_from
    content_type "text/html"
    subject Setting.plugin_redmine_issue_reminder['issue_reminder_mail_subject'] || "Issue Reminder"
    body :queries_data => queries_data
  end
end
