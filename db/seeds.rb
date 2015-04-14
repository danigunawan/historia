User.destroy_all
# Place.destroy_all
Photo.destroy_all
Like.destroy_all

user1 = User.create(:name => 'Hamilton', :email => 'hamilton@email.com', :password => 'chicken', :password_confirmation => 'chicken', :avatar => 'http://featuredcreature.com/wp-content/uploads/2014/10/031D8D7F-AC33-4117-B9B0-903957FAF506.jpg', :activation_digest => '3BdBrXeQZSWqFIDRN8cxHA', :activated => true)

user2 = User.create(:name => 'Venus', :email => 'venus@email.com', :password => 'chicken', :password_confirmation => 'chicken', :avatar => 'http://static.boredpanda.com/blog/wp-content/uploads/2014/11/most-popular-cats-venus-21.jpg', :activation_digest => '3BdBrXeQZSWqFIDRN8cxHA', :activated => true)

admin = User.create(:name => 'Admin', :email => 'admin@email.com', :password => 'kittens', :password_confirmation => 'kittens', :is_admin => true, :activation_digest => '3BdBrXeQZSWqFIDRN8cxHA', :activated => true)

# place1 = Place.create(:name => 'Pamukkale, Turkey', :latitude => '37.9205', :longitude => '29.121', :fact => 'Pamukkale means "cotton castle" in Turkish', :content => 'Pamukkale, meaning "cotton castle" in Turkish, is a natural site in Denizli Province in southwestern Turkey. The city contains hot springs and travertines, terraces of carbonate minerals left by the flowing water.', :image => 'http://www.turklandtravel.com/wp-content/uploads/pamukkale4.jpg')

# place2 = Place.create(:name => 'Borobudur, Indonesia', :latitude => '-7.608', :longitude => '110.204', :fact => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', :content => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aspernatur dolore est necessitatibus ratione odio accusamus ut eligendi ipsa illum maiores perferendis magni, alias odit commodi nihil sunt, tempore esse voluptas.', :image => 'http://pixabay.com/get/71306a1d4ce0495499d7/1427722900/borobudur-513465_1280.jpg')
# place3 = Place.create(:name => 'Prambanan, Indonesia', :latitude => '-7.752222', :longitude => '110.491667', :fact => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', :content => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis quod, repellat sed veniam odit, iusto. Voluptatibus aspernatur harum pariatur repellat beatae, similique, dicta est repudiandae vero, ipsam inventore quam non.', :image => 'http://pixabay.com/get/b5b7b9870c8fd2679214/1427723066/temple-598969_1280.jpg')
# place4 = Place.create(:name => 'Isfahan, Iran', :latitude => '32.633333', :longitude => '51.65', :fact => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', :content => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quia, vitae assumenda expedita nihil odio sint quo dolor vero architecto aliquid eveniet, quod eligendi. Modi, aut nemo suscipit, quidem magni neque.', :image => 'https://upload.wikimedia.org/wikipedia/commons/6/69/Khaju_Bridje_at_night.jpg')
# place5 = Place.create(:name => 'Mount Athos, Greece', :latitude => '40.157222', :longitude => '24.326389', :fact => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', :content => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quia corrupti, repudiandae animi fugit. Sint consequatur, atque eaque possimus velit veritatis quisquam optio unde, eius perferendis, reiciendis ipsa pariatur. Rem, nesciunt.', :image => 'http://pixabay.com/get/fe8f2bb5a5a3d012ce4f/1427723648/mount-athos-90616_1280.jpg')

# place6 = Place.create(:name => 'Avebury, United Kingdom', :latitude => '51.428611', :longitude => '-1.854167', :fact => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', :content => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quia corrupti, repudiandae animi fugit. Sint consequatur, atque eaque possimus velit veritatis quisquam optio unde, eius perferendis, reiciendis ipsa pariatur. Rem, nesciunt.', :image => 'http://pixabay.com/get/db27d7a28ff029dd72e8/1427724186/stone-67817_1280.jpg')



# photo1 = Photo.create(:image => 'http://www.turklandtravel.com/wp-content/uploads/pamukkale4.jpg', :place_id => place1.id)
# photo2 = Photo.create(:image => 'http://pixabay.com/get/71306a1d4ce0495499d7/1427722900/borobudur-513465_1280.jpg', :place_id => place2.id)
# photo3 = Photo.create(:image => 'http://pixabay.com/get/b5b7b9870c8fd2679214/1427723066/temple-598969_1280.jpg', :place_id => place3.id)
# photo4 = Photo.create(:image => 'http://pixabay.com/get/7d24d5ad72214c2fd7a5/1427723191/ancient-672291_1280.jpg', :place_id => place4.id)
# photo5 = Photo.create(:image => 'http://pixabay.com/get/fe8f2bb5a5a3d012ce4f/1427723648/mount-athos-90616_1280.jpg', :place_id => place5.id)
# photo6 = Photo.create(:image => 'http://pixabay.com/get/db27d7a28ff029dd72e8/1427724186/stone-67817_1280.jpg', :place_id => place6.id)


# Like.create(:user_id => user1.id, :place_id => place2.id)
# Like.create(:user_id => user2.id, :place_id => place1.id)