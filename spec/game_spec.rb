require "game"
require "pry"
describe Celebrity do
  let(:players) { ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"] }
  describe Celebrity::Invite do
    let(:recipients) {
      players.map do | p |
        { name: p, email: "#{p}.my_email@example.com"  }
      end
     }
    let(:sender) { { email: "test@example.com", name: "Sophie" } }
    let(:invite) { Celebrity::Invite.new(sender, recipients) }
    context "valid invite" do
      it "has a sender with a name and email address" do
        expect(invite.has_sender?).to be true
      end

      it "has valid recipients" do
        expect(invite.has_valid_recipients?).to be true
      end

      it "sends invites"
      it "detects when an invitee has responded"
      it "detects when game is valid and can start"


    end
  end

  describe Celebrity::Game do
    let(:playersObj) {
      players.map do | p |
        { name: p, clues: 5.times.each_with_object([]) { | i, obj | obj << "clue-#{i}"}  }
      end
     }
    let(:num_teams) { 2 }
    let(:game) { Celebrity::Game.new(playersObj, num_teams) }

    context "valid game" do
      it "should create teams" do
        expect(game).to respond_to(:teams)
      end

      it "should assign players to teams evenly" do
        min_size, max_size = game.teams.map(&:length).minmax
        expect(max_size - min_size).to be <= 1
      end

      it "can start" do
        expect(game.can_start?).to be true
      end

      it "displays a clue to a player"
    end

    context "invalid game" do
      context "having fewer than 6 players" do
        let(:game) { Celebrity::Game.new(playersObj[0, 4], num_teams) }

        it "cannot be started" do
          expect(game.can_start?).to be false
        end
      end
      context "having an insufficient number of clues" do
        let(:playersObj) {
          players.map do | p |
            { name: p, clues: 3.times.each_with_object([]) { | i, obj | obj << "clue-#{i}"}  }
          end
         }

        it "cannot start" do
          expect(game.can_start?).to be false
        end
      end
    end

  end
end
