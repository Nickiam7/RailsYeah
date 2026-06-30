class CreateLectures < ActiveRecord::Migration[8.0]
  def change
    create_table :lectures do |t|
      t.references :curriculum_section, null: false, foreign_key: true
      t.string :title, null: false
      t.string :duration
      t.string :lecture_type, null: false, default: "video"
      t.boolean :preview, null: false, default: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :lectures, [ :curriculum_section_id, :position ]
  end
end
