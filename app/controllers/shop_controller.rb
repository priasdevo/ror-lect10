class ShopController < ApplicationController
	def show
		@items = Item.where(user_id: params[:id].to_i)
	end

end
