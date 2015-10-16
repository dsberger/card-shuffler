require 'rails_helper'

describe ListOrderController do

  describe 'PATCH update' do

    before { set_up_lists 4 }

    it "calls on List.move" do
      list_id = List.find_by_order_on_board(3)
      expect(List).to receive(:move)
      patch :update, format: :json, id: list_id, destination: 2
    end

    it "returns all the lists" do
      list_id = List.find_by_order_on_board(3)
      patch :update, format: :json, id: list_id, destination: 2
      expect( JSON.parse(response.body).count ).to eq 4
    end

  end

end
