require 'games_presenter'
require 'tic_tac_toe/game_factory'

class GamesController < ApplicationController
  attr_writer :presenter

  def move
    presenter.make_move(params[:move])
    show
  end

  def new
    session[:game] = presenter.create_game(params[:type])
    show
  end

  def show
    @squares = presenter.squares
    @in_progress = !presenter.game_over?
    @winner = presenter.winner
    @current_player = game.current_player
    render action: "show"
  end

  def play
    @types = TicTacToe::GameFactory.new.types
  end

  private
  def presenter
    @presenter = @presenter || GamesPresenter.new(game)
  end

  def game
    session[:game]
  end
end
