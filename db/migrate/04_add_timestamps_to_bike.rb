class AddTimestampsToBike < ActiveRecord::Migration
  change_table :bikes do |t|
    t.timestamps
  end
end