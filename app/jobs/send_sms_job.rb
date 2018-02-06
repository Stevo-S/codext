require 'net/http'

class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    @message = OutboundMessage.find(message_id)
    uri = URI(Rails.application.secrets.gateway_send_url.to_s)
    send_sms_request = Net::HTTP::Post.new uri
    send_sms_request.content_type = 'application/json'
    sms_message = {
	destination: [@message.destination],
	sender: @message.sender,
	message: @message.text_message,
	linkId: @message.linkid
    }


    send_sms_request.body = sms_message.to_json
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    send_sms_response = http.request send_sms_request
  end
end
