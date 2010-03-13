module Wordnik
  class Wordnik
    include HTTParty

    attr_reader :api_key

    base_uri 'http://api.wordnik.com/api'

    def initialize(api_key = nil)
      @api_key = (api_key || File.read('.api-key').strip || '').dup
      unless @api_key.blank?
        self.class.default_params :api_key => @api_key
      end
    end

    def api_key=(api_key)
      @api_key = api_key.dup
      self.class.default_params :api_key => @api_key
      nil
    end

    def lookup(word)
      do_request("word.json/#{word.downcase}")
    end

    def define(word, *args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      unless options.key?(:count)
        options[:count] = args.any? ? args.first.to_i : 100
      end
      do_request("word.json/#{word.downcase}/definitions", sanitize_options(options))
    end

    def frequency(word)
      do_request("word.json/#{word.downcase}/frequency")
    end

    def examples(word)
      do_request("word.json/#{word.downcase}/examples")
    end

    def autocomplete(word_fragment, count = 100)
      do_request("suggest.json/#{word_fragment.downcase}", :count => count)
    end

    def word_of_the_day
      do_request("wordoftheday.json")
    end

    def random(has_definition = true)
      do_request("words.json/randomWord", :hasDictionaryDef => has_definition)
    end

    def punctuation(word)
      do_request("word.json/#{word.downcase}/punctuationFactor")
    end

    protected

    def do_request(request, options = {})
      handle_result(self.class.get("/#{request}", options))
    end

    def handle_result(result)
      if result.is_a?(String)
        raise 'Error in result.'
      else
        result
      end
    end

    def sanitize_options(opts)
      options = {}

      [:count, :partOfSpeech].each { |k| options[k] = opts[k] if opts.key?(k) }
      if options.key?(:partOfSpeech)
        options[:partOfSpeech].reject! do |pos|
          [:noun, :verb, :adjective, :adverb, :idiom, :article,
            :abbreviation, :preposition, :prefix, :interjection, :suffix]
        end
      end

      options
    end
  end
end
