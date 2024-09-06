# frozen_string_literal: true

require "net/http"
require_relative "voicevox_api"

module Voicer
  class Client < Net::HTTP
    include VoicevoxApi
  end
end
