class InviteMailer
  def send_mail recipient, game_id
    recipient = recipient
    Pony.options = {
      from: "game_people@example.com",
      via: :smtp,
      via_options: {
        address: "smtp.mandrillapp.com",
        port: "25",
        enable_starttls_auto: true,
        user_name: ENV["MANDRILL_USERNAME"],
        password: ENV["MANDRILL_APIKEY"],
        authentication: "plain"
      }
    }
    Pony.mail(
      to: recipient || "test@example.com",
      from: Pony.options[:from],
      subject: "Join my game!",
      body: "Hey hey, this is a message!! Click here: localhost:3000/join/#{game_id}/#{recipient}"
    )
  end
end

