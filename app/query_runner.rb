require_relative '../config/environment'
require 'benchmark'

class QueryRunner

  def users_with_bikes(bike_params)
    puts "\nBenchmarks:"
    Benchmark.bm(10) do |x|
      x.report("joins: ") { User.with_bikes_join(bike_params) }
      x.report("includes: ") { User.with_bikes_include(bike_params) }
      x.report("naive: ") { User.with_bikes_naive(bike_params) }
    end
    puts "\nUsers:"
    puts User.with_bikes_include(bike_params).collect { |u| u.name }
  end

end