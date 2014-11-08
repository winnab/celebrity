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

      it "has teams" do
        expect(team).to be_a(Celebrity::Team)
      end

      it "gives teams default scores of 0" do
        expect(team.score).to eql 0
      end

      it "evenly assigns players to teams" do
        team_sizes = game.teams.collect { | t | t.players.length }
        min_size, max_size = team_sizes.minmax
        expect(max_size - min_size).to be <= 1
      end

      it "creates a collection of clues" do
        expect(game.clues).to be_an(Array)
      end

      it "can start" do
        expect(game.can_start?).to be true
      end

      context "active game" do
        let(:play) { Celebrity::Play.new(game) }
        it "should set the current player as the first player on the first team" do
          expect(play.current_player).to be_a(Celebrity::Player)
        end

        it "should start the first round by giving a turn the current player" do
          expect(play.current_round).to eql 1
        end

        it "should have all clues as remaining clues at the start of the first round" do
          expect(play.remaining_clues).to eql(game.clues)
        end

        it "should have zero completed clues at the start of the first round" do
          expect(play.completed_clues).to eql([])
        end

        it "gives a clue to the current player"
        it "knows the next player"
        it "knows the round number"
        it "knows how many clues have been guessed this round"
        it "knows how many clues remain this round"
        it "increment or decrement a team's score"
    end
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
