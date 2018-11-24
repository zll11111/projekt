class Project < ApplicationRecord
  belongs_to :user
  belongs_to :team

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          name: Proc.new{|controller, model| model.name}
end
