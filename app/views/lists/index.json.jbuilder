json.array! @lists do |list|
  json.id list.id
  json.name list.name
  json.color list.color
  json.order_on_board list.order_on_board
  json.cards list.cards do |card|
    json.id card.id
    json.name card.name
    json.order_on_list card.order_on_list
    json.color card.color
  end
end
