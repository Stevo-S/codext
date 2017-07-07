class CreateSubscriptionNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_notifications do |t|
      t.string :phone_number, limit: 16
      t.string :short_code, limit: 6
      t.string :type, limit: 15

      t.timestamps
    end
  end
end
