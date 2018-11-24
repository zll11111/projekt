class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.belongs_to :user, index:true, foreign_key:true
      t.belongs_to :team, index:true, foreign_key:true
      t.timestamps
    end
  end
end
