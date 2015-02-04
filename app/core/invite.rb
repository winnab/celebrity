class Invite
  attr_accessor :sender, :recipients

  def initialize sender, recipients
    @sender = sender
    @recipients = recipients
  end

  def has_sender?
    !(@sender[:name].empty? && @sender[:email].empty?)
  end

  def has_recipient_emails?
    @recipients.all? { | r | r[:email] }
  end

  def has_recipient_names?
    @recipients.all? { | r | r[:name] }
  end

  def has_valid_recipients?
    has_recipient_emails? && has_recipient_names?
  end
end
