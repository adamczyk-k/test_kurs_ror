class User
  class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index
      @view_model = UserHomePageViewModel.new
      @number_o_ranks = 3
      @users = user_ranking(@number_o_ranks)
    end

    def user_ranking(number_o_ranks)
      User.find_by_sql ['
	    SELECT
		  id, email, experience,
		ntile(?) OVER (
		  ORDER BY experience DESC
		) AS ranking
		FROM users', number_o_ranks]
    end
  end
end
