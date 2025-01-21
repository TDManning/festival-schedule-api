module Api
  module V1
    class UserShowsController < ApplicationController
      before_action :find_user

      def index
        render json: ShowSerializer.new(@user.shows)
      end

      def create
        result = @user.add_show_to_schedule(params[:show_id], params[:favorited] || false)

        if result[:success]
          render json: ShowSerializer.new(result[:success].show), status: :created
        else
          render json: ErrorSerializer.format(result[:error]), status: result[:status]
        end
      end

      def destroy
        user_show = @user.users_shows.find_by!(show_id: params[:id])
        user_show.destroy
        head :no_content
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
