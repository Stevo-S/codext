class SubscribersController < ApplicationController

    protect_from_forgery
    before_action :authenticate_user!
    load_and_authorize_resource 

    def index
	page = params[:page]
	per_page = params[:per_page]
	@q = Subscriber.ransack(params[:q])
	@q.last_subscribed_at_gteq = Date.today.midnight unless params[:q]
	@q.sorts = 'updated_at desc'
	@subscribers = @q.result(distinct: true).page params[:page]

	if params[:q].nil? then
	    params[:q] = { last_subscribed_at_gteq: Date.today.midnight.strftime('%FT%T'),
	   	last_subscribed_at_lteq: Date.tomorrow.strftime('%FT%T') }
	end
    end
end
