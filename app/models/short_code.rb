class ShortCode < ApplicationRecord
    has_many :subscribers
    has_one :subscription_welcome_message
end
