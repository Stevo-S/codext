class RemoveSenderFromBatchMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :batch_messages, :sender
  end
end
