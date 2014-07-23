class CreateTagtopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic
    end
  end
end
