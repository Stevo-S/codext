class CreateOutboundMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :outbound_messages do |t|
      t.string :destination, limit: 16
      t.text :text_message
      t.string :sender, limit: 11
      t.string :linkid

      t.timestamps
    end
  end
end
