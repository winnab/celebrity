require_relative "../controllers/main"
require_relative "../controllers/invite"
require_relative "../controllers/game"
require_relative "../controllers/round"
require_relative "../controllers/turn"
require_relative "../controllers/player"
require_relative "../controllers/team"

require "pry"

# Configure RSpec
RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end
