class UsersController < ApplicationController

  def holdouts
    @holdouts = User.all.select { |u| u.computers.count == 0 }.sort_by { |u| u.name }
  end

end
