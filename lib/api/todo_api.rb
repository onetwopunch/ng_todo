module API
	class TodoAPI < Grape::API

		resource :user_todos do
			params do
				requires :token, type: String, desc: 'User Token'
			end
			route_param :token do
				get do
					::User.find_by_token(params[:token]).todos
				end
			end
		end

		resource :todo do 

      post :new do
				t = ::Todo.new
				t.name = params[:todo]
        t.is_complete = false
        t.save
        user = ::User.find_by_token(params[:token])
				user.todos << t
				{success: !!user, todos: user.todos}
			end

			put :check do
				todo = ::Todo.find(params[:id])
				todo.is_complete = params[:complete] == 'true'
        if todo.save
					{success: true}
				else
					{success: false}
				end
			end

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
