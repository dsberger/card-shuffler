class ListOrderController < ApplicationController

  def update
    list_id = params[:id]
    destination = params[:destination]
    List.move(list_id, destination)
    render json: List.all
  end
end
