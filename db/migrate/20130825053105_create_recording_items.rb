class CreateRecordingItems < ActiveRecord::Migration
  def change
    create_table :recording_items do |t|
      t.datetime :record_beginning_at

      t.timestamps
    end
  end
end
