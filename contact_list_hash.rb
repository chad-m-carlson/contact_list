@contact_list = [
  {first_name: "Heather", last_name: "Balch", phone: "(555)263-7572" },
  {first_name: "Chad", last_name: "Carlson", phone: "(555)701-0142" },
  {first_name: "Harper", last_name: "Carlson", phone: "" },
  {first_name: "Rudy", last_name: "Carlson", phone: "" },
  {first_name: "Kiwi", last_name: "Balch", phone: "1234567890" },
]

def menu
  puts "Please select an option"
  puts "1) Create a contact"
  puts "2) View all contacts"
  puts "3) Delete a contact"
  puts "4) Edit a contact"
  puts "5) Search by name"
  puts "6) Exit"
  prompt
  selection = gets.strip.to_i
  user_selection(selection)
end

def user_selection(selection)
  case selection
    when 1
      seperator
      create_contact
    when 2
      seperator
      view_contacts
    when 3
      seperator
      delete_contact
    when 4
      seperator
      edit_contact
    when 5
      seperator
      search
    when 6
      puts "X" * 50
      exit
    else
      puts "Please make a valid selection"
      seperator
    end
    menu
  end
  
  def create_contact
    puts "What is the first and last name of the new contact?"
    prompt
    name = gets.strip.split(' ')
    puts "What is their phone number?"
    phone = create_phone
    @contact_list << { first_name: name[0], last_name: name[1], phone: phone}
    seperator
  end
  
  def create_phone
    prompt
    phone = gets.strip
    if proper_phone?(phone) == false
      puts "Please enter phone number in correct format. '(XXX)XXX-XXXX'"
      create_phone
    else
       return phone
    end
  end

  def proper_phone?(phone)
    ph_arr = phone.split('')
    if (ph_arr[0] != "(") && (ph_arr[4] != ")") && (ph_arr[8] != "-")
      return false
    end
    
  end
  
  def view_contacts
    seperator
    line_width = 50
    puts "CONTACT LIST".center(line_width)
    puts
    @contact_list.each.with_index do |c, i|
      if c[:phone].length == 13
        puts "#{i + 1}) #{c[:first_name]} #{c[:last_name]}".ljust(line_width/2) + "Phone Number: #{c[:phone]}".rjust(line_width/2)
      else
        puts "#{i + 1}) #{c[:first_name]} #{c[:last_name]}".ljust(line_width/2) + "Phone Number:   unlisted   "
      end
    end
    seperator
  end
  
  def delete_contact
    puts "Which contact would you like to delete?"
    view_contacts
    prompt
    selection = gets.strip.to_i - 1
    puts "#{@contact_list[selection][:first_name]} has been deleted"
    @contact_list.delete_at(selection)
    seperator
  end
  
  def edit_contact
  puts "Which contact would you like to edit?"
  view_contacts
  prompt
  @contact_to_edit = gets.strip.to_i - 1
  puts "What would you like to change?"
  puts "1) First name"
  puts "2) Last name"
  puts "3) Phone number"
  prompt
  change_requested = gets.strip.to_i
  case change_requested
  when 1
    puts "Please enter the new first name"
    prompt
    new_first_name = gets.strip.to_s
    @contact_list[@contact_to_edit][:first_name] = new_first_name
  when 2
    puts "Please enter the new last name"
    prompt
    new_last_name = gets.strip.to_s
    @contact_list[@contact_to_edit][:last_name] = new_last_name
  when 3
    puts "Please enter the new phone number"
    prompt
    new_phone = gets.strip
    @contact_list[@contact_to_edit][:phone] = new_phone
  else
    puts "This is not a valid selection"
    edit_contact
  end
  puts "Do you need to edit anything else?"
  print "Y/N? >"
  y_n = gets.strip
  if y_n == "Y" ? edit_contact : menu
  end
  seperator
end

def search
  puts "Enter a first or last name of the individual you are searching for"
  prompt
  name = gets.strip.to_s
  filtered_list =  @contact_list.select { |contact| (contact[:first_name].include?(name)) || (contact[:last_name].include?(name)) }
  line_width = 50
  filtered_list.each.with_index do |c, i|
    puts "#{i + 1}) #{c[:first_name]} #{c[:last_name]}".ljust(line_width/2) + "Phone Number: #{c[:phone]}".rjust(line_width/2)
  end
  seperator
end


def seperator
  puts "*" * 30
end

def prompt
  print "> "
end

menu