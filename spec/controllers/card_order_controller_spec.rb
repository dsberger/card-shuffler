require 'rails_helper'

describe CardOrderController do

  describe "PATCH update" do

    before { set_up_full_board }

    it "calls on Card.move" do
      card_id = Card.all.sample.id
      expect(Card).to receive(:move)
      patch :update, format: :json, id: card_id, list_destination: 2, card_destination: 2
    end

    it "returns all the lists" do
      card_id = Card.all.sample.id
      patch :update, format: :json, id: card_id, list_destination: 2, card_destination: 2
      expect( JSON.parse(response.body).count ).to eq 4
    end
  end
end
