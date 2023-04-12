class PauriFootnotes < ActiveRecord::Migration[7.0]
  def change
    create_table :pauri_footnotes do |t|
      t.references :pauri, :foreign_key => true, :null => false
      t.string :content
      t.string :bhai_vir_singh_footnote

      t.timestamps
    end
  end
end
