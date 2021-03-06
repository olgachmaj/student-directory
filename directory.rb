
@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def load_students
  puts "Enter the file you want to load"
  filename = STDIN.gets.chomp
  file_check(filename)
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  puts "Load sucessful"
  puts "Now we have #{@students.count} students"
  file.close
end

def file_check(filename)
  if File.exists?(filename) #if it exists
    load_students(filename)
      puts "File ok"
  else #if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    interactive_menu
  end
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of method if it isn't given
  file_check(filename)
end

def save_students
  puts "Enter file you want to save students to"
  # open the file for writing
  file_name = STDIN.gets.chomp
  file_check(file_name)
  file = File.open(file_name, "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  puts "Save sucessful"
  file.close
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end
try_load_students
interactive_menu
