# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

State.create(name: 'Backlog', capacity: 5, position: 1)
State.create(name: 'Archive', capacity: 5, position: 2)
State.create(name: 'state 3', capacity: 5, position: 3)

# Priority
Priority.create(name: 'High')
Priority.create(name: 'Medium')
Priority.create(name: 'Low')

# CardType
Cardtype.create(name: 'Epic')
Cardtype.create(name: 'Story')
Cardtype.create(name: 'Feature')
Cardtype.create(name: 'Enhancement')

# UserRoles
Role.create(name: 'owner')
Role.create(name: 'member')
