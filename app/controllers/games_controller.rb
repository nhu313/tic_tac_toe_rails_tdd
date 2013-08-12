require 'tic_tac_toe/game_factory'
require 'games_presenter'
require 'tic_tac_toe/web/game_interactor'

class GamesController < ApplicationController
  attr_writer :game_interactor

  def play
    @types = TicTacToe::GameFactory.new.types
  end

  def new
    session[:game] = game_interactor.create_game(params[:type].to_i)
    show_board
  end

  def move
    game_interactor.make_move(game, params[:move].to_i)
    show_board
  end

  private
  def show_board
    @presenter = GamesPresenter.new(game)
    render action: "board"
  end

  def game
    session[:game]
  end

  def game_interactor
    @game_interactor ||= TicTacToe::WebGameInteractor.new
  end
end
