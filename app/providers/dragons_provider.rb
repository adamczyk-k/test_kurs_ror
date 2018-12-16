class DragonsProvider
  attr_reader :results

  def initialize(current_user, key)
    @results = Dragon.where(user: current_user)
    filter_by_key(key)
  end

  def filter_by_key(key)
    @results = if key == ''
                 @results
               else
                 @results.search(key)
               end
  end
end
