require 'rails_helper'

describe List do

  it "must have a board" do
    list = List.new({name: "Test", board_id:nil})
    expect(list).not_to be_valid
  end

  it "must have a name" do
    board = Board.create(name: "Test")
    list = List.new({name: "", board_id: board.id})
    expect(list).not_to be_valid
  end
end
