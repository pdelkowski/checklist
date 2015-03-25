class CreateTemplateItems < ActiveRecord::Migration
  def change
    create_table :template_items do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    # Creates template_id column and index for it
    add_reference :template_items, :template, index: true
  end
end
