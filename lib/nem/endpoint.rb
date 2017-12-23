# frozen_string_literal: true
require File.expand_path('endpoint/base.rb', __dir__)
Dir.glob(File.expand_path('endpoint/*.rb', __dir__)).each { |f| require f }
Dir.glob(File.expand_path('endpoint/**/*.rb', __dir__)).each { |f| require f }
