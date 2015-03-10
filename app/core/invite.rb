class Invite
  attr_accessor :sender, :recipient, :game_id

  def initialize sender, recipient, game_id
    @sender = sender
    @recipient = recipient
    @game_id = game_id
  end

  def has_sender?
    !(@sender[:name].empty? && @sender[:email].empty?)
  end

  def has_recipient_email?
    !@recipient[:email].empty?
  end

  def has_recipient_name?
    !@recipient[:name].empty?
  end

  def has_valid_recipient?
    has_recipient_email? && has_recipient_name?
  end
end
