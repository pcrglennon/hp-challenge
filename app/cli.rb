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
      list_upcoming_rentals(normalize_bike_params(color, category))
    end
    puts "Goodbye!"
  end

  def get_bike_color
    print "Bike color(enter to skip) "
    get_input
  end

  def get_bike_category
    print "Bike category(enter to skip) "
    get_input
  end

  # Normalize the hash of bike_params, so if user hits enter to skip a parameter,
  # that parameter will be ignored by the QueryRunner
  def normalize_bike_params(color, category)
    {color: color, category: category}.reject { |k, v| v.nil? || v.empty? }
  end

  def list_upcoming_rentals(bike_params)
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