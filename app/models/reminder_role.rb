class ReminderRole < ActiveRecord::Base
  unloadable
  belongs_to :mail_reminder
  belongs_to :role
end
