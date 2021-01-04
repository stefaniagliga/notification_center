# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create the two available roles: Admin and Client
admin_role = Role.create(name: 'Admin')
client_role = Role.create(name: 'Client')

#Create a user that's an admin
admin = User.create(email: 'example@gmail.com',
                    name: 'Example Name',
                    password_digest: BCrypt::Password.create('lalala'),
                    role: admin_role)
client = User.create(email: 'cliente@gmail.com',
                     name: 'Client Name',
                     password_digest: BCrypt::Password.create('client'),
                     role: client_role)

notification1 = Notification.create(title: 'Example Notification',
                                    date: Time.zone.now,
                                    description: 'Lalalala',
                                    created_by: admin.id)
notification2 = Notification.create(title: 'Example Notification 2',
                                    date: Time.zone.now,
                                    description: 'Blabla',
                                    created_by: admin.id)

user_notification1 = UserNotification.create(notification_id: notification1.id,
                                             user_id: client.id,
                                             seen: false)

user_notification2 = UserNotification.create(notification_id: notification2.id,
                                             user_id: client.id,
                                             seen: false)

