# terminal: rails g controllers contact
# g - for generate

class ContactController < ApplicationController
  def new
  end
  def create
    @name = params[:name]
  end
end
