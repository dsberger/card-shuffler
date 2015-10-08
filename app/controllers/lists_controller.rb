class ListsController < ApplicationController

  def index
    render json: List.all
  end

end
