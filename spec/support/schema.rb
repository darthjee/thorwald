ActiveRecord::Schema.define do
  self.verbose = false

  create_table :documents, :force => true do |t|
    t.timestamps null: true
  end
end
