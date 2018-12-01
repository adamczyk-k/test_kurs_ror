class User
  class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
      @view_model = UserHomePageViewModel.new
    end
  end
end
