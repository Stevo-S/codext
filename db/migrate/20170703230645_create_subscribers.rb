class CreateSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribers do |t|
      t.string :phone_number, limit: 16
      t.boolean :active
      t.datetime :first_subscribed_at
      t.datetime :last_subscribed_at
      t.datetime :last_unsubscribed_at
      t.references :short_code, foreign_key: true

      t.timestamps
    end
  end
end
