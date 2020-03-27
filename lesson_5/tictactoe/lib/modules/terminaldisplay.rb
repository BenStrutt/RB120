require 'yaml'
require_relative '../utility.rb'

module TerminalDisplay
  MESSAGES = YAML.load(File.open('lib/modules/.messages.yml'))
  
  def clear
    system('clear') || system('cls')
  end
  
  def say(messages)
    if messages.is_a?(Array)
      messages.each { |message| print MESSAGES[message] }
    else
      print MESSAGES[messages]
    end
  end
  
  def keypress
    system("stty raw -echo")
    user_input = STDIN.getc
    system("stty -raw echo")
    user_input
  end
  
  def wait
    system("stty raw -echo")
    STDIN.getc
    system("stty -raw echo")
  end
  
  def prompt(message, validation, errors)
    user_input = nil
    
    clear
    loop do
      print message
      user_input = gets.chomp
      break if valid_answer?(user_input, validation)
      
      clear
      say errors.call(user_input)
    end
    
    user_input
  end
  
  private
  
  def valid_answer?(user_input, validation)
    validation.call(user_input)
  end
end