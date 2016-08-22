class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      #this will create an integer field named: question_id with extra options:
        #foreign_key - true creates FK in DB
        #index - true creates an index
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
