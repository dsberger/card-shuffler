class Card < ActiveRecord::Base
  belongs_to :list

  validates :name, :list_id, :color, presence: true
end
