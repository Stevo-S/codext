class SendBatchMessageJob < ApplicationJob
  queue_as :default

  def perform(batch_message_id)
    @batch_message = BatchMessage.find(batch_message_id)

    @batch_message.short_codes.each do |short_code|
	@current_short_code = short_code
	uri = URI(Rails.application.secrets.gateway_send_url.to_s)

	@subscribers = @current_short_code.subscribers.where(active: true)
	@subscribers.each_slice(Rails.application.secrets.maximum_recipients_per_sms_request) do |s|
	    send_sms_request = Net::HTTP::Post.new uri
	    send_sms_request.content_type = 'application/json'
	    sms_message = {
		destination: s.pluck(:phone_number),
		sender: @current_short_code.code,
		message: @batch_message.message_content
	    }


	    send_sms_request.body = sms_message.to_json
	    http = Net::HTTP.new(uri.host, uri.port)
	    http.use_ssl = true if uri.scheme == "https"
	    send_sms_response = http.request send_sms_request

	end

    end
  end
end
