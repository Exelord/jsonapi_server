# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.timestamps
    end

    add_reference :users, :account, index: true
  end
end
