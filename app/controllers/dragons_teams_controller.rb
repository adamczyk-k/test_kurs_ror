class DragonsTeamsController < ApplicationController
  def index
    @view_model = UserHomePageViewModel.new
  end

  def show
    @view_model = UserHomePageViewModel.new
    @user = current_user
    @dragon = @user.dragons.find(params[:id])
  end

  def new
    @view_model = UserHomePageViewModel.new
    @user = current_user
    @dragon = Dragon.new
    # @dragon = current_user.dragon.build
  end

  def create
    if current_user.dragons.count >= 5
      flash[:alert] = "You can't add more dragons"
      redirect_to dragons_teams_index_path(current_user.id)
    elsif can_afford
      add_dragon
    else
      redirect_to dragons_teams_index_path(current_user.id)
    end
  end

  def destroy
    @dragon = Dragon.find(params[:id])
    @dragon.destroy
    redirect_to dragons_teams_index_path(current_user.id)
  end

  private

  def add_dragon
    @dragon = current_user.dragons.build(dragon_params)
    if @dragon.save
      pay_for_dragon
      redirect_to dragons_teams_index_path(current_user.id)
    else
      flash[:alert] = @dragon.errors.full_messages
    end
  end

  def pay_for_dragon
    resource, user_amount = resources_amount
    @resource = current_user.resources.find(resource.resource_type.id)
    @resource.update_attribute(:quantity, user_amount - resource.cost)
  end

  def can_afford
    resource, user_amount = resources_amount
    money?(user_amount, resource.cost)
  end

  def resources_amount
    @dragon_type = params[:dragons_team][:dragon_type_id]
    @resource_type = DragonCost.where(dragon_type_id: @dragon_type)
    @user_cost = current_user.resources.find(@resource_type[0].resource_type.id).quantity
    [@resource_type[0], @user_cost]
  end

  def money?(user_cost, resource)
    if user_cost - resource >= 0
      true
    else
      flash[:alert] = "User has #{user_cost} of #{resource_type.resource_type.name}, but needs #{@resource_type.cost}"
      false
    end
  end

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
