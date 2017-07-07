class Subscriber < ApplicationRecord
  belongs_to :short_code

  validates :phone_number, presence: true
end
