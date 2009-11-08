require 'helper'

#  In order to run any tests, you must copy your API key into a file in the
#  same directory that you run your tests from, or else set the environment
#  variable WORDNIK_API_KEY to the api key you wish to use.
class TestWordnik < Test::Unit::TestCase
  context "a single Wordnik instance" do
    should "instantiate given an API key" do
      assert_equal Wordnik::Wordnik.new('TESTTESTETESTTESTSETESTTESTTETST').nil?, false
    end
  end

  context "the Wordnik singleton" do
    setup do
      @api_key = (File.exists?('.api-key') ? File.read('.api-key') : ENV['WORDNIK_API_KEY']).strip
      raise "No API key available." unless @api_key

      @wordnik = Wordnik::DefaultWordnik.instance
      @wordnik.api_key = @api_key
      @test_word = 'test'
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
      assert_equal definitions.first.member?('@id'), true
    end

    should "lookup no more definitions than specified" do
      definitions = @wordnik.define(@test_word, 2)

      assert_equal definitions.is_a?(Array), true
      assert_equal definitions.size, 2
    end

    should "find frequency counts for a word"
    should "find examples for a word"
    should "autocomplete a word fragment"
    should "get the word of the day"
    should "get a random word"
  end

  context "a word lazily loaded" do
    should "provide its wordnik id"
    should "provide its definitions"
    should "provide frequency counts for its usage over the years"
    should "provide examples of its usage"
  end
end
