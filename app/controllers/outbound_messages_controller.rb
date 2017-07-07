class OutboundMessagesController < ApplicationController
  def index
    @outbound_messages = OutboundMessage.all
  end

  def show
    @outbound_message = OutboundMessage.find params[:id]
  end
end
