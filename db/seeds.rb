super_admin = User.create(full_name: "Jeremy Bini", email: "jeremybini@gmail.com", password: "boulder1234", password_confirmation:"boulder1234", auth_token: "523456789", role: "Super Admin")
manager = User.create(full_name: "Boss Person", email: "manager@email.com", password: "manager1234", password_confirmation:"manager1234", auth_token:"123456789", role: "Admin")
setter = User.create(full_name: "Route Setter"), email: "setter@email.com", password: "setter1234", password_confirmation: "setter134", auth_token:"423456789", role: "Routesetter")
user = User.create(full_name: "Regular Ol' User", email: "user@email.com", password: "user1234", password_confirmation:"user1234", auth_token:"323456789")

