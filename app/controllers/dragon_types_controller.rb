class DragonTypesController < ApplicationController
  def new
    @dragon_type = DragonType.new
  end

  def index
    @dragon_type = DragonType.all
  end

  def show
    @dragon_type = DragonType.find(params[:id])
  end

  def edit
    @dragon_type = DragonType.find(params[:id])
  end

  def create
    # render plain: params[:dragon_types].inspect
    # @dragon_type = DragonType.new(params[:dragon_types])
    @dragon_type = DragonType.new(dragon_type_params)
    if @dragon_type.save
      redirect_to @dragon_type
    else
      render 'new'
    end
  end

  def update
    @dragon_type = DragonType.find(params[:id])
    render plain: params[:dragon_types].inspect
    /if @dragon_type.update(dragon_type_params)
      redirect_to @dragon_type
    else
      render 'edit'
    end/
  end

  def destroy
    @dragon_type = DragonType.find(params[:id])
    @dragon_type.destroy

    redirect_to dragon_types_path
  end

  private

  def dragon_type_params
    params.require(:dragon_types).permit(:name, :description)
  end
end
