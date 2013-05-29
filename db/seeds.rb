# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Style
s1 = Style.find_or_create_by_name(:name=>"TaskCard")
s2 = Style.find_or_create_by_name(:name=>"ImageCard")
s3 = Style.find_or_create_by_name(:name=>"BoardCard")
e3  = Element.create(:name=>"assigned_to",:element_object_type => 'IntType')
s1.elements << e3
e4  = Element.create(:name=>"due_date",:element_object_type => 'DateType')
s1.elements << e4
e5  = Element.create(:name=>"complation_date",:element_object_type => 'DateType')
s1.elements << e5




#UserRoles
owner_role  =  Role.find_or_create_by_name(:name =>  'owner')
member_role =  Role.find_or_create_by_name(:name => 'member')
viewer_role =  Role.find_or_create_by_name(:name => 'viewer')
admin_role  =  Role.find_or_create_by_name(:name  => 'admin')


u_owner  = User.create(:email=>"owner@example.com",:password => "123")
u_viewer = User.create(:email=>"viewer@example.com",:password => "123")
u_member = User.create(:email=>"member@example.com",:password => "123")
u_admin  = User.create(:email=>"admin@example.com",:password => "123")
board_card = Card.find_or_create_by_name(:name=>"test_board_card",:style=>s3)
task_card = Card.find_or_create_by_name(:name=>"test_task_card",:style=>s1,:state=>board_card.states.first)

##board_card.state.first << task_card

#owner user
u_owner.add_role :owner, board_card
#viwer user
u_viewer.add_role :viewer, board_card
#team member user
u_member.add_role :admin, board_card







