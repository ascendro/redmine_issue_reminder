require 'redmine'

Redmine::Plugin.register :redmine_issue_reminder do
  name 'Redmine Issue Reminder plugin'
  author 'Ascendro S.R.L'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/ascendro/redmine_issue_reminder'
  author_url 'http://www.ascendro.ro/'
   settings :default => { 
							:email_subject  => 'Redmine Issue Reminder', 
						}
						
   project_module :issue_reminder do	
		permission :modify_reminder
   end
   
   menu :project_menu, :blabla, { :controller => :blabla, :action => :show }, :caption => :label_backlogs, :param => :project_id
end