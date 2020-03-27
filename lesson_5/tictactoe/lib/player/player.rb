require_relative '../modules/terminaldisplay.rb'
require_relative '../utility.rb'

class Player
  include TerminalDisplay
  
  attr_accessor :name, :marker, :score
  
  @@total = 0
  @@chosen_markers = []
  @@chosen_names = []
  
  def initialize
    @@total += 1
    @name = choose_name
    @marker = choose_marker
    @score = 0
    @@chosen_markers << marker
    @@chosen_names << name
  end
  
  def self.total
    @@total
  end
  
  private
  
  def choose_name
    message = "Please choose a name for player #{@@total}.\n\n-> "
    validation = name_validation
    errors = name_errors
    prompt(message, validation, errors)
  end
  
  # Allowing numbers in player names is a design choice
  def name_validation
    Proc.new do |answer|
      answer =~ /^[0-9a-zA-Z]{2,20}$/ && @@chosen_names.exclude?(answer)
    end
  end
  
  def name_errors
    Proc.new do |answer|
      case
      when answer.empty? then 'no_response_given'
      when @@chosen_names.include?(answer) then 'name_taken'
      when answer.chars.include?(' ') then 'name_has_whitespace'
      when answer.size < 2 then 'name_too_short'
      when answer.size > 20 then 'name_too_long'
      else 'unknown_error'
      end
    end
  end
  
  def choose_marker
    message = "Please choose a marker for #{name}.\n\n-> "
    validation = marker_validation
    errors = marker_errors
    prompt(message, validation, errors)
  end
  
  def marker_validation
    Proc.new do |answer|
      valid_markers.include?(answer) && @@chosen_markers.exclude?(answer)
    end
  end
  
  def valid_markers
    markers = ['@', '#', '$', '%', '&']
    ('A'..'Z').each { |character| markers << character }
    markers
  end
  
  def marker_errors
    Proc.new do |answer|
      case
      when answer.empty? then 'no_response_given'
      when @@chosen_markers.include?(answer) then 'marker_taken'
      when ('a'..'z').include?(answer) then 'marker_lowercase'
      when answer.size > 1 then 'marker_too_many_chars'
      else 'invalid_marker'
      end
    end
  end
end