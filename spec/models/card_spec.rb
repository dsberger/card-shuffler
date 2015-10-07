require 'rails_helper'

describe Card do
  let(:board){ Board.create(name:"TestBoard")}
  let(:list){ List.create({name:"TestList", board_id: board.id})}

  it "must have a name" do
    card = Card.new(name:" ", list_id: list.id, color:"000000")
    expect(card).not_to be_valid
  end

  it "must have a list" do
    card = Card.new(name:"Test", list_id:nil, color:"000000")
    expect(card).not_to be_valid
  end

  it "must have a color" do
    card = Card.new(name:"Test", list_id: list.id, color:nil)
    expect(card).not_to be_valid
  end

  it "has an associated list" do
    card = Card.create(name:"Test", list_id: list.id, color:"000000")
    expect(card).to respond_to :list
  end
end
