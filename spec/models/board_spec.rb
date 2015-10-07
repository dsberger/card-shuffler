require 'rails_helper'

describe Board do
  it "must have a name" do
    board = Board.new(name: nil)
    expect(board).not_to be_valid
  end
end
