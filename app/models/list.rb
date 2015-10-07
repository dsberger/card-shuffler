class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board_id, presence: true
  validates :name, presence: true
end
