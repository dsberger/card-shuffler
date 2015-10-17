class Card < ActiveRecord::Base
  belongs_to :list

  validates :name, :list_id, :color, presence: true


  def position
    list.name + order_on_list.to_s
  end


  def self.move( card_id, to_list, to_card )

    moving_card = Card.find card_id
    new_list = List.find_by_order_on_board(to_list)

    if new_list == moving_card.list

      Card.move_within_list(
        moving_card,
        new_list,
        to_card
      )

    else

      Card.move_across_lists(
        moving_card,
        new_list,
        to_card
      )

    end

  end


  private


  def self.move_within_list( card, list, new_order_on_list )

    old_order_on_list = card.order_on_list

    if old_order_on_list < new_order_on_list

      Card.iterate_order_down(
        list.id,
        old_order_on_list + 1,
        new_order_on_list
      )

    else

      Card.iterate_order_up(
        list.id,
        new_order_on_list,
        old_order_on_list - 1
      )

    end

    card.update(
      { order_on_list: new_order_on_list }
    )

  end


  def self.move_across_lists(card, new_list, new_order_on_list)

    Card.iterate_order_down(
      card.list.id,
      card.order_on_list + 1,
      card.list.cards.count
    )

    Card.iterate_order_up(
      new_list.id,
      new_order_on_list,
      new_list.cards.count
    )

    card.update(
      { list: new_list,
        order_on_list: new_order_on_list }
    )

  end


  def self.iterate_order_down(list_id, min, max)
    Card.iterate_group(list_id, min, max, -1)
  end


  def self.iterate_order_up(list_id, min, max)
    Card.iterate_group(list_id, min, max, 1)
  end


  def self.iterate_group(list_id, min, max, amount)

    displaced = List.find(list_id).cards
      .where(order_on_list: (min..max))

    displaced.each do |card|
      card.order_on_list += amount
      card.save
    end

  end
end
