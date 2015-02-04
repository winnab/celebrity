module Sinatra
  module CelebrityApp
    module Services
      module InviteMailer
        def self.send_mail recipient
          Pony.options = {
            from: "winnab@gmail.com",
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
    end
  end
end
