class DragonTrainingsController < ApplicationController
  def new
    @dragon_training = DragonTraining.new
    @training = Training.find(params[:format])
    @training_cost = TrainingCost.where(training: @training)
  end

  def create
    dragon = Dragon.find(params[:dragon_trainings][:dragon_id])
    training = Training.find(params[:format])
    process_training_creation(dragon, training)

    redirect_to dragons_teams_index_path(current_user.id)

  end

  def process_training_creation(dragon, training)
    if !current_user.can_afford?(training)
      flash[:alert] = current_user.missing_resources_for_error(training)
    else
      AddTraining.run!(user: current_user, dragon: dragon, training: training)
    end
  end
end
