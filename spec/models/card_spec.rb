require 'rails_helper'

describe Card do

  it "has a valid factory" do
    card = build(:card)
    expect(card).to be_valid
  end

  it "must have a name" do
    card = build(:card, name: nil)
    expect(card).not_to be_valid
  end

  it "must have a list" do
    card = build(:card, list: nil)
    expect(card).not_to be_valid
  end

  it "must have a color" do
    card = build(:card, color: nil)
    expect(card).not_to be_valid
  end

  it "has an associated list" do
    card = build(:card)
    expect(card).to respond_to :list
  end
end
