require "fluent/plugin/output"
require 'fluent/mixin'
require 'fluent/mixin/config_placeholders'
require 'fluent/mixin/rewrite_tag_name'

module Fluent
  module Plugin
    class LogplexSplitterOutput < Fluent::Plugin::Output
      Fluent::Plugin.register_output("logplex_splitter", self)

      include Fluent::Mixin::ConfigPlaceholders
      include Fluent::HandleTagNameMixin
      include Fluent::Mixin::RewriteTagName

      config_param :tag, :string, default: nil
      config_param :split_pattern, :string, default: '\d+\s<\d+>.+'
      config_param :input_key, :string, default: nil
      config_param :output_key, :string, default: nil
      config_param :remove_tag_prefix, :string, default: nil
      config_param :remove_tag_suffix, :string, default: nil
      config_param :add_tag_prefix, :string, default: nil
      config_param :add_tag_suffix, :string, default: nil

      helpers :event_emitter

      def multi_workers_ready?
        true
      end

      def configure(conf)
        super
        @split_pattern = Regexp.new(@split_pattern.to_s)
        if !@tag && !@remove_tag_prefix && !@remove_tag_suffix && !@add_tag_prefix && !@add_tag_suffix
          raise Fluent::ConfigError, "missing remove_tag_prefix, remove_tag_suffix, add_tag_prefix or add_tag_suffix."
        end
      end

      def process(tag, es)
        es.each do |time, record|
          message = record[@input_key]

          message.scan(@split_pattern).each do |message_chunk|
            emit_tag = tag.dup
            emit_record = record.dup
            record = emit_record.merge(@output_key => message_chunk)
            filter_record(emit_tag, time, record)
            router.emit(emit_tag, time, record)
          end
        end
      end

      def filter_record tag, time, record
        super
      end
    end
  end
end
