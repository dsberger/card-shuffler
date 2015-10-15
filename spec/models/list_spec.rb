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

  describe ".move" do
    
    context "to an adjacent location" do

      before do
        4.times do |n|
          create(:list, name:"list#{n+1}", order_on_board: n+1)
        end
      end

      context "moving up" do
        before do
          id = List.find_by_name("list2").id
          List.move(id,3)
        end

        it "gives the moving list the correct order" do
          expect(List.find_by_name("list2").order_on_board).to eq 3
        end

        it "gives the displaced list the correct order" do
          expect(List.find_by_name("list3").order_on_board).to eq 2
        end

        it "leaves the earlier list undisturbed" do
          expect(List.find_by_name("list1").order_on_board).to eq 1
        end

        it "leaves the later list undisturbed" do
          expect(List.find_by_name("list4").order_on_board).to eq 4
        end
      end

      context "moving down" do

        before do
          id = List.find_by_name("list3").id
          List.move(id,2)
        end

        it "gives the moving list the correct order" do
          expect(List.find_by_name("list2").order_on_board).to eq 3
        end

        it "gives the displaced list the correct order" do
          expect(List.find_by_name("list3").order_on_board).to eq 2
        end

        it "leaves the earlier list undisturbed" do
          expect(List.find_by_name("list1").order_on_board).to eq 1
        end

        it "leaves the later list undisturbed" do
          expect(List.find_by_name("list4").order_on_board).to eq 4
        end
      end
    end

    context "to a non-adjacent location" do

      before do
        6.times do |n|
          create(:list, name:"list#{n+1}", order_on_board: n+1)
        end
      end

      context "moving up" do

        before do
          id = List.find_by_name("list5").id
          List.move(id,2)
        end

        it "gives the moving list the correct order" do
          expect(List.find_by_name("list5").order_on_board).to eq 2
        end

        it "iterates the order of the displaced lists down by one" do
          expect(List.find_by_name("list2").order_on_board).to eq 3
          expect(List.find_by_name("list3").order_on_board).to eq 4
          expect(List.find_by_name("list4").order_on_board).to eq 5
        end

        it "leaves the earlier list undisturbed" do
          expect(List.find_by_name("list1").order_on_board).to eq 1
        end

        it "leaves the later list undisturbed" do
          expect(List.find_by_name("list6").order_on_board).to eq 6
        end
      end

      context "moving down" do

        before do
          id = List.find_by_name("list2").id
          List.move(id,5)
        end

        it "gives the moving list the correct order" do
          expect(List.find_by_name("list2").order_on_board).to eq 5
        end
        it "iterates the order of the displaced lists up by one"  do
          expect(List.find_by_name("list3").order_on_board).to eq 2
          expect(List.find_by_name("list4").order_on_board).to eq 3
          expect(List.find_by_name("list5").order_on_board).to eq 4
        end

        it "leaves the earlier list undisturbed" do
          expect(List.find_by_name("list1").order_on_board).to eq 1
        end
        it "leaves the later list undisturbed" do
          expect(List.find_by_name("list6").order_on_board).to eq 6
        end
      end
    end

  end
end
