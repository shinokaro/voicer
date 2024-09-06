# frozen_string_literal: true

require "forwardable"
require_relative "rest_api"

module Voicer
  class Character < RestApi::Speaker
    include RestApi

    # name
    # speaker_uuid
    # styles
    # version
    # supported_features
    def initialize(styles: nil, supported_features:, **)
      super(
        styles: nil,
        supported_features: SpeakerSupportedFeatures.new(supported_features),
        **
      )
    end

    extend Forwardable
    def_delegators :supported_features, *SpeakerSupportedFeatures.members

    undef styles

    alias core_version version
    alias uuid speaker_uuid
    alias to_s name
  end

  class Voice < RestApi::SpeakerStyle
    include RestApi

    attr_reader :character

    # name
    # id
    # type
    def initialize(character:, **)
      @character = character
      super(**)
    end

    extend Forwardable

    def_delegators :character, *(Speaker.members - [:name, :styles])
    def_delegators :character, :version, :core_version
    def_delegators :character, *SpeakerSupportedFeatures.members

    def character_name = character.name

    alias style_name name

    def name = "#{character_name} (#{style_name})"

    alias to_s name

    def speaker? = type == "talk"

    def singer? = !speaker?

    alias to_i id
  end
end
