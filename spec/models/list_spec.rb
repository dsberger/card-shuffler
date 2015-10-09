require 'rails_helper'

describe List do

  it "has a valid factory" do
    list = build(:list)
    expect(list).to be_valid
  end

  it "must have a board" do
    list = build(:list, board: nil)
    expect(list).not_to be_valid
  end

  it "must have a name" do
    list = build(:list, name: nil)
    expect(list).not_to be_valid
  end

  it "must have a color" do
    list = build(:list, color: nil)
    expect(list).not_to be_valid
  end

  describe "associations" do
    
    let(:list){ build(:list) }

    it "has an associated board" do
      expect(list).to respond_to :board
    end

    it "has associated cards" do
      expect(list).to respond_to :cards
    end
  end
end
