# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# UserRoles
owner_role  =  Role.find_or_create_by_name(:name =>  'owner')
member_role =  Role.find_or_create_by_name(:name => 'member')
viewer_role =  Role.find_or_create_by_name(:name => 'viewer')
admin_role  =  Role.find_or_create_by_name(:name  => 'admin')


u_owner  =  User.create(:email=>"owner@example.com",:password => "123")
u_viewer = User.create(:email=>"viewer@example.com",:password => "123")
u_member = User.create(:email=>"member@example.com",:password => "123")
u_admin  = User.create(:email=>"admin@example.com",:password => "123")
b = Board.find_or_create_by_name(:name=>"test_board")
b.owner = u_owner
b.save
s2 = State.create(:name => 'TODO', :capacity=> 5, :position => 2,:category =>"Custom",:board => b)
s1 = State.create(:name => 'BackLog', :capacity => 5, :position => 1,:category =>"BackLog",:board => b)
s3 = State.create(:name => 'Archive', :capacity=> 5, :position => 3,:category =>"Archive",:board => b)

#owner user
u_owner.add_role :member, b
#viwer user
u_viewer.add_role :viewer, b
#team member user
u_member.add_role :admin, b



#BOARD STATES
s1.board = b
s1.save
s2.board = b
s2.sabe
s3.board = b







