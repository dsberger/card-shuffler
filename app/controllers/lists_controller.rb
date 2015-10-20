class ListsController < ApplicationController

  def index
    @lists = List.all
    render file: "#{Rails.root}/app/views/lists/index.json.jbuilder"
  end

end
