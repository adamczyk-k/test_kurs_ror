module Api
  class UserController < ApplicationController
    def email_exists?
      render json: User.where(email: params[:email]).exists?
    end
  end
end