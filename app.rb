require "rubygems"
require "bundler/setup"
require 'sinatra'
require 'active_support/inflector'

$:.push File.join(File.dirname(__FILE__),'app')

require 'deck'
require 'card'
require 'player'

class App < Sinatra::Base
  get '/' do
    haml :index
  end

  post '/' do
    d = Deck.new
    params[:card_list].lines.each do |card|
      d.add_card card.strip
    end
    @player = Player.new('Player',params[:occupation].strip,d)
    haml :score
  end
end
