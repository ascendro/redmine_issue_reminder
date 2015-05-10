require 'redmine'
require 'active_support/core_ext'

# This plugin should be reloaded in development mode.
if Rails.env == 'development'
  ActiveSupport::Dependencies.autoload_once_paths.reject!{|x| x =~ /^#{Regexp.escape(File.dirname(__FILE__))}/}
end

# Tentative de faire fonctionner le plugin sous Rails 3
ActionDispatch::Callbacks.to_prepare do
    # use require_dependency if you plan to utilize development mode
    require 'boards_watchers_patches'
end

ActionMailer::Base.default :skip_premailer => true

require 'premailer_ext/file_system_loader_extensions'

Redmine::Plugin.register :redmine_issue_reminder do
  name 'Redmine Issue Reminder plugin'
  author 'Ascendro S.R.L, Jethro'
  description 'Issue reminder plugin for Redmine, based on Ascendro\'s version https://github.com/ascendro/redmine_issue_reminde'
  version '3.0.0'
  url 'https://github.com/Hopebaytech/redmine_issue_reminder'

  permission :view_issue_reminder, :issue_reminders => :index

  settings( :default => { 'email_subject' => :default_email_subject},
            :partial => 'reminder_settings/issue_reminder_settings')
  
  project_module :issue_reminder do
    permission :view_issue_reminder, :issue_reminders => :index
  end
   
   if_proc = Proc.new{|project| project.enabled_module_names.include?('issue_reminder')}
  menu :project_menu,
  :issue_reminder,
  { :controller => 'issue_reminders', :action => 'index' },
  :caption => :issues_reminder,
  :last => true,
  #:after => :activity,
  :param => :project_id,
  :if => if_proc

#  menu :application_menu, :issue_reminder, { :controller => 'reminders', :action => 'index' }, :caption => :usses_reminder

end
