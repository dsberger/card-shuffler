require 'rails_helper'

describe ListsController do

  describe "GET index" do

    it "sends a JSON version of the lists" do

      4.times do |n|
        create(:list, name:"list#{n+1}", order_on_board: n+1)
      end

      get :index, format: :json
      expect( JSON.parse(response.body).count ).to eq 4
    end
  end

end
