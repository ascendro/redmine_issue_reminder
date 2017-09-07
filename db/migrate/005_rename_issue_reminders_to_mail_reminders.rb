class RenameIssueRemindersToMailReminders < ActiveRecord::Migration
  def self.up
    rename_table :issue_reminders, :mail_reminders
  end

 def self.down
    rename_table :mail_reminders, :issue_reminders
 end
end