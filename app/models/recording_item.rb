class RecordingItem < ActiveRecord::Base
  attr_accessible :record_beginning_at, :item_id

  belongs_to :item
end
