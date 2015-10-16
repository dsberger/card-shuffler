class Card < ActiveRecord::Base
  belongs_to :list

  validates :name, :list_id, :color, presence: true

  def position
    list.name + order_on_list.to_s
  end

  def self.move( card_id, new_list, to_card )
    moving_card = Card.find card_id
    from_card = moving_card.order_on_list
    
    if from_card < to_card
      Card.move_up( moving_card.list.id, from_card, to_card )
    else
      Card.move_down( moving_card.list.id, from_card, to_card )
    end

    moving_card.order_on_list = to_card
    moving_card.save
  end

  private

  def self.move_up(list_id, from, to)
    displaced = List.find(list_id).cards
      .where(order_on_list: (from + 1..to))

    displaced.each do |card|
      card.order_on_list -= 1
      card.save
    end
  end

  def self.move_down(list_id, from, to)
    displaced = List.find(list_id).cards
      .where(order_on_list: (to.. from - 1))
    
    displaced.each do |card|
      card.order_on_list += 1
      card.save
    end
  end
end
