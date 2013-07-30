require 'tic_tac_toe/game_state_factory'
require 'tic_tac_toe/game_state'
require 'presenter'
require 'web/tic_tac_toe/web_game'

class GamesController < ApplicationController
  attr_writer :main

  def play
    @types = TicTacToe::GameStateFactory.new.types
  end

  def new
    session[:game_state] = game.create_game_state(params[:type].to_i)
    show_board
  end

  def move
    game.make_move(game_state, params[:move].to_i)
    show_board
  end

  private
  def show_board
    board
    @presenter = Presenter.new(game_state)
    render action: "board"
  end

  def board
    @board = session[:game_state].board
  end

  def game_state
    session[:game_state]
  end

  def game
    TicTacToe::WebGame.new
  end
end
