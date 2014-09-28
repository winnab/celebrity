require_relative "../lib/ruby/team.rb"

describe Team do
  it "has a name" do
    expect(Team.new).to respond_to :name
  end

  it "has a list of players"
  it "has a set order for turns for players"
  it "has a score"

end
