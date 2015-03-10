class InviteMailer
  def self.send_mail recipient
    recipient = "test@example" # TODO add this back in for prod
    Pony.options = {
      from: "test@example.com",
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
      to: recipient,
      from: Pony.options[:from],
      subject: "Different files! Join my game!",
      body: "Hey hey, this is a message!!"
    )
  end
end

