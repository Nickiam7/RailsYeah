class CreateCourseStats < ActiveRecord::Migration[8.0]
  def change
    create_table :course_stats do |t|
      t.decimal :rating, precision: 3, scale: 2
      t.integer :reviews_count
      t.datetime :synced_at

      t.timestamps
    end
  end
end
