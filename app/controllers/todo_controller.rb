class TodoController < ApplicationController
	def index
		@user = User.find_by_email(session[:user_id])
	end
end
