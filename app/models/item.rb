class Item < ActiveRecord::Base
  attr_accessible :estimated_time, :name
  
  has_many :commits
  
  # should return an string with format #h#m#s (hours, minutes, seconds)  
  def self.format_time seconds
    hours = seconds/3600
    seconds = seconds%3600
    minutes = seconds/60
    seconds = seconds%60
    if minutes+seconds == 0
      hours.to_s + "h"
    elsif seconds == 0
      '%02dh%02dm' % [hours, minutes]
    else
      '%02dh%02dm%02ds' % [hours, minutes, seconds]
    end
  end
  
  def self.today_time
    beginning_in = DateTime.now.beginning_of_day
    deadline = DateTime.now.end_of_day
    seconds = Commit.where("end_time < ? and begin_time > ?", deadline, beginning_in).sum(:spent_time)
    format_time seconds    
  end
  
  def self.week_time
    week_begin = DateTime.now.beginning_of_week
    deadline = DateTime.now.end_of_week
    seconds = Commit.where("end_time < ? and begin_time > ?", deadline, week_begin).sum(:spent_time)
    format_time seconds
  end
  
  # this should return the answer in minutes
  def calculate_week_time
    actual_item = Item.find self.id
    week_begin = DateTime.now.beginning_of_week
    deadline = DateTime.now.end_of_week
    actual_item.commits.where("end_time < ? and begin_time > ?", deadline, week_begin).sum(:spent_time)/60
  end
end
