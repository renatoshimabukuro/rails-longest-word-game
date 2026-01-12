require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @grid = Array.new(10){('a'..'z').to_a.sample}
  end

  def score
    @your_word = params[:word].downcase
    @draw_letters = params[:grid]

    @result = @your_word.chars.each.all? do |letter|
      @your_word.count(letter) <= @draw_letters.split(" ").count(letter)
    end

    if !@result
      @status = "Sorry, but #{@your_word.upcase} can't be built out of #{@draw_letters.upcase}"
    else
      url = "https://dictionary.lewagon.com/#{@your_word}"
      check = JSON.parse(URI.parse(url).read)
      if check["found"]
        @status = "Congratulations! #{@your_word.upcase} is a valid English word!"
      else
        @status = "Sorry but #{@your_word.upcase} does not seem to be a valid English word..."

      end
    end
  end
end
