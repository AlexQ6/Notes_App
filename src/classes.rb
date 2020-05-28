require "tty-prompt"
require "tty-file"
require "tty-table"
require "csv"

# Display a start menu to user
# class StartMenu 
#     def initialize
#         @start_prompt = TTY::Prompt.new
#         @start_prompt.select("Create new noteboard or load existing one?") do |menu|
#             menu.choice "New noteboard", -> {new_noteboard}
#             menu.choice "Load existing noteboard", -> {noteboard_menu}
#             menu.choice "Exit", -> {system "clear"}
#         end
#     end  
    
# end




class Noteboard
    #Creates a file for new noteboard
    def initialize(file_name)
        
        @file = TTY::File.create_file "#{file_name}.csv"
    end
    
    
    
    # Reads and displays CSV fil data into a table
    def noteboard_add(note)
        file = CSV.open(@file, "a+") do |csv|
            csv << [note]
            
            
        end

    end

    def noteboard_delete

    end

    def display_noteboard(file)
        puts "Your notes are"
        puts file_data = File.read(file)

        # display = TTY::Table[['a1', 'a2'], ['b1', 'b2']]

    end

   
end


#functions

#Finds any existing noteboard files and displays a selection menu
def noteboard_menu
    @file_arr = Dir.glob("*csv")
    @file_menu = TTY::Prompt.new
    @file_menu.select("Select an existing noteboard") do |menu|
        for file in @file_arr do
        menu.choice "#{file}", -> {Noteboard.display_noteboard(file)}
        end
        menu.choice "Back", -> {StartMenu.new}
    end
end


def new_noteboard
    puts "Enter a name for this new noteboard."
    file_name = gets.chomp
    

end

def add_note
    puts "Enter your note: "
    note = gets.chomp

end

def delete_note

end

def options_menu
    @start_prompt = TTY::Prompt.new
        @start_prompt.select("What do you want to do now") do |menu|
            menu.choice "Show my notes", -> {Noteboard.display_noteboard}
            menu.choice "Add new note", -> {Noteboard.noteboard_add(add_note)}
            menu.choice "Delete note", -> {Noteboard.noteboard_delete(delete_note)}
            menu.choice "Exit", -> {Startmenu.new}
        end
end


#Control flow

noteboard = Noteboard.new(new_file)

noteboard.noteboard_add(add_note)

noteboard.display_noteboard

options_menu









#     def delete_note

#     end

# def alphabetical_sort

# end
