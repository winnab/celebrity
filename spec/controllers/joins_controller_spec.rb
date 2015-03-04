require "spec_helper"
require_relative "../../app/controllers/joins_controller"

describe CelebrityApp do
  it "allows players to join" do
    app.post "/joins"
    expect(last_response.status).to eql(200)
  end

  # edge cases (ie post from curl or empty form etc)
  # when someone joins after game ends
end
