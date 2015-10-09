require 'rails_helper'

describe Board do

  it "has a valid factory" do
    board = build(:board)
    expect(board).to be_valid
  end

  it "must have a name" do
    board = build(:board, name: nil)
    expect(board).not_to be_valid
  end

  it "has associated lists" do
    board = create(:board)
    expect(board).to respond_to :lists
  end

end
