class CounterController < ApplicationController

  def index
    @items = Item.all
  end

  def record_time
  end
  
  def stop_recording
  end
  
  def commit_time
  end
  
  def calculate_week_time item_id
    actual_item = Item.find item_id
    week_begin = DateTime.now.beginning_of_week
    deadline = DateTime.now.end_of_week
    actual_item.first.commits.where("end_time < ? and begin_time > ?", deadline, week_begin).sum(spent_time)
  end

end
