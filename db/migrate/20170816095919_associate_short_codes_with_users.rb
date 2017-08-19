class AssociateShortCodesWithUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :short_codes_users, id: false do |t|
	t.belongs_to :short_code, index: true
	t.belongs_to :user, index: true
    end
  end
end
