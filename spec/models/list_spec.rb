require 'rails_helper'

describe List do

  it "must have a board" do
    list = List.new({name: "Test", board_id:nil, color:"000000"})
    expect(list).not_to be_valid
  end

  it "must have a name" do
    board = Board.create(name: "Test")
    list = List.new({name: "", board_id: board.id, color:"000000"})
    expect(list).not_to be_valid
  end

  it "must have a color" do
    board = Board.create(name: "Test")
    list = List.new({name: "Test", board_id: board.id, color:nil})
    expect(list).not_to be_valid
  end

  it "has an associated board" do
    board = Board.create(name: "TestBoard")
    list = List.create({name: "TestList", board_id: board.id})
    expect(list).to respond_to :board
  end

  it "has associated cards" do
    board = Board.create(name: "TestBoard")
    list = List.create({name: "TestList", board_id: board.id})
    expect(list).to respond_to :cards
  end
end
