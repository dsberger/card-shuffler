require 'rails_helper'

describe ListOrderController do

  describe 'PATCH update' do
    before do
      4.times do |n|
        create(:list, name:"list#{n+1}", order_on_board: n+1)
      end
    end

    it "calls on List.move"
    it "redirects to lists#index"

  end

end
