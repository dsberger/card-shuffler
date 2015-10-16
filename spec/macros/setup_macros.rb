module SetupMacros
  
  def set_up_lists( num )
    num.times do |n|
      create(:list, name:"list#{n+1}", order_on_board: n+1)
    end
  end

  def set_up_full_board
    set_up_lists 4

    20.times do |n|
      list = List.find_by_name("list#{(n/5)+1}")
      create(:card,
             name:"card#{n+1}",
             list: list,
             order_on_list: list.cards.count + 1)
    end

  end
end
