class ShortCode < ApplicationRecord
    has_many :subscribers
    has_one :subscription_welcome_message

    has_and_belongs_to_many :users
    has_and_belongs_to_many :batch_messages
end
