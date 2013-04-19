class AddPublishToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :publish, :boolean, default: true
  end
end
