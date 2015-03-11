class InviteStore
  # create invite
  # list invites
  # delete invite

  def initialize
    @store = []
  end

  def list
    store
  end

  def add invite
    store << invite unless store.include?(invite)
  end

  def find_all_by_game_id game_id
    store.select { |invite| invite.game_id == game_id }
  end

  def find_by_email_and_game_id email, game_id
    store.select do |invite|
      invite.recipient[:email] == email && invite.game_id == game_id
    end
  end

  private

  attr_accessor :store
end
