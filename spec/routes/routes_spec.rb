require "spec_helper"

describe CelebrityApp do
  let!(:game) { Game.new({name: "Test", clues: []})}

  describe "post /game_overview" do
    it "creates a game" do
      post "/game_overview", { creator_name: "test" }
      game = app.settings.game_store.list.last
      expect(last_response.status).to eql(302)
      expect(last_response.header["location"]).to include("/game_overview/#{game.id}")
    end
  end

  it "allows players to join" do
    new_player = {
      name: "Test",
      email: "test@example.com",
      clues: ["a", "a", "a", "a", "a"]
    }
    new_invite = Invite.new({
        name: "Tob",
        email: "tob@example.com"
      }, {
        name: new_player[:name],
        email: new_player[:email]
      },
      game.id
    )
    app.settings.game_store.add(game)
    app.settings.invite_store.add(new_invite)
    post "/join/#{game.id}/#{new_player[:email]}"
    expect(last_response.status).to eql(302)
    expect(last_response.header["location"]).to include("/game_overview/#{game.id}")
  end

end
