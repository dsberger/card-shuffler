class ListOrderController < ApplicationController

  def update
    list_id = params[:id]
    destination = params[:destination]
    List.move(list_id, destination)
    @lists = List.all
    render file: "#{Rails.root}/app/views/lists/index.json.jbuilder"
  end
end
