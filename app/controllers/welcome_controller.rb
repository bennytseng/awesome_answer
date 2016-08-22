class WelcomeController < ApplicationController
  #this defines a controller 'action'
  def index

    #this will render 'index.html.erb' in views/WelcomeController
    #index: refers to the controller action
    #html: refers to the format (default is html)
    #erb: refers to the templating system (erb is built-in with rails)

  end

  def about_me
    #there is no content here... because rail is doing shit in the background
  end
end
