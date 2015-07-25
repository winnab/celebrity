require_relative "../../app/core/game"
require_relative "../../app/core/player"
require_relative "../../app/core/team"
require_relative "../../app/core/round"
require_relative "../../app/core/turn"
require "spec_helper"

describe Turn do
  before do
    game_store = GameStore.new
    game_store.add(Game.new)
    @game = game_store.list.last
    num_teams = 2

    player_store = PlayerStore.new
    player_names = ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"]

    player_names.each do |name|
      player_store.add(Player.new(@game.id, name))
    end

    player_names.each do | name |
      clues = 5.times.map { | num | "#{name}-clue-#{num + 1}" }
      game_store.add_clues_to_game(@game.id, clues)
    end

    @game.start(player_store.find_all_by_game_id(@game.id), num_teams)
  end

  context "active turn" do
    let(:turn) { @game.current_round.new_turn }

    describe "#initialize" do
      it "creates a timer that is running" do
        expect(turn.timer.started?).to be true
      end

      it "creates a timer that is not finished" do
        expect(turn.timer.finished?).to be false
      end

      it "is subscribed to the timer" do
        expect(turn.timer.count_observers).to be(1)
      end
    end

    describe "#guessed_clue" do
      it "increases in score" do
        expect { turn.guessed_clue }.to change { turn.score }.from(0).to(1)
      end

      it "changes the clue" do
        expect { turn.guessed_clue }.to change { turn.current_clue }
      end

      describe "changes clues methods" do
        before(:each) { turn.guessed_clue }

        it "adds current_clue to complete clues" do
          expect(turn.completed_clues).to include turn.current_clue
        end

        it "removes current_clue from remaining clues" do
          expect(turn.remaining_clues).to_not include turn.current_clue
        end
      end
    end

    describe "#skipped_clue" do
      it "decreases the score" do
        expect { turn.skipped_clue }.to change { turn.score }.from(0).to(-1)
      end

      it "changes the clue" do
        expect { turn.skipped_clue }.to change { turn.current_clue }
      end

      describe "changes clues methods" do
        let!(:clue_being_skipped) { turn.current_clue }
        before(:each) { turn.skipped_clue }

        it "moves current_clue to the end of remaining_clues" do
          expect(turn.remaining_clues.last).to eq(clue_being_skipped)
        end

        it "does not move current_clue to completed_clues" do
          expect(turn.completed_clues).to_not include clue_being_skipped
        end
      end

    end

    describe "#update" do
      # move to timer_spec.rb
      # mock turn
      context "with Timer" do
        before do
          short_fuse = Timer.new(1)
          allow(Timer).to receive(:new).and_return(short_fuse)

        end

        it "receives an update when time is finished" do
          expect(turn).to receive(:update)
          turn.timer.thread.join
        end

        it "is finished when the timer is finished" do
          turn.timer.thread.join
          expect(turn.timer.finished?).to be true
        end
      end

      # move to round_spec.rb
      # mock turn
      it "notifies the round of clues remaining" do

        expected_remaining_clues = ["clue-1", "clue-2"]
        expected_completed_clues = ["clue-4", "clue-5"]
        expected_score = 3

        turn.completed_clues = expected_completed_clues.dup
        turn.remaining_clues = expected_remaining_clues.dup
        turn.current_clue = "clue-3"
        expected_remaining_clues << "clue-3"

        turn.score = expected_score

        expect(turn.round).to receive(:turn_completed).with(expected_remaining_clues, expected_completed_clues, expected_score)
        turn.update
      end
    end
  end
end
