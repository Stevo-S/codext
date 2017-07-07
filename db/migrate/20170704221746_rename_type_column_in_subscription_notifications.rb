class RenameTypeColumnInSubscriptionNotifications < ActiveRecord::Migration[5.1]
  def change
    rename_column :subscription_notifications, :type, :notification_type
  end
end
