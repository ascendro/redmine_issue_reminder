require_dependency 'projects_helper'

module IssueReminderExtendedSettingsTab
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      alias_method_chain :project_settings_tabs, :issue_reminder
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def project_settings_tabs_with_issue_reminder
      tabs = project_settings_tabs_without_issue_reminder
      if @project.module_enabled?("issue_reminder")
        tabs.push({ :name => 'issue_reminder',
                    :controller => :reminder,
                    :action => :index,
                    :partial => 'reminders/index',
                    :label => :reminder_settings })
      end
      tabs
    end
  end
end

