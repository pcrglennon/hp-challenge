class Cli

  def run
    puts "Welcome, choose a command from the list below and follow the instructions"
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
      puts "Selecting bikes by color: #{color}"
    else
      puts "Invalid command: #{command}"
    end
  end

  def command_choices
    "1) Select bikes by color"
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