class CreatePersonalMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :personal_messages do |t|
      t.text :body
      t.belongs_to :conversation, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.boolean :read, default: false

      t.timestamps

      add_index :conversations, [:author_id, :receiver_id], unique: true
    end
  end
end
