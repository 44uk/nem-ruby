# frozen_string_literal: true
require File.expand_path('model/transaction.rb', __dir__)
Dir.glob(File.expand_path('model/*.rb', __dir__)).each { |f| require f }
