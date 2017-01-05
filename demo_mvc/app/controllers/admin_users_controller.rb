class AdminUsersController < ApplicationController

	layout 'admin'

	before_action :confirm_logged_in
	before_action :find_user, :only => [:edit, :update, :delete, :destroy]
	# before_action :set_user_count, :only => [:new, :create, :edit, :update]

	def index
		@users = AdminUser.sorted
	end

	def new
		@admin_user = AdminUser.new()
	end

	def create
		@admin_user = AdminUser.new(user_params)
		if @admin_user.save
			flash[:notice] = "Created new user"
			redirect_to(admin_users_path)
		else
			flash[:error] = "Failed to create user"
			render("new")
		end
	end

	def edit
	end

	def update
		if @admin_user.update_attributes(user_params)
			flash[:notice] = "Updated user " + @admin_user.username
			redirect_to(admin_users_path)
		else
			flash[:error] = "Failed to update user " + @admin_user.username
			render("edit")
		end
	end

	def delete
	end

	def destroy
		if @admin_user.destroy
			flash[:notice] = "Deleted user " + @admin_user.username
			redirect_to(admin_users_path)
		end
	end

	private

	def find_user
		@admin_user = AdminUser.find(params[:id])
	end

	def set_user_count
		@user_count = AdminUser.count
		if params[:action] == 'new' || params[:action] == 'create'
			@user_count += 1
		end
	end

	def user_params
		params.require(:admin_user).permit(:first_name, :last_name, :username, :email, :password)
	end

end
