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

      before do
        list_in = List.find_by_name("list3") 
        card = Card.find_by_name("card7")
        Card.move( card.id, list_in.id, 4 )
      end

      it "shortens the list it's leaving by one" do
        expect( List.find_by_name("list2").cards.count).to eq 4
      end

      it "iterates down all the cards that follow it in the list it's leaving" do
        expect( Card.find_by_name("card8").order_on_list).to eq 2
        expect( Card.find_by_name("card9").order_on_list).to eq 3
        expect( Card.find_by_name("card10").order_on_list).to eq 4
      end

      it "leaves the cards that precede it on the list it's leaving untouched" do
        expect( Card.find_by_name("card6").order_on_list).to eq 1
      end

      it "lengthens the list it's inserted into by one" do
        expect( List.find_by_name("list3").cards.count).to eq 6
      end

      it "iterates up all the cards after it on the list it's inserted into" do
        expect( Card.find_by_name("card14").order_on_list).to eq 5
        expect( Card.find_by_name("card15").order_on_list).to eq 6
      end

      it "leaves the cards that precede it in the list it's inserted into untouched" do
        expect( Card.find_by_name("card11").order_on_list).to eq 1
        expect( Card.find_by_name("card12").order_on_list).to eq 2
        expect( Card.find_by_name("card13").order_on_list).to eq 3
      end
    end
  end
end
