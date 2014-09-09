module API
	class TodoAPI < Grape::API

		resource :user_todos do
			params do
				requires :user_id, type: Integer, desc: 'User Id'
			end
			route_param :user_id do
				get do
					::User.find(params[:user_id]).todos
				end
			end
		end

		resource :todo do 
			params do 
				requires :id, type: Integer, desc: 'Todo Id'
			end

			route_param :id do 
				get do
					::Todo.find(params[:id])
				end
			end
		end
	end
end
