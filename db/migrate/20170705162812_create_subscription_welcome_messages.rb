class CreateSubscriptionWelcomeMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_welcome_messages do |t|
      t.text :text_message
      t.references :short_code, foreign_key: true

      t.timestamps
    end
  end
end
