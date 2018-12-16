module Api
  class DragonsTeamsController < ApplicationController
    def index
      provider = DragonsProvider.new(current_user, params[:key])
      render json: provider.results
    end
  end
end
