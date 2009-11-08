module Wordnik
  class Word
    attr_reader :word

    def initialize(word, eager = false, wordnik_instance = nil)
      @word = word.dup.freeze
      @wordnik = wordnik_instance || DefaultWordnik.instance
      load_all if eager
    end

    def wordnik_id
      @wordnik_id ||= @wordnik.lookup(word)['id']
    end

    def definitions
      @definitions ||= @wordnik.define(word)
    end

    def frequencies
      @frequencies ||= @wordnik.frequency(word)
    end

    def examples
      @examples ||= @wordnik.examples(word)
    end

    private

    def load_all
      wordnik_id
      definitions
      frequencies
      examples
    end
  end
end