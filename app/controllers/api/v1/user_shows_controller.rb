module Api
  module V1
    class UserShowsController < ApplicationController
      before_action :find_user

      def index
        render json: ShowSerializer.new(@user.shows)
      end

      def create
        result = @user.add_show_to_schedule(params[:show_id])
        if result[:error]
          render json: ErrorSerializer.format(result[:error]), status: result[:status]
        else
          render json: ShowSerializer.new(result[:success].show), status: :created
        end
      end      

      def destroy
        user_show = @user.users_shows.find_by!(show_id: params[:id])
        user_show.destroy
        render json: { message: "Show successfully removed from schedule" }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: ErrorSerializer.format('Show not found in schedule'), status: :not_found
      end
      
      private

      def find_user
        @user = User.find_with_error_handling(params[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: ErrorSerializer.format(e.message), status: :not_found
      end
    end
  end
end
