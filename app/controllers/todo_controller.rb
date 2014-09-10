class TodoController < ApplicationController
	before_filter :redirect_to_login
	def index
		@user = User.find_by_email(session[:user_id])
	end
end
