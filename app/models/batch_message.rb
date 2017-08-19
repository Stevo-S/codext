class BatchMessage < ApplicationRecord
    has_and_belongs_to_many :short_codes
end
