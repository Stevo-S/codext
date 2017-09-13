class AddSendTimeToBatchMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :batch_messages, :send_time, :datetime
  end
end
