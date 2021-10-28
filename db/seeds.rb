# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = 'fr'

# Choisis une ville au hasard (qui n'a pas déjà été créée)
def pick_city
  city = Faker::Address.city
  if City.find_by(city_name: city)
    pick_city
  end
  city
end

# Choisis une citation au hasard dans une grosse BDD
def pick_quote
  quote_reservoir = [
    Faker::TvShows::AquaTeenHungerForce,
    Faker::TvShows::BigBangTheory,
    Faker::TvShows::BojackHorseman,
    Faker::TvShows::Buffy,
    Faker::TvShows::DrWho,
    Faker::TvShows::DumbAndDumber,
    Faker::TvShows::FamilyGuy,
    Faker::TvShows::FinalSpace,
    Faker::TvShows::Friends,
    Faker::TvShows::GameOfThrones,
    Faker::TvShows::HeyArnold,
    Faker::TvShows::HowIMetYourMother,
    Faker::TvShows::MichaelScott,
    Faker::TvShows::NewGirl,
    Faker::TvShows::RickAndMorty,
    Faker::TvShows::RuPaul,
    Faker::TvShows::Seinfeld,
    Faker::TvShows::SiliconValley,
    Faker::TvShows::Simpsons,
    Faker::TvShows::SouthPark,
    Faker::TvShows::Stargate,
    Faker::TvShows::StrangerThings,
    Faker::TvShows::Suits,
    Faker::TvShows::TheExpanse,
    Faker::TvShows::TheFreshPrinceOfBelAir,
    Faker::TvShows::TheITCrowd,
    Faker::TvShows::TwinPeaks,
    Faker::TvShows::VentureBros,
    Faker::Movie,
    Faker::Movies::BackToTheFuture,
    Faker::Movies::Departed,
    Faker::Movies::Ghostbusters,
    Faker::Movies::HarryPotter,
    Faker::Movies::HitchhikersGuideToTheGalaxy,
    Faker::Movies::Hobbit,
    Faker::Movies::Lebowski,
    Faker::Movies::PrincessBride,
    Faker::Movies::StarWars,
    Faker::Movies::VForVendetta
  ]

  quote_reservoir[rand(0..(quote_reservoir.length - 1))].quote
end

# Remise à zéro de la BDD
Dog.destroy_all
DogSitter.destroy_all
City.destroy_all
Stroll.destroy_all

# Création des villes
25.times do
  City.create(city_name: pick_city)
end

# Création des chiens
250.times do
  Dog.create(
    name: Faker::Creature::Dog.name,
    age: Faker::Creature::Dog.age,
    breed: Faker::Creature::Dog.breed,
    gender: Faker::Creature::Dog.gender,
    size: Faker::Creature::Dog.size,
    sound: Faker::Creature::Dog.sound,
    favorite_food: Faker::Food.dish,
    city: City.all[rand(0..24)]
  )
end

# Création des dog-sitters
100.times do
  user = Faker::Internet.user

  DogSitter.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: user[:username],
    email: user[:email],
    age: rand(16..120),
    gender: Faker::Gender.type,
    favorite_movie: Faker::Movie.title,
    favorite_band: Faker::Music.band,
    favorite_beer: Faker::Beer.brand,
    bio: pick_quote,
    city: City.all[rand(0..24)]
  )
end

# Création des promenades, en s'assurant que les chiens et les dog-sitters soient de la même ville
# Si aucun dog-sitter n'est présent dans la ville du chien, en choisir un au hasard qui vient de n'importe où.
500.times do
  dog = Dog.all[rand(0..249)]
  dog_sitters = DogSitter.where(city: dog.city)
  if dog_sitters.length.zero?
    dog_sitter = DogSitter.all[rand(0..99)]
  else
    dog_sitter = dog_sitters[rand(0..(dog_sitters.length - 1))]
  end

  Stroll.create(
    dog: dog,
    dog_sitter: dog_sitter
  )
end
