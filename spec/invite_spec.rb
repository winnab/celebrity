require_relative "../controllers/invite"
require "spec_helper"
require "pry"

describe Invite do
  let(:players) {
    ["winna", "neil", "chucky", "jessica", "richa", "deb", "divya", "gautam"]
  }

  let(:recipients) {
    players.map do | p |
      { name: p, email: "#{p}.my_email@example.com"  }
    end
   }
  let(:sender) { { email: "test@example.com", name: "Sophie" } }
  let(:invite) { Invite.new(sender, recipients) }
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
