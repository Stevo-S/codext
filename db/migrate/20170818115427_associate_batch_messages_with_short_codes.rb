class AssociateBatchMessagesWithShortCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :batch_messages_short_codes, id: false do |t|
	t.belongs_to :short_code, index: true
	t.belongs_to :batch_message, index: true
    end
  end
end
