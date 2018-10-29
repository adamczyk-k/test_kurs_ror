class ResourceTypesController < ApplicationController
  def index
    @resource_type = ResourceType.all
  end

  def show
    @resource_type = ResourceType.find(params[:id])
  end

  private

  def resource_type_params
    params.require(:resource_types).permit(:name, :description)
  end
end
