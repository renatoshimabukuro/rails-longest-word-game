require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @random_letters = alphabet.sample(10)
  end

  def score
    your_word = params[:word]
    @novo = params[:grid]
    your_word_splited = params[:word].split("")
    your_word_splited.each do |word|
      if @novo.include?(word)
        @novo.delete(word)
        @result = true
      else
        @result = false
      end
    end
    if @result
      url = "https://dictionary.lewagon.com/#{your_word}"
      @check = JSON.parse(URI.parse(url).read)
    else
      p "fail"
    end
  end
end
