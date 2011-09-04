require "date"

class Reminder < ActiveRecord::Base
  unloadable

  WEEKLY_INTERVAS = Date::DAYNAMES
  MONTHLY_INTERVALS = [1..31]

  has_many :reminder_roles
  has_many :roles, :through => :reminder_roles
  belongs_to :query

  def self.intervals
    [:daily, :weekly, :monthly]
  end

  def self.daily_intervals
    [:every_day,
     :every_second_day,
     :every_third_day,
     :every_fourth_day,
     :every_fifth_day,
     :every_sixth_day]
  end

  def self.weekly_intervals
    Date::DAYNAMES
  end

  def self.monthly_intervals
    (1..31).to_a
  end

  def self.interval_values_for(interval)
    case interval
    when("daily")
      daily_intervals.each_with_index.collect {|val,idx| [l(val), idx]}
    when("weekly")
      weekly_intervals.each_with_index.collect {|val,idx| [l(:every_weekly_format) % l(val.downcase.to_sym), idx]}
    when("monthly")
      monthly_intervals.each_with_index.collect {|val,idx| [l(:every_of_month_format) % val, idx]}
    else
      []
    end
  end

  def remind?(reminder_type, reminder_value)
    case reminder_type
    when 0
      daily_remind?(reminder_value)
    when 1
      weekly_remind?(reminder_value)
    when 3
      monthly_remind?(reminder_value)
    else
      false
    end
  end

end
