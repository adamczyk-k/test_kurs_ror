class DragonsProvider
  attr_reader :results

  def initialize(key)
    @results = Dragon.all
    filter_by_key(key)
  end

  def filter_by_key(key)
    @results = if key.nil?
                 @results
               elsif key == ''
                 []
               else
                 @results.where('lower(name) like ?', "%#{key.downcase}%")
               end
  end
end