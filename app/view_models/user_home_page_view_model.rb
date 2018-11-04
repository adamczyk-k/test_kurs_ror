class UserHomePageViewModel
  cattr_accessor :current_user

  def dragons_team
    @user = current_user
    @dragon = Dragon.where(user: @user.id)
  end
end
