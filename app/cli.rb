require_relative './query_runner'

class Cli
  attr_reader :query_runner

  def initialize
    @query_runner = QueryRunner.new
  end

  attr_reader :query_runner

  def initialize
    @query_runner = new QueryRunner
  end

  def run
    puts "Welcome, enter 'exit' at any time to exit the program"
    puts command_choices
    loop do
      command = get_input
      break if command == "exit"
      evaluate_command(command)
      puts command_choices
    end
    puts "Goodbye!"
  end

  def evaluate_command(command)
    case command.to_i
    when 1
      puts "Input a color"
      color = get_input
      query_runner.users_with_bikes(color: color)
    else
      puts "Invalid command: #{command}"
    end
  end

  def command_choices
    "Select a command from the list:\n" +
    "1) Select users with bikes of a color"
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