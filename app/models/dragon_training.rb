class DragonTraining < ApplicationRecord
  belongs_to :dragon
  belongs_to :training

  CHEAT_TIME = false

  def ended?
    CHEAT_TIME || start_time + training.duration.hour < Time.now
  end
end
