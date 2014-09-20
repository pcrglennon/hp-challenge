require_relative '../config/environment'
require 'benchmark'

class QueryRunner

  def upcoming_rentals(bike_params, options)
    # List the rentals using the most efficient method (includes)
    rentals = Rental.upcoming_includes(bike_params)
    puts "\nNumber of matching rentals: #{rentals.count}"

    if options[:benchmarks]
      benchmark_upcoming_rentals(bike_params)
    end
  end

  private

    # Benchmark each Rental::upcoming_* method
    def benchmark_upcoming_rentals(bike_params)
      puts "\nBenchmarks:"
      Benchmark.bm(13) do |x|
        ActiveRecord::Base.connection.query_cache.clear
        x.report("joins: ") { Rental.upcoming_joins(bike_params) }
        ActiveRecord::Base.connection.query_cache.clear
        x.report("includes: ") { Rental.upcoming_includes(bike_params) }
        ActiveRecord::Base.connection.query_cache.clear
        x.report("enumeration: ") { Rental.upcoming_enumeration(bike_params) }
      end
    end

end