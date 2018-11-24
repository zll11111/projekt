class CreateAttachFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :attach_files do |t|
      t.text :file_data

      t.timestamps
    end
  end
end
