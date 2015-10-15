class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board_id, :name, :color, presence: true

  def self.move(from, to)
    moving = List.find_by_order_on_board(from)

    if from > to
      moveDown(from, to)
    else
      moveUp(from, to)
    end

    moving.order_on_board = to
    moving.save
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
