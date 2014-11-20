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

      # it "sends invites"
      # it "detects when an invitee has responded"
      # it "detects when game is valid and can start"
    end
  end

  describe Celebrity::Game do
    let(:playersObj) {
      players.map do | p |
        { name: p, clues: 5.times.each_with_object([]) { | i, obj | obj << "#{p}-clue-#{i}"}  }
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
        expect(game.clues).to include("winna-clue-1")
      end

      it "sets the current player as the first player on the first team" do
        expect(game.current_player).to be_a(Celebrity::Player)
      end

      it "starts with a round that allows players to use as many words as they want" do
        expect(game.current_round.type).to eql('UNLIMITED_WORDS')
      end

      context "active round" do
        let(:round) { game.current_round }

        it "gives current player a turn" do
          expect(round.new_turn).to be_a(Celebrity::Turn)
        end

        context "active turn" do
          let(:turn) { round.new_turn }

          describe "#initialize" do
            it "creates a timer that is running" do
              expect(turn.timer.started?).to be true
              expect(turn.timer.finished?).to be false
            end
          end

          describe "#guessed_clue" do
            it "increases in score" do
              expect { turn.guessed_clue }.to change { turn.score }.from(0).to(1)
            end

            it "changes the clue" do
              expect { turn.guessed_clue }.to change { turn.current_clue }
            end

            it "moves current_clue from remaining to complete clues" do
              turn.guessed_clue
              expect(turn.remaining_clues).to_not include turn.current_clue
              expect(turn.completed_clues).to include turn.current_clue
            end
          end

          describe "#skipped_clue" do
            it "decreases the score" do
              expect { turn.skipped_clue }.to change { turn.score }.from(0).to(-1)
            end

            it "changes the clue" do
              expect { turn.skipped_clue }.to change { turn.current_clue }
            end

            it "moves current_clue to the end of remaining_clues" do
              clue_being_skipped = turn.current_clue

              turn.skipped_clue
              expect(turn.remaining_clues.last).to eq(clue_being_skipped)
              expect(turn.completed_clues).to_not include clue_being_skipped
            end
          end

        end

        describe "#next_player" do
          before(:each) { game.set_player_lineup }

          it "picks the next player in the lineup" do
            expect(game.next_player).to_not be(game.current_player)
            expect(game.next_player).to be(game.lineup[1])
          end

          it "loops back to the start of the lineup when needed" do
            game.current_player_ix = game.lineup.length - 1
            expect(game.next_player).to be(game.lineup[0])
          end
        end

        # it "knows the round number"
        # it "knows how many clues have been guessed this round"
        # it "knows how many clues remain this round"
        # it "increment or decrement a team's score"
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
