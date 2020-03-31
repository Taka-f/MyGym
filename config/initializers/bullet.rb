unless Rails.env.production?
  Bullet.add_whitelist :type => :counter_cache, :class_name => "Review", :association => :goods
  Bullet.add_whitelist :type => :counter_cache, :class_name => "Review", :association => :gym
  Bullet.add_whitelist :type => :n_plus_one_query, :class_name => "Review", :association => :gym
  Bullet.add_whitelist :type => :n_plus_one_query, :class_name => "Review", :association => :goods
  Bullet.add_whitelist :type => :n_plus_one_query, :class_name => "Review", :association => :user
end