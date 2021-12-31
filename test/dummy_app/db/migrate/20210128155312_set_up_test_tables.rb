if defined?(ActiveRecord::Migration::Current)
  migration_klass = ActiveRecord::Migration::Current
else
  migration_klass = ActiveRecord::Migration
end

class SetUpTestTables < migration_klass

  def change
    create_table :posts do |t|
      t.string :name
    end

    create_table :comments do |t|
      t.references :post
      t.string :content
    end
  end

end
