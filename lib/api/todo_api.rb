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
	todo = ::Todo.find(params[:todo][:id])
	if params[:token] == todo.user.private_token
	  todo.is_complete = params[:todo][:is_complete]
	  if todo.save
	    {success: true}
	  else
	    {success: false}
	  end
	end
      end

      post :delete do
	todo = ::Todo.find params[:id]
	if params[:token] == todo.user.private_token
	  if todo.destroy
	    {success: true, todos: todo.user.todos}
	  else
	    {success:false, error: (todo.errors.messages rescue "Something went wrong")}
	  end
	else
	  {success: false, error: 'You are not authenticated to delete this todo'}
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
