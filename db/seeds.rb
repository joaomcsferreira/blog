r1 = Role.create({ name: 'Author', description: 'Can read and create articles. Can update and destroy own articles' })
r2 = Role.create({ name: 'Leader-writer', description: 'Can read articles and edit any article' })
r3 = Role.create({ name: 'Admin', description: 'Can perform any CRUD operation on any resource' })

u1 = User.create({ name: 'Sally', email: 'sally@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r1.id })
u2 = User.create({ name: 'Sue', email: 'sue@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r2.id })
u3 = User.create({ name: 'Kev', email: 'kev@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r2.id })
u4 = User.create({ name: 'Jon', email: 'jon@example.com', password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa', role_id: r3.id })