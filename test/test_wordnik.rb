require 'helper'

#  In order to run any tests, you must copy your API key into a file in the
#  same directory that you run your tests from, or else set the environment
#  variable WORDNIK_API_KEY to the api key you wish to use.
class TestWordnik < Test::Unit::TestCase
  context "the Wordnik singleton" do
    setup do
      api_key = (File.exists?('.api-key') ? File.read : ENV['WORDNIK_API_KEY']).strip
      raise "No API key available." unless api_key

      @wordnik = Wordnik::Wordnik.instance(api_key)
    end

    should "instantiate given an API key" do
      @wordnik.should true
    end

    should "lookup the id for word"
    should "lookup definitions for a word"
    should "lookup no more definitions than specified"
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
