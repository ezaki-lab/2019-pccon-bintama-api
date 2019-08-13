# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Device.create(
	[
		{
			token: 'test1',
			url: 'http://test1'
		},
		{
			token: 'test2',
			url: 'http://test2'
		},
		{
			token: 'test3',
			url: 'http://test3'
		}
	]
)

DevicePlace.create(
	[
		{
			device_id: 1,
			latitude: '123',
			longitude: '25'
		},
		{
			device_id: 2,
			latitude: '32',
			longitude: '192'
		},
		{
			device_id: 3,
			latitude: '143',
			longitude: '125'
		}
	]
)
