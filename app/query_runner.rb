require_relative '../config/environment'
require 'benchmark'

class QueryRunner

  def self.users_with_bikes(bike_params)
    puts Benchmark.measure { User.with_bikes_join(bike_params) }
    puts Benchmark.measure { User.with_bikes_include(bike_params) }
    puts Benchmark.measure { User.with_bikes_naive(bike_params) }
  end

end