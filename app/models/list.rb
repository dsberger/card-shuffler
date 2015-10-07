class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board_id, :name, :color, presence: true
end
