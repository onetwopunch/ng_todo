module API
	class UserAPI < Grape::API
		resource 'users' do 

			params do
				requires :token, type: String, desc: 'User Token'
			end
			route_param :token do
				get do
					::User.find_by_token(params[:token])
				end
			end
		end
	end
end
