class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def my_portfolio
    @user = current_user
    if user_signed_in?
      @tracked_stocks = current_user.stocks
    else
      @tracked_stocks = []
    end
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if !@friends.empty?
        render turbo_stream: turbo_stream.replace('results_turbo_stream', partial: 'friends/result')
      else 
        flash.now[:alert] = "Not user found with that name or email"
        render turbo_stream: turbo_stream.replace('results_turbo_stream', partial: 'friends/result')
      end
    else
        flash.now[:alert] = "Please enter a symbol to search"
        render turbo_stream: turbo_stream.replace('results_turbo_stream', partial: 'friends/result')
    end
  end
end
