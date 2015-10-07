require 'rails_helper'

describe Board do

  it "must have a name" do
    board = Board.new(name: nil)
    expect(board).not_to be_valid
  end

  it "has associated lists" do
    board = Board.new(name: "Test")
    expect(board).to respond_to :lists
  end

end
