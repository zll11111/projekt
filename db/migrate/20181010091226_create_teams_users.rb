class CreateTeamsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
