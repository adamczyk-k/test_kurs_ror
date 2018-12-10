module Api
  class UsersController < ApplicationController
    def email_exists
      print "AAAAAAAAAAAAAAAAAAAAAAAa"
      render json: User.where(email: params[:email]).exists?
    end
  end
end