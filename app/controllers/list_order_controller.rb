class ListOrderController < ApplicationController

  def update
    # extracts arguments from params and sends the hard work to the model.
    list_id = params[:id]
    destination = params[:destination]
    List.move(list_id, destination)

    # returns the entire board to the front end.
    @lists = List.all
    render file: "#{Rails.root}/app/views/lists/index.json.jbuilder"
  end
end
