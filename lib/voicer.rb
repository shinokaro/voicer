# frozen_string_literal: true

require_relative "voicer/version"
require_relative "voicer/client"

module Voicer
  class Error < StandardError; end

  def self.connect(...) = Client.new(...).start
end
