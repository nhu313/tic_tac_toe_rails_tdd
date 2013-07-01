require 'tic_tac_toe/web_main'
require 'tic_tac_toe/game_factory'

class GamesController < ApplicationController
  attr_writer :main

  def new
    session[:game] = main.create_game(params[:type])
    board
  end

  def play
    @types = TicTacToe::GameFactory.new.types
  end

  def move
    main.make_move(params[:move])
    board
  end

  private
  def board
    @game = game
    render action: "board"
  end

  def main
    @main ||= TicTacToe::WebMain.new(game)
  end

  def game
    session[:game]
  end
end
