class Item < ActiveRecord::Base
  attr_accessible :estimated_time, :name
  
  has_many :commits
  has_one :recording_item
  belongs_to :user
  
  # should return an string with format #h#m#s (hours, minutes, seconds)  
  def self.format_time seconds
    hours = seconds / 3600
    seconds = seconds%3600
    minutes = seconds / 60
    seconds = seconds % 60
    
    if minutes+seconds == 0
      hours.to_s + "h"
    elsif seconds == 0
      '%02dh%02dm' % [hours, minutes]
    elsif minutes == 0
      '%02dh%02ds' % [hours, seconds]      
    else
      '%02dh%02dm%02ds' % [hours, minutes, seconds]
    end
  end
  
  # this method should return the number of seconds commited today for all the items
  def self.today_time
    beginning_in = DateTime.now.beginning_of_day
    deadline = DateTime.now.end_of_day
    seconds = Commit.where("end_time < ? and begin_time > ?", deadline, beginning_in).sum(:spent_time)
    format_time seconds
  end

  # this method should return the number of seconds commited this week for all the items
  def self.week_time
    week_begin = DateTime.now.beginning_of_week
    deadline = DateTime.now.end_of_week
    seconds = Commit.where("end_time < ? and begin_time > ?", deadline, week_begin).sum(:spent_time)
    format_time seconds
  end
  
  # this method should return the answer in minutes
  def calculate_week_time
    actual_item = Item.find self.id
    week_begin = DateTime.now.beginning_of_week
    deadline = DateTime.now.end_of_week
    actual_item.commits.where("end_time < ? and begin_time > ?", deadline, week_begin).sum(:spent_time)/60
  end
end
