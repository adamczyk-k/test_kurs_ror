class ResourcesController < ApplicationController
  def index
    @user = current_user
    @resource = Resource.where(user: @user.id)
  end

  def show
    @user = current_user
    @resource = @user.resources.find(params[:id])
  end

  def new
    @user = current_user
    @resource = Resource.new
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      redirect_to resources_index_path(current_user.id)
    else
      flash[:alert] = @resource.errors.full_messages
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to resources_index_path(current_user.id)
  end

  def update
    @resource = Resource.find(params[:id])

    if @resource.update(resource_params)
      flash[:success] = 'Resource Updated'
      redirect_to @resource
    else
      render 'edit'
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:quantity, :resource_type_id)
  end
end
