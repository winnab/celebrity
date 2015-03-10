require_relative "../../app/core/invite"
require "spec_helper"

describe Invite do
  let(:players) {
    ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"]
  }

  let(:players_obj) {
    players.map do | p |
      {
        name: p,
        clues: 5.times.each_with_object([]) { | i, obj | obj << "#{p}-clue-#{i}" }
      }
    end
   }

  let(:num_teams) { 2 }

  let(:game) { Game.new(players_obj.first).start(players_obj, num_teams) }

  let(:recipients) {
    players.map do | p |
      { name: p, email: "#{p}.my_email@example.com"  }
    end
  }

  let(:sender) { { email: "test@example.com", name: "Sophie" } }

  let(:invites) {
    recipients.map do | r |
      Invite.new(sender, r, game.id)
    end
  }

  let(:invite) { invites[0] }

  context "valid invite" do
    it "has a sender with a name and email address" do
      expect(invite.has_sender?).to be true
    end

    it "has valid recipients" do
      expect(invite.has_valid_recipient?).to be true
    end

    # it "sends invites"
    # it "detects when an invitee has responded"
    # it "detects when game is valid and can start"
  end
end
