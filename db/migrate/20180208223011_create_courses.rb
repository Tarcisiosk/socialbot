class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.datetime :time_available
      t.string :logo_url
      t.timestamps
    end
  end
end
