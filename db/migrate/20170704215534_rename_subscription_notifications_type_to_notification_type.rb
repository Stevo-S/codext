class RenameSubscriptionNotificationsTypeToNotificationType < ActiveRecord::Migration[5.1]
  def change_table 
    change_table :subscription_notifications do |t|
	t.reame :type, :notification_type
    end
  end
end
