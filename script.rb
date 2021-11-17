class SecretCode
    def initialize(slot1, slot2, slot3, slot4)
        @slot1 = slot1
        @slot2 = slot2
        @slot3 = slot3
        @slot4 = slot4
    end
end

class GuessCode
    def initialize(slot1, slot2, slot3, slot4)
        @slot1 = slot1
        @slot2 = slot2
        @slot3 = slot3
        @slot4 = slot4
        @current_guess = [slot1, slot2, slot3, slot4]
    end

    def visual
        "| #{@slot1} | #{@slot2} | #{@slot3} | #{@slot4} |"
    end
end

class CodeMaker
    @choices = ["Black", "White"]

    def create_gameboard
        SecretCode.new(@choices.sample, @choices.sample, @choices.sample, @choices.sample)
    end
end

class CodeGuesser
    def guess_code
        choosing = true
        while choosing
            puts "| Slot1 | Slot2 | Slot3 | Slot4 |"
            puts "Guess black or white for all slots."
            print "Slot1: "
            slot1 = gets.chomp.capitalize 
            if !["Black", "White"].include?(slot1)
                puts "Not a valid input. Please type either black or white."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot2: "
            slot2 = gets.chomp.capitalize 
            if !["Black", "White"].include?(slot2)
                puts "Not a valid input. Please type either black or white."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot3: "
            slot3 = gets.chomp.capitalize 
            if !["Black", "White"].include?(slot3)
                puts "Not a valid input. Please type either black or white."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot4: "
            slot4 = gets.chomp.capitalize 
            if !["Black", "White"].include?(slot4)
                puts "Not a valid input. Please type either black or white."
                choosing = true
            else
                choosing = false
            end
        end
        puts "Your guess is: | #{slot1} | #{slot2} | #{slot3} | #{slot4} |"
        [slot1, slot2, slot3, slot4]
    end
end

me = CodeGuesser.new()

me.guess_code