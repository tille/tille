class Item < ActiveRecord::Base
  attr_accessible :estimated_time, :name

  validates :name,           :presence => true
  validates :estimated_time, :presence => true, :numericality => true

  has_many   :commits
  has_one    :recording_item
  belongs_to :user

  # should return an string with format #h/#m/#s (hours, minutes, seconds)
  def self.format_time seconds
    hours   = seconds / 3600
    seconds = seconds%3600
    minutes = seconds / 60
    seconds = seconds % 60

    if minutes+seconds == 0
      hours.to_s + "h"
    elsif seconds == 0
      '%dh/%dm' % [hours, minutes]
    elsif minutes == 0
      '%dh/%ds' % [hours, seconds]
    else
      '%dh/%dm/%ds' % [hours, minutes, seconds]
    end
  end

  # this method return the time commited today in format #h#m#s
  def self.today_time
    format_time today_seconds
  end

  # this method should return the seconds commited today
  def self.today_seconds
    beginning_in = DateTime.now.utc.beginning_of_day
    deadline     = DateTime.now.utc.end_of_day
    Commit.where("begin_time > ? and end_time < ?", beginning_in, deadline).sum(:spent_time)
  end

  # this method return the time commited this week in format #h/#m/#s
  def self.week_time
    format_time week_seconds
  end

  # this method should return the seconds commited this week
  def self.week_seconds
    week_begin = DateTime.now.utc.beginning_of_week
    deadline   = DateTime.now.utc.end_of_week
    Commit.where("begin_time > ? and end_time < ?", week_begin, deadline).sum(:spent_time)
  end

  # this method return the seconds commited by one item (self) this week
  def calculate_week_time
    week_begin = DateTime.now.utc.beginning_of_week
    deadline   = DateTime.now.utc.end_of_week
    self.commits.where("begin_time > ? and end_time < ?", week_begin, deadline).sum(:spent_time)
  end
end
