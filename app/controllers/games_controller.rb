require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }.join
  end

  def score
    # URL parsing
    url = "https://wagon-dictionary.herokuapp.com/#{params[:game]}"
    response = open(url).read
    parsed_response = JSON.parse(response)
    # check if part of the existing string
    letters_contained = params[:game].upcase.chars.all? { |letter| params[:letters].include?(letter)}
    # display correct answer]
    @score = 0
    if parsed_response["error"] == "word not found"
      @outcome = "The word #{params[:game]} is not a valid English word."
    elsif letters_contained == false
      @outcome = "The word #{params[:game]} can't be built out of the original grid."
    else
      @outcome = "The word #{params[:game]} is correct! Well done!"
      @score += 1
    end
  end


end
