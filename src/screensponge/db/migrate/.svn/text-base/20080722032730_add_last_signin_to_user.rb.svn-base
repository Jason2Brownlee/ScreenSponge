class AddLastSigninToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_signin_at, :datetime
  end

  def self.down
    remove_column :users, :last_signin_at
  end
end
