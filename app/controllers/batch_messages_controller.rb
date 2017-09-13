class BatchMessagesController < ApplicationController

  protect_from_forgery
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    page = params[:page]
    per_page = params[:per_page]
    @q = BatchMessage.ransack(params[:q])
    @q.sorts = 'created_at desc'

    @batch_messages = @q.result(distinct: true).page params[:page]
  end

  def show
    @batch_message = BatchMessage.find(params[:id])
  end

  def new
    @batch_message = BatchMessage.new
    @batch_message.send_time = Time.now + 2.minutes
  end

  def create
    @batch_message = BatchMessage.create(batch_message_params)
    @batch_message.short_codes << ShortCode.find(params[:batch_message][:short_code_ids].reject(&:empty?))
    if @batch_message.save then
	SendBatchMessageJob.set(wait_until: @batch_message.send_time).perform_later(@batch_message.id)
    end

    redirect_to @batch_message
  end

  def edit
    @batch_message = BatchMessage.find(params[:id])
  end

  private
  def batch_message_params
    params.require(:batch_message).permit(:message_content, :send_time) 
  end
end
