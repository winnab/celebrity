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

  def find_by_game_id game_id
    store.find { |invite| invite.game_id == game_id }
  end

  private

  attr_accessor :store
end
