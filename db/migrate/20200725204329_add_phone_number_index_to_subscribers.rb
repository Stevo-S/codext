class AddPhoneNumberIndexToSubscribers < ActiveRecord::Migration[5.1]
  def change
    add_index :subscribers, :phone_number
  end
end
