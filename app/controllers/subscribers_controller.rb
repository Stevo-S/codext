class SubscribersController < ApplicationController
    def index
	page = params[:page]
	per_page = params[:per_page]
	@q = Subscriber.ransack(params[:q])
	@subscribers = @q.result(distinct: true).page params[:page]
    end
end
