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

    def audio_query_audio_query_post(*, **)
      verify_response_code post(build_uri("/audio_query", **), *)
    end

    def audio_query_from_preset_audio_query_from_preset_post(*, **)
      verify_response_code post(build_uri("/audio_query_from_preset", **), *)
    end

    def accent_phrases_accent_phrases_post(*, **)
      verify_response_code post(build_uri("/accent_phrases", **), *)
    end

    def mora_data_mora_data_post(*, **)
      verify_response_code post(build_uri("/mora_data", **), *)
    end

    def mora_length_mora_length_post(*, **)
      verify_response_code post(build_uri("/mora_length", **), *)
    end

    def mora_pitch_mora_pitch_post(*, **)
      verify_response_code post(build_uri("/mora_pitch", **), *)
    end

    def synthesis_synthesis_post(*, **)
      verify_response_code post(build_uri("/synthesis", **), *)
    end

    def cancellable_synthesis_cancellable_synthesis_post(*, **)
      verify_response_code post(build_uri("/cancellable_synthesis", **), *)
    end

    def multi_synthesis_multi_synthesis_post(*, **)
      verify_response_code post(build_uri("/multi_synthesis", **), *)
    end

    def sing_frame_audio_query_sing_frame_audio_query_post(*, **)
      verify_response_code post(build_uri("/sing_frame_audio_query", **), *)
    end

    def sing_frame_volume_sing_frame_volume_post(*, **)
      verify_response_code post(build_uri("/sing_frame_volume", **), *)
    end

    def frame_synthesis_frame_synthesis_post(*, **)
      verify_response_code post(build_uri("/frame_synthesis", **), *)
    end

    def connect_waves_connect_waves_post(*, **)
      verify_response_code post(build_uri("/connect_waves", **), *)
    end

    def validate_kana_validate_kana_post(*, **)
      verify_response_code post(build_uri("/validate_kana", **), *)
    end

    def initialize_speaker_initialize_speaker_post(*, **)
      verify_response_code post(build_uri("/initialize_speaker", **), *)
    end

    def is_initialized_speaker_is_initialized_speaker_get(*, **)
      verify_response_code get(build_uri("/is_initialized_speaker", **), *)
    end

    def supported_devices_supported_devices_get(*, **)
      verify_response_code get(build_uri("/supported_devices", **), *)
    end

    def morphable_targets_morphable_targets_post(*, **)
      verify_response_code post(build_uri("/morphable_targets", **), *)
    end

    def _synthesis_morphing_synthesis_morphing_post(*, **)
      verify_response_code post(build_uri("/synthesis_morphing", **), *)
    end

    def get_presets_presets_get(*, **)
      verify_response_code get(build_uri("/presets", **), *)
    end

    def add_preset_add_preset_post(*, **)
      verify_response_code post(build_uri("/add_preset", **), *)
    end

    def update_preset_update_preset_post(*, **)
      verify_response_code post(build_uri("/update_preset", **), *)
    end

    def delete_preset_delete_preset_post(*, **)
      verify_response_code post(build_uri("/delete_preset", **), *)
    end

    def speakers_speakers_get(*, **)
      verify_response_code get(build_uri("/speakers", **), *)
    end

    def speaker_info_speaker_info_get(*, **)
      verify_response_code get(build_uri("/speaker_info", **), *)
    end

    def singers_singers_get(*, **)
      verify_response_code get(build_uri("/singers", **), *)
    end

    def singer_info_singer_info_get(*, **)
      verify_response_code get(build_uri("/singer_info", **), *)
    end

    def downloadable_libraries_downloadable_libraries_get(*, **)
      verify_response_code get(build_uri("/downloadable_libraries", **), *)
    end

    def installed_libraries_installed_libraries_get(*, **)
      verify_response_code get(build_uri("/installed_libraries", **), *)
    end

    def install_library_install_library__library_uuid__post(library_uuid, *, **)
      verify_response_code post(build_uri("/install_library/#{library_uuid}", **), *)
    end

    def uninstall_library_uninstall_library__library_uuid__post(library_uuid, *, **)
      verify_response_code post(build_uri("/uninstall_library/#{library_uuid}", **), *)
    end

    def get_user_dict_words_user_dict_get(*, **)
      verify_response_code get(build_uri("/user_dict", **), *)
    end

    def add_user_dict_word_user_dict_word_post(*, **)
      verify_response_code post(build_uri("/user_dict_word", **), *)
    end

    def rewrite_user_dict_word_user_dict_word__word_uuid__put(word_uuid, *, **)
      verify_response_code put(build_uri("/user_dict_word/#{word_uuid}", **), *)
    end

    def delete_user_dict_word_user_dict_word__word_uuid__delete(word_uuid, *, **)
      verify_response_code delete(build_uri("/user_dict_word/#{word_uuid}", **), *)
    end

    def import_user_dict_words_import_user_dict_post(*, **)
      verify_response_code post(build_uri("/import_user_dict", **), *)
    end

    def version_version_get(*, **)
      verify_response_code get(build_uri("/version", **), *)
    end

    def core_versions_core_versions_get(*, **)
      verify_response_code get(build_uri("/core_versions", **), *)
    end

    def engine_manifest_engine_manifest_get(*, **)
      verify_response_code get(build_uri("/engine_manifest", **), *)
    end

    def setting_get_setting_get(*, **)
      verify_response_code get(build_uri("/setting", **), *)
    end

    def setting_post_setting_post(*, **)
      verify_response_code post(build_uri("/setting", **), *)
    end

    def get_portal_page__get(*, **)
      verify_response_code get(build_uri("/", **), *)
    end
  end
end
