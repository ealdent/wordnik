module Wordnik
  class Word
    attr_reader :word

    def initialize(word, eager = false)
      @word = word.dup.freeze
      load_all if eager
    end

    def wordnik_id
      @wordnik_id ||= Wordnik.instance.lookup(word)['id']
    end

    def definitions
      @definitions ||= Wordnik.instance.define(word)
    end

    def frequencies
      @frequencies ||= Wordnik.instance.frequency(word)
    end

    def examples
      @examples ||= Wordnik.instance.examples(word)
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