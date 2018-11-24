class HomeController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where({owner_id: current_user.id,owner_type: "User"}).order(created_at: :desc)
  end
end
