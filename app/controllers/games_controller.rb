require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # raise
    @letters = params[:letters].upcase
    @word = params[:word].upcase

    if included?(@word) == false
      @result = "Sorry, but #{@word} cant be built out of #{@letters}"
    elsif english?(@word) == false
      @result = "Sorry but #{@word} does not seem to a valid english word..."
    else
      @result = "Congratulations! #{@word} is a valid english word!"
    end
  end

  private

  def english?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(word)
    word.chars.all? { |letter| word.count(letter) <= @letters.count(letter) }
  end
end
