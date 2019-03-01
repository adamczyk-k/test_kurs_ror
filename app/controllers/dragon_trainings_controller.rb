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
    flash[:alert] = resolve_training

    redirect_to user_root_path(current_user.id)
  end

  def resolve_training
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
    @dragon = Dragon.find(params[:dragon_trainings][:dragon_id])
    @training = Training.find(params[:format])
    training_creation_result = process_expedition
    flash[:alert] = training_creation_result unless training_creation_result.empty?

    redirect_to trainings_index_path(current_user.id)
  end

  def process_expedition
    assignment = @dragon.busy?
    if assignment.empty?
      create_expedition
    else
      assignment
    end
  end

  def create_expedition
    if !current_user.can_afford?(@training)
      current_user.missing_resources_for_error(@training)
    else
      AddTraining.run!(user: current_user, dragon: @dragon, training: @training)
    end
  end
end
