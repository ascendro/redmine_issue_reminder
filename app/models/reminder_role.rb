class ReminderRole < ActiveRecord::Base
  unloadable
  belongs_to :reminder
  belongs_to :role
end
