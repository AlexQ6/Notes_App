require_relative "help.rb"
require "tty-prompt"
require "tty-file"
require "tty-table"
require "csv"


# Display a start menu to user
class StartMenu 
    def initialize
        @start_prompt = TTY::Prompt.new
        @start_prompt.select("Create new noteboard or load existing one?") do |menu|
            menu.choice "New noteboard", -> {Noteboard.new(new_board_name)}
            menu.choice "Load existing noteboard", -> {noteboard_menu}
            menu.choice "Help", -> {help_info}
            menu.choice "Exit", -> {system "exit"}
        end
    end  
    
end

#Finds any existing noteboard files and displays a selection menu
def noteboard_menu
    @file_arr = Dir.glob("*csv")
    @file_menu = TTY::Prompt.new
    @file_menu.select("Select an existing noteboard") do |menu|
        for file in @file_arr do
        menu.choice "#{file}", -> {Noteboard.display_noteboard(file)}
        end
        menu.choice "Delete a noteboard", -> {delete_noteboard}
        menu.choice "Back", -> {StartMenu.new}
    end
end

class Noteboard
    #Creates a file for new noteboard
    def initialize(file_name)
        
        @file = TTY::File.create_file "#{file_name}.csv"
    end
    
    
    
    # Adds note into current notebaord
    def noteboard_add(note)
        assign_number = 1
        file = CSV.open(@file, "a+") do |csv|
            csv << [note]
        end
        

    end

    # Deletes a line of notes from current noteboard
    def noteboard_delete(line_number)
        

    end

    def noteboard_edit

    end

    # Displays all notes to user
    def self.display_noteboard(file)
        puts "Your notes are:"
        puts file_data = File.read(file)

        # display = TTY::Table[['a1', 'a2'], ['b1', 'b2']]

    end

   
end


# User interaction functions

# Asks user for new noteboard name
def new_board_name
    puts "Enter a name for this new noteboard."
    file_name = $stdin.gets.chomp
    
end

# Asks and deletes a noteboard file that user requests
def delete_noteboard
    puts "Enter just the name of noteboard to be deleted:"
    delete_file = gets.chomp
    TTY::File.remove_file "#{delete_file}.csv"
end


# Asks user for note to be added
def add_note
    puts "Enter your note: "
    note = $stdin.gets.chomp

end

def delete_note
    puts "Which Line do you want to delete (Enter Line number):"
    # error handling here, numbers only
    line_number = gets.chomp.to_i

end


def edit_note

end

# Options menu that methods should loop back into
def options_menu(noteboard)
    @start_prompt = TTY::Prompt.new
        @start_prompt.select("What do you want to do now?") do |menu|
            menu.choice "Load existing noteboards", -> {noteboard_menu}
            menu.choice "Add new note", -> {Noteboard.noteboard_add(add_note)}
            menu.choice "Delete note", -> {Noteboard.noteboard_delete(delete_note)}
            menu.choice "Back", -> {StartMenu.new}
        end
end

# control flow

# noteboard.noteboard_add(add_note)
# Noteboard.display_noteboard(noteboard)
# options_menu(noteboard)


