class BatchMessage < ApplicationRecord
    has_and_belongs_to_many :short_codes

    validates :message_content, presence: true
    validate :send_time_cannot_be_in_the_past

    def send_time_cannot_be_in_the_past
	if send_time.present? && send_time < Time.now then
	    errors.add(:send_time, " can't be in the past")
	end
    end
end
