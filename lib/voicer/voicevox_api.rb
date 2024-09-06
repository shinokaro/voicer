# frozen_string_literal: true

require_relative "rest_api"
require_relative "voice"
require_relative "accent_phrase"

module Voicer
  module VoicevoxApi
    include RestApi

    CONTENT_TYPE_JSON = { "Content-Type" => "application/json" }.freeze

    def parse_json(json)
      JSON.parse(json, symbolize_names: true)
    end
    private :parse_json

    # option: core_version: String
    def voices(**)
      speakers = parse_json(get_speakers(**).body)
      singers = parse_json(get_singers(**).body)

      (speakers + singers).flat_map do |obj|
        obj in { styles:, **speaker }
        character = Character.new(**speaker)
        styles.map { |style| Voice.new(character: character, **style) }
      end
    end

    # option: skip_reinit: Bool
    # option: core_version: String
    def initialize_voice(id, **)
      post_initialize_speaker(nil, speaker: id, **).body
    end

    # option: core_version: String
    def initialized_voice?(id, **)
      parse_json(get_is_initialized_speaker(speaker: id, **).body)
    end

    # option: is_kana: Bool
    # option: core_version: String
    def fetch_accent_phrases(text, id, **)
      obj = post_accent_phrases(nil, text: text, speaker: id, **).body
      parse_json(obj).map { |h| AccentPhrase.new(**h) }
    end

    def build_audio_query(
      accent_phrases,
      speed_scale: 1.0,
      pitch_scale: 0.0,
      intonation_scale: 1.0,
      volume_scale: 1.0,
      pre_phoneme_length: 0.1,
      post_phoneme_length: 0.1,
      pause_length: nil,
      pause_length_scale: 1.0,
      output_sampling_rate: 24000,
      output_stereo: false
    )
      {
        accent_phrases: accent_phrases,
        speedScale: speed_scale,
        pitchScale: pitch_scale,
        intonationScale: intonation_scale,
        volumeScale: volume_scale,
        prePhonemeLength: pre_phoneme_length,
        postPhonemeLength: post_phoneme_length,
        pauseLength: pause_length,
        pauseLengthScale: pause_length_scale,
        outputSamplingRate: output_sampling_rate,
        outputStereo: output_stereo,
      }
    end
    private :build_audio_query

    def synthesis(accent_phrases, id, core_version: nil, **)
      post_synthesis(
        build_audio_query(accent_phrases, **).to_json,
        CONTENT_TYPE_JSON,
        speaker: id,
        core_version: core_version
      )
    end

    def synthesis_morphing(accent_phrases, base_speaker, target_speaker, morph_rate,
                           core_version: nil, **)
      post_synthesis_morphing(
        build_audio_query(accent_phrases, **).to_json,
        CONTENT_TYPE_JSON,
        base_speaker: base_speaker,
        target_speaker: target_speaker,
        morph_rate: morph_rate,
        core_version: core_version
      )
    end

    def text_to_voice(text, id, core_version: nil, **)
      synthesis(
        fetch_accent_phrases(text, id, core_version: core_version),
        speaker,
        core_version: core_version,
        **
      ).body
    end

    # option: core_version: String
    def supported_devices(**)
      parse_json(get_supported_devices(**).body)
    end

    def version
      parse_json(get_version.body)
    end

    def core_versions
      parse_json(get_core_versions.body)
    end

    def export_user_dict
      parse_json(get_user_dict.body)
    end

    def import_user_dict(dict, override: true)
      post_import_user_dict(
        dict.to_json,
        override: override
      ).body
    end

    # word_type: "PROPER_NOUN" | "COMMON_NOUN" | "VERB" | "ADJECTIVE" | "SUFFIX"
    def add_user_dict_word(surface:, pronunciation:, accent_type:, word_type: nil, priority: nil)
      obj = post_user_dict_word(
        nil,
        surface: surface,
        pronunciation: pronunciation,
        accent_type: accent_type,
        word_type: word_type,
        priority: priority
      ).body
      parse_json(obj)
    end
  end
end
