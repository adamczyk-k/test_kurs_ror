class UserHomePageViewModel
  cattr_accessor :current_user

  def dragons_team
    @user = current_user
    @dragon = Dragon.where(user: @user.id)
  end

  def resources
    @user = current_user
    @resource = Resource.where(user: @user.id)
  end

  def expeditions
    @expedition = Expedition.where(user: @current_user.id)
  end

  def trainings
    dragons = current_user.dragons
    @trainings = DragonTraining.where(dragon: dragons)
  end
end
