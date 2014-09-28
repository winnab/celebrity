class Team
  attr_accessor :name

  def initialize name
    @name = name
    raise Exception if !@name
  end

end
