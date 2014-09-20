require_relative './query_runner'

class Cli
  attr_reader :query_runner

  def initialize
    @query_runner = QueryRunner.new
  end

  def run
    puts "\nWelcome, follow the instructions to find upcoming bike rentals"
    puts "Enter 'exit' at any time to exit the program\n\n"
    loop do
      puts "Search by category and color(optional)"
      bike_params = gather_bike_params
      list_upcoming_rentals(bike_params)
    end
  end

  def gather_bike_params
    category = get_bike_category
    color = get_bike_color
    normalize_bike_params(category, color)
  end

  def list_upcoming_rentals(bike_params)
    query_runner.upcoming_rentals(bike_params, benchmarks: true)
  end

  private

    # Category selection is required, don't allow blank value
    def get_bike_category
      category = ""
      while category.empty?
        print "Bike category(required)"
        category = get_input
      end
      category
    end

    def get_bike_color
      print "Bike color(optional, hit enter to skip)"
      get_input
    end

    # Normalize the hash of bike_params, so if user hits enter to skip color choice,
    # that parameter will be ignored by the QueryRunner
    def normalize_bike_params(category, color)
      {category: category, color: color}.reject { |k, v| v.nil? || v.empty? }
    end

    # Specify STDOUT as the explicit receiver for puts
    # STDOUT/STDIN must be specified when doing IO within a rake task
    def puts(output)
      STDOUT.puts output
    end

    # Print prompt, then get and return input
    # Quit program if input == "exit"
    def get_input
      print prompt
      user_input = STDIN.gets.chomp
      if user_input == "exit"
        exit
      else
        user_input
      end
    end

    def prompt
      " > "
    end

    def exit
      puts "Goodbye!"
      Kernel.exit(false) # Don't throw Exception
    end

end