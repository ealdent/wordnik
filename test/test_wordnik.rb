require 'helper'

#  In order to run any tests, you must copy your API key into a file in the
#  same directory that you run your tests from, or else set the environment
#  variable WORDNIK_API_KEY to the api key you wish to use.
class TestWordnik < Test::Unit::TestCase
  context "initializing a Wordnik object" do
    should "instantiate given an API key" do
      assert_equal Wordnik.new('TESTTESTETESTTESTSETESTTESTTETST').nil?, false
    end
  end

  context "a single Wordnik instance" do
    setup do
      @api_key = (File.exists?('.api-key') ? File.read('.api-key') : ENV['WORDNIK_API_KEY']).strip
      raise "No API key available." unless @api_key

      @wordnik = Wordnik.new(@api_key)
      @test_word = 'test'
      @test_word_fragment = 'invas'
    end

    should "make its api-key accessible" do
      assert_equal @wordnik.api_key, @api_key
    end

    should "lookup the id for a word" do
      word = @wordnik.lookup(@test_word)

      assert_equal word.is_a?(Hash), true
      assert_equal word.empty?, false
      assert_equal word.member?('id'), true
      assert_equal word['id'].to_i > 0, true
    end

    should "lookup definitions for a word" do
      definitions = @wordnik.define(@test_word)

      assert_equal definitions.is_a?(Array), true
      assert_equal definitions.empty?, false
      assert_equal definitions.first.is_a?(Hash), true
      assert_equal definitions.first.member?('id'), true
    end

    should "find frequency counts for a word" do
      frequency = @wordnik.frequency(@test_word)

      assert_equal frequency.is_a?(Hash), true
      assert_equal frequency.member?('frequency'), true
    end

    should "find examples for a word" do
      examples = @wordnik.examples(@test_word)

      assert_equal examples.is_a?(Array), true
      assert_equal examples.empty?, false
    end

    should "autocomplete a word fragment" do
      suggestions = @wordnik.autocomplete(@test_word_fragment)

      assert_equal suggestions.is_a?(Hash), true
      assert_equal suggestions['match'].is_a?(Array), true
      assert_equal suggestions['match'].empty?, false
    end

    should "get the word of the day" do
      word = @wordnik.word_of_the_day

      assert_equal word.is_a?(Hash), true
      assert_equal word.member?('wordstring'), true
    end

    should "get a random word" do
      word = @wordnik.random

      assert_equal word.is_a?(Hash), true
      assert_equal word.member?('wordstring'), true
    end
  end
end
