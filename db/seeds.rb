# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tag.create([
  { name: '24時間営業'},
  { name: 'ビジター有り'},
  { name: 'マシン充実'},
  { name: 'フリーウエイト充実'},
  { name: '駐車場有り'},
  { name: '駅近'},
  { name: 'トレーナー在籍'},
  { name: 'シャワー有り'},
  { name: 'トライアル有り'},
  { name: 'プロテインBAR'},
  { name: 'タンニングマシン有り'},
  { name: '複数店舗利用可'},
  { name: 'カリキュラム有り'}
])
Area.create([
  { name: '福岡'},
  { name: '東京'},
  { name: '大阪'},
  { name: '名古屋'}
])