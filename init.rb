require 'redmine'

# This plugin should be reloaded in development mode.
if RAILS_ENV == 'development'
  ActiveSupport::Dependencies.load_once_paths.reject!{|x| x =~ /^#{Regexp.escape(File.dirname(__FILE__))}/}
end

Redmine::Plugin.register :redmine_issue_reminder do
  name 'Redmine Issue Reminder plugin'
  author 'Ascendro S.R.L'
  description 'Issue reminder plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/ascendro/redmine_issue_reminder'
  author_url 'http://www.ascendro.ro/'

  permission :view_issue_reminder, { :reminders => :index }

  settings :default => { 'email_subject' => :default_email_subject }
  
  project_module :issue_reminder do
    permission :view_issue_reminder, :reminders => :index
  end

  menu :project_menu,
    :issue_reminder,
  { :controller => "reminders", :action => "index" },
    :caption => :caption,
    :last => true,
    :param => :project_id
end
