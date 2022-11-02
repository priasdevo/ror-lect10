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

	def relay2
		@item = Item.find(params[:id].to_i)
		respond_to do |format|
	      if @item.update(item_params)
	        format.html { redirect_to '/main/user_item', notice: "Item was successfully updated." }
	        format.json { render :show, status: :ok, location: @item }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	        format.json { render json: @item.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def edit_item
		if(!session[:authen])
			redirect_to :controller=>'main',:action=>'login'
		end
		@item = Item.find(params[:id])
	end

	def user_item
		if(!session[:authen])
			redirect_to :controller=>'main',:action=>'login'
		end
		@items = Item.where(user_id: session[:userid].to_i)
	end

	def inventories
		if(!session[:authen])
			redirect_to :controller=>'main',:action=>'login'
		end
		@inventories = Inventory.where(user_id: session[:userid].to_i)
	end

	def buy
		item_id = params[:id].to_i
		user_id = session[:userid].to_i
		inven = Inventory.new
		inven.user_id = user_id
		inven.item_id = item_id
		inven.price = Item.find(item_id).price
		inven.timestamp = DateTime.now
		inven.save
		item = Item.find(item_id)
		item.stock = item.stock-1
		item.save

		redirect_to :controller=>'main',:action=>'inventories'
	end

	def item_params
      params.require(:item).permit(:user_id, :name, :price, :stock)
    end

end
