class User
  class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index; end
  end
end
