module API
	class UserAPI < Grape::API
		resource 'users' do 

			params do
				requires :id, type: Integer, desc: 'User Id'
			end
			route_param :id do
				get do
					::User.find(params[:id])
				end
			end
		end
	end
end
