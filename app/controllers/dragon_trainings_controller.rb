class DragonTrainingsController < ApplicationController
  def new
    @dragon_training = DragonTraining.new
    @training = Training.find(params[:format])
    @training_cost = TrainingCost.where(training: @training)
    @training_prize = TrainingPrize.where(training: @training)
  end

  def index
    dragons = current_user.dragons
    @trainings = DragonTraining.where(dragon: dragons)
  end

  def destroy
    flash[:alert] = resolve_expedition

    redirect_to dragon_trainings_index_path(current_user.id)
  end

  def resolve_expedition
    @training = DragonTraining.find(params[:id])
    @dragon = @training.dragon
    if @training.ended?
      alert = @dragon.prize_from_training(TrainingPrize.where(training: @training.training))
      @training.destroy
      alert
    else
      "#{@training.dragon.name}'s training ongoing"
    end
  end

  def create
    dragon = Dragon.find(params[:dragon_trainings][:dragon_id])
    training = Training.find(params[:format])
    process_training_creation(dragon, training)

    redirect_to dragons_teams_index_path(current_user.id)
  end

  def process_training_creation(dragon, training)
    if !DragonTraining.find_by(dragon: dragon).nil?
      flash[:alert] = "#{dragon.name} is already on training"
    elsif !current_user.can_afford?(training)
      flash[:alert] = current_user.missing_resources_for_error(training)
    else
      AddTraining.run!(user: current_user, dragon: dragon, training: training)
    end
  end
end
