class DragonTypesController < ApplicationController
  def new

  end

  def create
    render plain: params[:dragon_types].inspect
  end
end
