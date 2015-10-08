require 'rails_helper'

describe ListsController do

  describe "GET index" do
    board = Board.create(name: "TestBoard")
    4.times do |n|
      List.create(board: board, name: "list#{n+1}", order_on_board: n+1, color:"000000")
    end

    it "sends a JSON version of the lists" do
      get :index, format: :json
      expect( JSON.parse(response.body).count ).to eq 4
    end
  end

end
