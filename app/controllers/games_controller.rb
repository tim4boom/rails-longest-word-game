require 'open-uri'
require 'nokogiri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)
  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    raise
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  # def score
  #   @word = params[:word].upcase
  #   url = open("https://wagon-dictionary.herokuapp.com/#{@word}")
  #   doc = Nokogiri::HTML(url)
  #   @result = JSON.parse(doc)

  #   if @result['found'] == false
  #     @not_found = "Sorry, but #{@word} is not a valid word"
  #   end
  #   raise
  # end

  # # private

  # # def random_letters
  # #   letters_arr = *('A'..'Z')
  # #   @letters = letters_arr.sample(10)
  # # end
end
