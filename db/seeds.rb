# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#=begin
#g2 = Gym.create(name: 'BKB Brooklyn', location: '575 Degraw St, Brooklyn, NY 11217')
#g1 = Gym.create(name: 'BKB Queensbridge', location: '23-10 41st Avenue, Queens, NY 11101')


#w1 = Wall.create(name: '45', wall_type: "Boulder", gym: g2)
#Climb.create(climb_type: 'Boulder', grade: 'V1', setter_id: 1, color: 'Red', wall: w1)
# Climb.create(climb_type: 'Boulder', grade: 'V5', setter: 'AT', color: 'Blue', wall: w1)
# Climb.create(climb_type: 'Boulder', grade: 'V10', setter: 'GK', color: 'White', wall: w1)

w2 = Wall.create(name: 'highball', wall_type: "Boulder", gym_id: 3)
 Climb.create(climb_type: 'Boulder', grade: 'V2', routesetter: 'JB', setter_id: 1, color: 'Blue', wall: w2)
 Climb.create(climb_type: 'Boulder', grade: 'V4', routesetter: 'AT', setter_id: 3, color: 'Green', wall: w2)
 Climb.create(climb_type: 'Boulder', grade: 'V6', routesetter: 'GK', setter_id: 2, color: 'Red', wall: w2)

#w3 = Wall.create(name: 'beast', wall_type: "Boulder", gym: g2)
# Climb.create(climb_type: 'Boulder', grade: 'V7', setter: 'JB', color: 'Red', wall: w3)
# Climb.create(climb_type: 'Boulder', grade: 'V3', setter: 'AT', color: 'Blue', wall: w3)
# Climb.create(climb_type: 'Boulder', grade: 'V9', setter: 'GK', color: 'Green', wall: w3)

#w4 = Wall.create(name: 'workshop', wall_type: "Boulder", gym: g2)
# Climb.create(climb_type: 'Boulder', grade: 'V5', setter: 'JB', color: 'Blue', wall: w4)
# Climb.create(climb_type: 'Boulder', grade: 'V0', setter: 'AT', color: 'Red', wall: w4)
# Climb.create(climb_type: 'Boulder', grade: 'V7', setter: 'GK', color: 'White', wall: w4)

#w5 = Wall.create(name: 'Blue Wall', wall_type: "Route", gym: g2)
# Climb.create(climb_type: 'Route', grade: '5.10b', setter: 'JB', color: 'Blue', wall: w5)
# Climb.create(climb_type: 'Route', grade: '5.6', setter: 'AT', color: 'Red', wall: w5)
# Climb.create(climb_type: 'Route', grade: '5.11c', setter: 'GK', color: 'White', wall: w5)
# Climb.create(climb_type: 'Route', grade: '5.13d', setter: 'HH', color: 'Teal', wall: w5)
# Climb.create(climb_type: 'Route', grade: '5.9', setter: 'MB', color: 'Orange', wall: w5)

#jeremy = User.create(full_name: "Jeremy Bini", email: "jeremybini@gmail.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"123456789", role: "admin")
# gk = User.create(full_name: "Garrett Koeppicus", email: "garrett@brooklynboulders.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"123456789", role: "Admin")
# at = User.create(full_name: "Alexi Thomakos", email: "thomakos.alexi@gmail.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"123456789", role: "Admin")
# ps = User.create(full_name: "Phil Schaal", email: "phillip@brooklynboulders.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"123456789", role: "Admin")
# wc = User.create(full_name: "Will Castelli", email: "willcastelli@gmail.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"223456789", role: "Routesetter")
# mb = User.create(full_name: "Miles Brooks", email: "milesfbrooks@gmail.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"223456789", role: "Routesetter")
# om = User.create(full_name: "Oliver Miska", email: "olivermiska@gmail.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"223456789", role: "Routesetter")
#hh = User.create(full_name: "JB User", email: "jbuser@gmail.com", password: "boulders1234", password_confirmation:"boulders1234", auth_token:"323456789")


