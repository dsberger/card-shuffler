class Card < ActiveRecord::Base
  belongs_to :list

  validates :name, :list_id, :color, presence: true

  def position
    list.name + order_on_list.to_s
  end
end
