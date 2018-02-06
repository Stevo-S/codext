class SendBatchMessageJob < ApplicationJob
  queue_as :default

  def perform(batch_message_id, unprocessed_short_codes = nil)
    @batch_message = BatchMessage.find(batch_message_id)
    unprocessed_short_codes ||= @batch_message.short_codes.pluck(:code)
    @current_short_code = ShortCode.find_by_code(unprocessed_short_codes.delete_at(0))
    uri = URI(Rails.application.secrets.gateway_send_url.to_s)

    @subscribers = @current_short_code.subscribers.where(active: true)
    @subscribers.each_slice(1000) do |s|
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

    # Re-run the job with the next short code, if any
    SendBatchMessageJob.new.perform_later(batch_message_id, unprocessed_short_codes) unless unprocessed_short_codes.empty?
  end
end
