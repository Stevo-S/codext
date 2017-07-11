class SubscribersController < ApplicationController
    def index
	page = params[:page]
	per_page = params[:per_page]
	@q = Subscriber.ransack(params[:q])
	@q.sorts = 'updated_at desc'
	@subscribers = @q.result(distinct: true).page params[:page]
    end
end
