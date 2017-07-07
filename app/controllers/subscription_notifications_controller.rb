class SubscriptionNotificationsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    wrap_parameters format: [:json]

    def index
	@subscription_notifications = SubscriptionNotification.all
    end

    def create
	phone_number = params[:phone_number]
	code = params[:short_code]
	notification_type = params[:notification_type]

	@short_code = ShortCode.find_by_code(code)
	if @short_code.nil? then
	    @short_code = ShortCode.new(code: code, activated: true)
	    @short_code.save
	end

	@subscriber = @short_code.subscribers.find_by_phone_number(phone_number)
	if @subscriber.nil? then
	    @subscriber = @short_code.subscribers.create(phone_number: phone_number,
		    first_subscribed_at: Time.now)
	end

	if notification_type == 'activation' then
	    @subscriber.active = true
	    @subscriber.last_subscribed_at = Time.now
	    @welcome_message = @short_code.subscription_welcome_message&.text_message
	    if @welcome_message.nil? then
	       @welcome_message = @short_code.create_subscription_welcome_message(
		       text_message: 'Welcome to ' + code + ' services.').text_message
	    end
	    response = OutboundMessage.new
	    response.destination = phone_number
	    response.text_message = @welcome_message
	    response.sender = code
	    response.save
	    SendSmsJob.perform_later(response.id)
	else
	    @subscriber.active = false
	    @subscriber.last_unsubscribed_at = Time.now
	end
	@subscription_notification = SubscriptionNotification.new(phone_number: phone_number, short_code: code,
		notification_type: notification_type)
	@subscription_notification.save
	@subscriber.save
	head :ok
    end
end
