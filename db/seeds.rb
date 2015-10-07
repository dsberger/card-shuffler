# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Board.destroy_all
List.destroy_all
Card.destroy_all

board = Board.create(name: "The Only Board")

list_a = List.create(name: "A", board: board, order_on_board: 1)
list_b = List.create(name: "B", board: board, order_on_board: 2)
list_c = List.create(name: "C", board: board, order_on_board: 3)
list_d = List.create(name: "D", board: board, order_on_board: 4)

letters = ("A".."Z").to_a
colors = ["FF0000", "FFD600", "4010C5", "00DA00"]
lists = [list_a, list_b, list_c, list_d]

26.times do |n|
  c = Card.new
  c.name = letters[n]
  c.color = colors[ n % 4 ]
  c.list = lists[ n % 4 ]
  c.order_on_list = (c.list.cards.count + 1)
  c.save
end
