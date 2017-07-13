class UsersController < ApplicationController

  def holdouts
    @holdouts = User.select { |u| u.active && u.computers.count == 0 }.sort_by { |u| u.name }
  end

end
