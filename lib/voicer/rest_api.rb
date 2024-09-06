# frozen_string_literal: true

require "json"
require "net/http"
require "uri"
require_relative "rest_api_helper"

module Voicer
  module RestApi
    include RestApiHelper

    VERSION = "0.20.0"

    AccentPhrase = Data.define(
      :moras,
      :accent,
      :pause_mora,
      :is_interrogative
    )

    AudioQuery = Data.define(
      :accent_phrases,
      :speedScale,
      :pitchScale,
      :intonationScale,
      :volumeScale,
      :prePhonemeLength,
      :postPhonemeLength,
      :pauseLength,
      :pauseLengthScale,
      :outputSamplingRate,
      :outputStereo,
      :kana
    )

    Body_setting_post_setting_post = Data.define(
      :cors_policy_mode,
      :allow_origin
    )

    Body_sing_frame_volume_sing_frame_volume_post = Data.define(
      :score,
      :frame_audio_query
    )

    CorsPolicyMode = %w[all localapps].freeze

    DownloadableLibraryInfo = Data.define(
      :name,
      :uuid,
      :version,
      :download_url,
      :bytes,
      :speakers
    )

    EngineManifest = Data.define(
      :manifest_version,
      :name,
      :brand_name,
      :uuid,
      :url,
      :icon,
      :default_sampling_rate,
      :frame_rate,
      :terms_of_service,
      :update_infos,
      :dependency_licenses,
      :supported_vvlib_manifest_version,
      :supported_features
    )

    FrameAudioQuery = Data.define(
      :f0,
      :volume,
      :phonemes,
      :volumeScale,
      :outputSamplingRate,
      :outputStereo
    )

    FramePhoneme = Data.define(
      :phoneme,
      :frame_length
    )

    HTTPValidationError = Data.define(
      :detail
    )

    InstalledLibraryInfo = Data.define(
      :name,
      :uuid,
      :version,
      :download_url,
      :bytes,
      :speakers,
      :uninstallable
    )

    LibrarySpeaker = Data.define(
      :speaker,
      :speaker_info
    )

    LicenseInfo = Data.define(
      :name,
      :version,
      :license,
      :text
    )

    Mora = Data.define(
      :text,
      :consonant,
      :consonant_length,
      :vowel,
      :vowel_length,
      :pitch
    )

    MorphableTargetInfo = Data.define(
      :is_morphable
    )

    Note = Data.define(
      :key,
      :frame_length,
      :lyric
    )

    ParseKanaBadRequest = Data.define(
      :text,
      :error_name,
      :error_args
    )

    Preset = Data.define(
      :id,
      :name,
      :speaker_uuid,
      :style_id,
      :speedScale,
      :pitchScale,
      :intonationScale,
      :volumeScale,
      :prePhonemeLength,
      :postPhonemeLength,
      :pauseLength,
      :pauseLengthScale
    )

    Score = Data.define(
      :notes
    )

    Speaker = Data.define(
      :name,
      :speaker_uuid,
      :styles,
      :version,
      :supported_features
    )

    SpeakerInfo = Data.define(
      :policy,
      :portrait,
      :style_infos
    )

    SpeakerStyle = Data.define(
      :name,
      :id,
      :type
    )

    SpeakerSupportedFeatures = Data.define(
      :permitted_synthesis_morphing
    )

    StyleInfo = Data.define(
      :id,
      :icon,
      :portrait,
      :voice_samples
    )

    SupportedDevicesInfo = Data.define(
      :cpu,
      :cuda,
      :dml
    )

    SupportedFeatures = Data.define(
      :adjust_mora_pitch,
      :adjust_phoneme_length,
      :adjust_speed_scale,
      :adjust_pitch_scale,
      :adjust_intonation_scale,
      :adjust_volume_scale,
      :adjust_pause_length,
      :interrogative_upspeak,
      :synthesis_morphing,
      :sing,
      :manage_library,
      :return_resource_url
    )

    UpdateInfo = Data.define(
      :version,
      :descriptions,
      :contributors
    )

    UserDictWord = Data.define(
      :surface,
      :priority,
      :context_id,
      :part_of_speech,
      :part_of_speech_detail_1,
      :part_of_speech_detail_2,
      :part_of_speech_detail_3,
      :inflectional_type,
      :inflectional_form,
      :stem,
      :yomi,
      :pronunciation,
      :accent_type,
      :mora_count,
      :accent_associative_rule
    )

    ValidationError = Data.define(
      :loc,
      :msg,
      :type
    )

    WordTypes = %w[PROPER_NOUN COMMON_NOUN VERB ADJECTIVE SUFFIX].freeze

    BaseLibraryInfo = Data.define(
      :name,
      :uuid,
      :version,
      :download_url,
      :bytes,
      :speakers
    )

    VvlibManifest = Data.define(
      :manifest_version,
      :name,
      :version,
      :uuid,
      :brand_name,
      :engine_name,
      :engine_uuid
    )

    def post_audio_query(*, **)
      verify_response_code post(build_uri("/audio_query", **), *)
    end

    def post_audio_query_from_preset(*, **)
      verify_response_code post(build_uri("/audio_query_from_preset", **), *)
    end

    def post_accent_phrases(*, **)
      verify_response_code post(build_uri("/accent_phrases", **), *)
    end

    def post_mora_data(*, **)
      verify_response_code post(build_uri("/mora_data", **), *)
    end

    def post_mora_length(*, **)
      verify_response_code post(build_uri("/mora_length", **), *)
    end

    def post_mora_pitch(*, **)
      verify_response_code post(build_uri("/mora_pitch", **), *)
    end

    def post_synthesis(*, **)
      verify_response_code post(build_uri("/synthesis", **), *)
    end

    def post_cancellable_synthesis(*, **)
      verify_response_code post(build_uri("/cancellable_synthesis", **), *)
    end

    def post_multi_synthesis(*, **)
      verify_response_code post(build_uri("/multi_synthesis", **), *)
    end
    #########
    def post_sing_frame_audio_query(*, **)
      verify_response_code post(build_uri("/sing_frame_audio_query", **), *)
    end

    def post_sing_frame_volume(*, **)
      verify_response_code post(build_uri("/sing_frame_volume", **), *)
    end

    def post_frame_synthesis(*, **)
      verify_response_code post(build_uri("/frame_synthesis", **), *)
    end

    def post_connect_waves(*, **)
      verify_response_code post(build_uri("/connect_waves", **), *)
    end

    def post_validate_kana(*, **)
      verify_response_code post(build_uri("/validate_kana", **), *)
    end

    def post_initialize_speaker(*, **)
      verify_response_code post(build_uri("/initialize_speaker", **), *)
    end

    def get_is_initialized_speaker(*, **)
      verify_response_code get(build_uri("/is_initialized_speaker", **), *)
    end

    def get_supported_devices(*, **)
      verify_response_code get(build_uri("/supported_devices", **), *)
    end

    def post_morphable_targets(*, **)
      verify_response_code post(build_uri("/morphable_targets", **), *)
    end

    def post_synthesis_morphing(*, **)
      verify_response_code post(build_uri("/synthesis_morphing", **), *)
    end

    def get_presets(*, **)
      verify_response_code get(build_uri("/presets", **), *)
    end

    def post_add_preset(*, **)
      verify_response_code post(build_uri("/add_preset", **), *)
    end

    def post_update_preset(*, **)
      verify_response_code post(build_uri("/update_preset", **), *)
    end

    def post_delete_preset(*, **)
      verify_response_code post(build_uri("/delete_preset", **), *)
    end

    def get_speakers(*, **)
      verify_response_code get(build_uri("/speakers", **), *)
    end

    def get_speaker_info(*, **)
      verify_response_code get(build_uri("/speaker_info", **), *)
    end

    def get_singers(*, **)
      verify_response_code get(build_uri("/singers", **), *)
    end

    def get_singer_info(*, **)
      verify_response_code get(build_uri("/singer_info", **), *)
    end

    def get_downloadable_libraries(*, **)
      verify_response_code get(build_uri("/downloadable_libraries", **), *)
    end

    def get_installed_libraries(*, **)
      verify_response_code get(build_uri("/installed_libraries", **), *)
    end

    def post_install_library__library_uuid(library_uuid, *, **)
      verify_response_code post(build_uri("/install_library/#{library_uuid}", **), *)
    end

    def post_uninstall_library__library_uuid(library_uuid, *, **)
      verify_response_code post(build_uri("/uninstall_library/#{library_uuid}", **), *)
    end

    def get_user_dict(*, **)
      verify_response_code get(build_uri("/user_dict", **), *)
    end

    def post_user_dict_word(*, **)
      verify_response_code post(build_uri("/user_dict_word", **), *)
    end

    def put_user_dict_word__word_uuid(word_uuid, *, **)
      verify_response_code put(build_uri("/user_dict_word/#{word_uuid}", **), *)
    end

    def delete_user_dict_word__word_uuid(word_uuid, *, **)
      verify_response_code delete(build_uri("/user_dict_word/#{word_uuid}", **), *)
    end

    def post_import_user_dict(*, **)
      verify_response_code post(build_uri("/import_user_dict", **), *)
    end

    def get_version(*, **)
      verify_response_code get(build_uri("/version", **), *)
    end

    def get_core_versions(*, **)
      verify_response_code get(build_uri("/core_versions", **), *)
    end

    def get_engine_manifest(*, **)
      verify_response_code get(build_uri("/engine_manifest", **), *)
    end

    def get_setting(*, **)
      verify_response_code get(build_uri("/setting", **), *)
    end

    def post_setting(*, **)
      verify_response_code post(build_uri("/setting", **), *)
    end

    def get_portal_page(*, **)
      verify_response_code get(build_uri("/", **), *)
    end
  end
end
