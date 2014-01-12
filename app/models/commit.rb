class Commit < ActiveRecord::Base
  attr_accessible :begin_time, :end_time, :spent_time, :item_id

  validates :begin_time, :presence => true
  validates :end_time, 	 :presence => true
  validates :spent_time, :presence => true

  belongs_to :item
end
