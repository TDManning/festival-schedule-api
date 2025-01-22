module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.includes(users_shows: :show)
        render json: UserSerializer.new(users)
      end 
    end
  end
end
