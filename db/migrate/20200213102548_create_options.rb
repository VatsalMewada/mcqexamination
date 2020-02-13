class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|

      t.string :option
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
