require "spec_helper"
require_relative "../../app/controllers/joins_controller"

describe CelebrityApp do
  it "allows players to join" do
    post "/join/abc"
    expect(last_response.status).to eql(302)
    expect(last_response.header["location"]).to include('/game_overview/abc')
  end
end
