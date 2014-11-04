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
      let(:team) { game.teams[0] }

      it "should create teams" do
        expect(team).to be_a(Celebrity::Team)
      end

      it "should give teams a default score of 0" do
        expect(team.score).to eql 0
      end

      it "should assign players to teams evenly" do
        min_size, max_size = game.teams.map(&:length).minmax
        expect(max_size - min_size).to be <= 1
      end

      it "can start" do
        expect(game.can_start?).to be true
      end

      it "can tell me the current player" do
        binding.pry
        expect(game.current_player).to be_a(Celebrity::Player)
      end

      it "can tell me the next player"
      it "can tell me the round number"
      it "can tell me how many clues have been guessed this round"
      it "can tell me how many clues remain this round"
      it "can increment or decrement a team's score"
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
