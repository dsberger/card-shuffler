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

letters = ("A".."Z").to_a
colors = ["FF0000", "FFD600", "00DA00", "4010C5"]

lists = []

4.times do |n|
  l = List.new

  l.name = letters[n]
  l.color = colors[n]

  l.board = board
  l.order_on_board = n + 1

  l.save
  lists << l
end

26.times do |n|
  c = Card.new
  c.name = letters[n]
  c.color = colors[ n % 4 ]
  c.list = lists[ n % 4 ]
  c.order_on_list = (c.list.cards.count + 1)
  c.save
end
