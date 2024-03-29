class SessionsController < ApplicationController
    skip_before_action :authorize, only: [:create, :destroy]

    def create
        user = User.find_by(username: params[:username])
    
        if user&.authenticate(params[:password])
          session[:id] = user.id
          render json: user, status: :created
        else
          render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
      end

    def destroy
        session.delete @current_user
        head :no_content
    end
end
