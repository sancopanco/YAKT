# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# UserRoles
owner_role =  Role.create(:name =>  'owner')
member_role = Role.create(:name  => 'member')
s2 = State.create(:name => 'TODO', :capacity=> 5, :position => 2,:category =>"Custom")
s1 = State.create(:name => 'BackLog', :capacity => 5, :position => 1,:category =>"BackLog")
s3 = State.create(:name => 'Archive', :capacity=> 5, :position => 3,:category =>"Archive")
#test user
u = User.create(:email=>"test@test.com",:password => "123")
b = Board.create(:name=>"test_app")
b.owner = u
u.memberships.create role: owner_role, board: b


#USER STATE AND CARDS
s1.board = b
s2.board = b
s3.board = b

#have some cards

p = Priority.create(:name=> 'Low') 
c1 = Card.create(:name=>"test1",:position=>0)
c1.priority = p 
c1.owner = u
c1.state = s1
c1.save
#have have some task
t1 = Task.create(:name=>"test")
t1.card = c1

c2 = Card.create(:name=>"test2",:position=>0)
c2.priority =  p
c2.owner = u
c2.state = s1
c2.save
c3 = Card.create(:name=>"test3",:position=>0)
c3.priority =  p
c3.owner = u
c3.state = s1
c3.save





