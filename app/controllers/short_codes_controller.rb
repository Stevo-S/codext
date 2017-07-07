class ShortCodesController < ApplicationController
    def index
	@short_codes = ShortCode.all
    end

    def new
	@short_code = ShortCode.new
    end

    def create
	@short_code = ShortCode.new(short_code_params)
    	
    	@short_code.save
	redirect_to @short_code
    end

    def show
	@short_code = ShortCode.find(params[:id])
    end

    private
    def short_code_params
	params.require(:short_code).permit(:code, :activated)
    end
end
