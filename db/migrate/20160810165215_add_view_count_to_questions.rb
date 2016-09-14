class AddViewCountToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :users, :reference
  end
end
