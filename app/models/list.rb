class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board_id, :name, :color, presence: true

  def self.move(list_id, to)
    moving_list = List.find list_id
    from = moving_list.order_on_board

    from > to ? moveDown(from, to) : moveUp(from, to)

    moving_list.order_on_board = to
    moving_list.save
  end

  private

  def self.moveUp(from, to)
    displaced = List.where(order_on_board: (from+1..to))
    displaced.each do |list|
      list.order_on_board -= 1
      list.save
    end
  end

  def self.moveDown(from, to)
    displaced = List.where(order_on_board: (to..from-1))
    displaced.each do |list|
      list.order_on_board += 1
      list.save
    end
  end
end
