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

  it "can tell you its position" do
    card = build(:card)
    expect(card.position).to eq card.list.name + card.order_on_list.to_s 
  end

  describe ".move" do

    before { set_up_full_board }

    describe "within the same list" do

      describe "to an adjacent location" do

        describe "moving up" do

          before do
            list = List.find_by_name("list2") 
            card = Card.find_by_name("card7")
            Card.move( card.id, list.id, 3 )
          end

          it "gives the moving card the correct order" do
            expect( Card.find_by_name("card7").order_on_list ).to eq 3
          end

          it "give the displaced card the correct order" do
            expect( Card.find_by_name("card8").order_on_list ).to eq 2
          end

          it "leaves earlier cards undisturbed" do
            expect( Card.find_by_name("card6").order_on_list ).to eq 1
          end

          it "leaves later cards undisturbed" do
            expect( Card.find_by_name("card9").order_on_list ).to eq 4
          end

        end

        describe "moving down" do

          before do
            list = List.find_by_name("list2") 
            card = Card.find_by_name("card8")
            Card.move( card.id, list.id, 2 )
          end

          it "gives the moving card the correct order" do
            expect( Card.find_by_name("card8").order_on_list ).to eq 2
          end

          it "give the displaced card the correct order" do
            expect( Card.find_by_name("card7").order_on_list ).to eq 3
          end

          it "leaves earlier cards undisturbed" do
            expect( Card.find_by_name("card6").order_on_list ).to eq 1
          end

          it "leaves later cards undisturbed" do
            expect( Card.find_by_name("card9").order_on_list ).to eq 4
          end
        end
      end

      describe "to a non-adjacent location" do

        describe "moving up" do

          before do
            list = List.find_by_name("list2") 
            card = Card.find_by_name("card7")
            Card.move( card.id, list.id, 4 )
          end

          it "gives the moving card the correct order" do
            expect( Card.find_by_name("card7").order_on_list ).to eq 4
          end

          it "give the displaced cards the correct orders" do
            expect( Card.find_by_name("card8").order_on_list ).to eq 2
            expect( Card.find_by_name("card9").order_on_list ).to eq 3
          end

          it "leaves earlier cards undisturbed" do
            expect( Card.find_by_name("card6").order_on_list ).to eq 1
          end

          it "leaves later cards undisturbed" do
            expect( Card.find_by_name("card10").order_on_list ).to eq 5
          end
        end

        describe "moving down" do
          before do
            list = List.find_by_name("list2") 
            card = Card.find_by_name("card9")
            Card.move( card.id, list.id, 2 )
          end

          it "gives the moving card the correct order" do
            expect( Card.find_by_name("card9").order_on_list ).to eq 2
          end

          it "give the displaced cards the correct orders" do
            expect( Card.find_by_name("card7").order_on_list ).to eq 3
            expect( Card.find_by_name("card8").order_on_list ).to eq 4
          end

          it "leaves earlier cards undisturbed" do
            expect( Card.find_by_name("card6").order_on_list ).to eq 1
          end

          it "leaves later cards undisturbed" do
            expect( Card.find_by_name("card10").order_on_list ).to eq 5
          end
        end
      end
    end
    
    describe "to another list" do
    end
  end
end
