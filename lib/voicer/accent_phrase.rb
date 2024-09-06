# frozen_string_literal: true

module Voicer
  class Mora < RestApi::Mora
    class << self
      def silent(length)
        new(
          text: "",
          consonant: nil,
          consonant_length: nil,
          vowel: "pau",
          vowel_length: length,
          pitch: 0.0
        )
      end
    end

    # text
    # consonant
    # consonant_length
    # vowel
    # vowel_length
    # pitch

    def to_json(*) = to_h.to_json(*)

    def to_s = "#{vowel}#{consonant}"
  end

  class AccentPhrase < RestApi::AccentPhrase
    # moras
    # accent
    # pause_mora
    # is_interrogative
    def initialize(moras:, pause_mora: nil, **)
      super(
        moras: moras.map { |obj| obj.is_a?(Mora) ? obj : Mora.new(**obj) },
        pause_mora: pause_mora &&
          (pause_mora.is_a?(Mora) ? pause_mora : Mora.new(**pause_mora)),
        **
      )
    end

    alias interrogative? is_interrogative

    def to_json(*) = to_h.to_json(*)

    def to_s = moras.map(&:to_s).join(" ")
  end
end
