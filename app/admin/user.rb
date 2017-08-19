ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
    permit_params :name, :email, :password, :password_confirmation, short_code_ids: []

    form do |f|
	f.inputs "User Details" do
	    f.inputs :name
	    f.inputs :email
	    if f.object.new_record?
		f.inputs :password
		f.inputs :password_confirmation
	    end

	    f.input :short_codes, as: :check_boxes, collection: ShortCode.pluck(:code, :id)
	end

	f.actions
    end

    
    show do
	attributes_table do
	    row :name
	    row :email
	    row :encrypted_password
	    row :reset_password_token
	    row :reset_password_sent_at
	    row :remember_created_at
	    row :current_sign_in_at
	    row :last_sign_in_at
	    row :current_sign_in_ip
	    row :last_sign_in_ip
	    row :failed_attempts
	    row :unlock_token
	    row :locked_at
	    row :created_at
	    row :updated_at

	    row "Short Codes" do |u|
		(u.short_codes.map{ |sc| sc.code }).join(', ')
	    end
	end
    end
end
