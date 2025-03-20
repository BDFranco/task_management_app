class AddProjectIdToTasks < ActiveRecord::Migration[8.0]
  def change
    t.references :project, null: true, foreign_key: true
  end
end
