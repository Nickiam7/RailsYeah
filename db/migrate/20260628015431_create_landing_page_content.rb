class CreateLandingPageContent < ActiveRecord::Migration[8.0]
  def change
    create_table :hero_contents do |t|
      t.string :title, null: false
      t.text :subtitle
      t.string :cta_label
      t.string :cta_url

      t.timestamps
    end

    create_table :learning_objectives do |t|
      t.string :description, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    create_table :curriculum_sections do |t|
      t.string :title, null: false
      t.integer :lectures_count
      t.string :duration
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    create_table :testimonials do |t|
      t.string :name, null: false
      t.string :role
      t.text :quote, null: false
      t.integer :rating
      t.integer :position, null: false, default: 0
      t.boolean :published, null: false, default: true

      t.timestamps
    end

    create_table :faq_items do |t|
      t.string :question, null: false
      t.text :answer, null: false
      t.integer :position, null: false, default: 0
      t.boolean :published, null: false, default: true

      t.timestamps
    end

    create_table :instructors do |t|
      t.string :name, null: false
      t.string :headline
      t.text :bio

      t.timestamps
    end
  end
end
