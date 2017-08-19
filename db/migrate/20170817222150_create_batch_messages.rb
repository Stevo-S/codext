class CreateBatchMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :batch_messages do |t|
      t.text :message_content
      t.string :sender, limit: 5
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
