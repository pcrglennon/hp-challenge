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
      Benchmark.bm(10) do |x|
        x.report("joins: ") { Rental.upcoming_joins(bike_params) }
        x.report("includes: ") { Rental.upcoming_includes(bike_params) }
        x.report("naive: ") { Rental.upcoming_naive(bike_params) }
      end
    end

end