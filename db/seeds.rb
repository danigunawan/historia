user1 = User.create(:name => 'Hamilton', :email => 'hamilton@email.com', :password => 'kittens', :password_confirmation => 'kittens', :avatar => 'http://featuredcreature.com/wp-content/uploads/2014/10/031D8D7F-AC33-4117-B9B0-903957FAF506.jpg')

user2 = User.create(:name => 'Venus', :email => 'venus@email.com', :password => 'kittens', :password_confirmation => 'kittens', :avatar => 'http://static.boredpanda.com/blog/wp-content/uploads/2014/11/most-popular-cats-venus-21.jpg')

place1 = Place.create(:name => 'Pamukkale, Turkey', :latitude => '37.9205', :longitude => '29.121', :fact => 'Pamukkale means "cotton castle" in Turkish', :content => 'Pamukkale, meaning "cotton castle" in Turkish, is a natural site in Denizli Province in southwestern Turkey. The city contains hot springs and travertines, terraces of carbonate minerals left by the flowing water.' )

place2 = Place.create(:name => 'Château Gaillard', :latitude => '49.238611', :longitude => '1.402222', :fact => 'Château Gaillard means "Saucy Castle" in French', :content => 'Château Gaillard is a ruined medieval castle, located 90 m above the commune of Les Andelys overlooking the River Seine, in the Eure département of historical Normandy, now Upper Normandy, France. It is located some 95 kilometres (59 mi) north-west of Paris and 40 kilometres (25 mi) from Rouen. Construction began in 1196 under the auspices of Richard the Lionheart, who was simultaneously King of England and feudal Duke of Normandy. The castle was expensive to build, but the majority of the work was done in an unusually short time. It took just two years, and at the same time the town of Petit Andely was constructed. Château Gaillard has a complex and advanced design, and uses early principles of concentric fortification; it was also one of the earliest European castles to use machicolations.')

photo1 = Photo.create(:image => 'http://www.turklandtravel.com/wp-content/uploads/pamukkale4.jpg', :place_id => place1.id)
photo2 = Photo.create(:image => 'http://www.lesandelys-tourisme.fr/wp-content/uploads/krea3medias/chateau-gaillard-304.jpg', :place_id => place2.id)

Like.create(:user_id => user1.id, :place_id => place2.id)
Like.create(:user_id => user2.id, :place_id => place1.id)