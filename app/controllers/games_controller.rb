require 'web/tic_tac_toe/game_interactor'
require 'tic_tac_toe/game_factory'

class GamesController < ApplicationController
  attr_writer :main

  def play
    @types = TicTacToe::GameFactory.new.types
  end

  def new
    session[:game] = main.create_game(params[:type])
    show_board
  end

  def move
    main.make_move(params[:move])
    show_board
  end

  private
  def show_board
    @game = game
    render action: "board"
  end

  def main
    @main ||= TicTacToe::GameInteractor.new(game)
  end

  def game
    session[:game]
  end
end
