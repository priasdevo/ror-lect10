class MainController < ApplicationController
	def login
		session[:authen] = false
	end

	def relay
		username = params[:userid]
		pass = params[:password]
		#users = User.find(1)
		users = User.where(login: username)[0]
		if(users != nil and users.authenticate(pass))
			session[:userid] = users.id
			session[:authen] = true
			redirect_to :controller=>'main',:action=>'user_item'
		else
			redirect_to :controller=>'main',:action=>'login'
		end
	end

	def user_item
		@items = Item.where(user_id: session[:userid].to_i)
	end

	def inventories
		@inventories = Inventory.where(user_id: session[:userid].to_i)
	end

	def buy
		item_id = params[:id].to_i
		user_id = session[:userid].to_i
		inven = Inventory.new
		inven.user_id = user_id
		inven.item_id = item_id
		inven.price = Item.find(item_id).price
		inven.save

		item = Item.find(item_id)
		item.stock = item.stock-1
		item.save

		#redirect_to :controller=>'main',:action=>'inventories'
	end

end
