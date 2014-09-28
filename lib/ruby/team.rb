class Team
  attr_accessor :name

  def initialize name
    @name = name
    raise Exception("Your team needs a name, people.") if @name == ""
  end

end
