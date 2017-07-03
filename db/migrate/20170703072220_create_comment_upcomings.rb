class CreateCommentUpcomings < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_upcomings do |t|

      t.timestamps
    end
  end
end
