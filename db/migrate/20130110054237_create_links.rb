# Put your database migration here!
#
# Each one needs to be named correctly:
# timestamp_[action]_[class]
#
# and once a migration is run, a new one must
# be created with a later timestamp.

class CreateLinks < ActiveRecord::Migration
    # PUT MIGRATION CODE HERE TO SETUP DATABASE

    def self.up
    	create_table :links do |t|
	     	t.column :full_url, :string
	     	t.column :short_url, :string
	     	t.column :description, :text
	     	t.column :created_at, :datetime
	     	t.column :updated_at, :datetime
   		end
    end

    def self.down
    	drop_table :links
    end

end