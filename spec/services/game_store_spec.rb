require "spec_helper"
require_relative "../../app/services/game_store"

describe GameStore do
  let(:game_store) { GameStore.new }
  describe "#list" do
    it "is an empty array by default" do
      expect(game_store.list).to eql([])
    end
  end

  describe "#add" do
    let(:game) { double(:game) }
    it "adds a game to the list" do
      expect { game_store.add(game) }
        .to change { game_store.list }.from([]).to([game])
    end

    it "does not add the same game twice" do
      game_store.add(game)
      expect { game_store.add(game) }.to_not change { game_store.list.length }.from(1)
    end
  end

  describe "#find" do
    it "finds the correct game" do
      game_a = double(:game, id: 'a')
      game_b = double(:game, id: 'b')
      game_c = double(:game, id: 'c')
      game_store.add(game_a)
      game_store.add(game_b)
      game_store.add(game_c)
      expect(game_store.find('a')).to eql(game_a)
    end
  end
end
