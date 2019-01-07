class TrainingsController < ApplicationController
  def index
    @training_type = Training.all
  end
end
