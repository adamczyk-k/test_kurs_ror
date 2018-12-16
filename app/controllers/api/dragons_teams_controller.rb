module Api
  class DragonsTeamsController < ApplicationController
    def index
      provider = DragonsProvider.new(params[:key])
      render json: provider.results
    end
  end
end
