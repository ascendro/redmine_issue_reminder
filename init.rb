require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :redmine_issue_reminder do
    unless ProjectsHelper.included_modules.include?(IssueReminderExtendedSettingsTab)
        ProjectsHelper.send(:include, IssueReminderExtendedSettingsTab)
    end
end

Redmine::Plugin.register :redmine_issue_reminder do
  name 'Redmine Issue Reminder plugin'
  author 'Ascendro S.R.L'
  description 'Issue reminder plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/ascendro/redmine_issue_reminder'
  author_url 'http://www.ascendro.ro/'

  permission :view_issue_reminder, { :reminder => :index }

  project_module :issue_reminder do
    permission :view_issue_reminder, :reminder => :index
  end
end
