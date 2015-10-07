class Board < ActiveRecord::Base

  has_many :lists

  validates :name, presence: true

end
