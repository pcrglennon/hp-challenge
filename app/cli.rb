require_relative './query_runner'

class Cli
  attr_reader :query_runner

  def initialize
    @query_runner = QueryRunner.new
  end

  def run
    puts "Welcome, follow the instructions to find upcoming bike rentals"
    puts "Enter 'exit' at any time to exit the program"
    loop do
      color = get_bike_color
      break if color == "exit"
      category = get_bike_category
      break if category == "exit"
      list_upcoming_rentals(color: color, category: category)
    end
    puts "Goodbye!"
  end

  def get_bike_color
    print "Bike color(hit enter to skip) "
    get_input
  end

  def get_bike_category
    print "Bike category(hit enter to skip) "
    get_input
  end

  def list_upcoming_rentals(bike_params)
    # Skip blank parameters
    bike_params = bike_params.reject { |k, v| v.nil? || v.empty? }
    query_runner.upcoming_rentals(bike_params, benchmarks: true)
  end

  private

    # Specify STDOUT as the explicit receiver for puts
    # STDOUT/STDIN must be specified when doing IO within a rake task
    def puts(output)
      STDOUT.puts output
    end

    # Print prompt, then get and return input
    def get_input
      print prompt
      STDIN.gets.chomp
    end

    def prompt
      " > "
    end

end