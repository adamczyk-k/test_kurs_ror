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
    if dragons_limit
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

  def dragons_limit
    if current_user.dragons.count >= 5
      flash[:alert] = "You can't add more dragons"
      true
    else
      false
    end
  end

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
    resources = resources_amount
    resources.each do |resource|
      @resource = current_user.resources.find(resource.resource_type.id)
      user_amount = @resource.quantity
      @resource.update_attribute(:quantity, user_amount - resource.cost)
    end
  end

  def can_afford
    resources = resources_amount
    resources.each do |resource|
      user_amount = current_user.resources.find(resource.resource_type.id).quantity
      unless money?(user_amount, resource.cost)
        flash[:alert] = "User has #{user_amount} of #{resource.resource_type.name}, but needs #{resource.cost}"
        return false
      end
    end
    true
  end

  def resources_amount
    @dragon_type = params[:dragons_team][:dragon_type_id]
    @resource_type = DragonCost.where(dragon_type_id: @dragon_type)
    @resource_type
  end

  def money?(user_cost, resource)
    user_cost - resource >= 0
  end

  def dragon_params
    params.require(:dragons_team).permit(:name, :level, :dragon_type_id, :description)
  end
end
