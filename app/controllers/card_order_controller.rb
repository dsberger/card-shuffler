class CardOrderController < ApplicationController

  def update

    # extracts arguments from params and sends the hard work to the model.
    card_id = params[:id]
    new_list = params[:list_destination]
    new_card = params[:card_destination]
    Card.move( card_id, new_list, new_card )

    # returns the entire board to the front end.
    @lists = List.all
    render file: "#{Rails.root}/app/views/lists/index.json.jbuilder"
  end
end
