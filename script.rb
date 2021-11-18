class SecretCode
    attr_reader :secret_code
    attr_reader :black_count
    attr_reader :white_count

    def initialize(slot1, slot2, slot3, slot4)
        @slot1 = slot1
        @slot2 = slot2
        @slot3 = slot3
        @slot4 = slot4
        @secret_code = [@slot1, @slot2, @slot3, @slot4]
        @black_count = 0
        @white_count = 0
    end

    def visual
        "| #{@slot1} | #{@slot2} | #{@slot3} | #{@slot4} |"
    end

    def color_count
        @black_count = 0
        @white_count = 0
        for i in 0..3 do
            if @secret_code[i] == "Black"
                @black_count += 1
            elsif @secret_code[i] == "White"
                @white_count += 1
            end
        end
    end
end

class GuessCode
    def initialize(slot1, slot2, slot3, slot4)
        @slot1 = slot1
        @slot2 = slot2
        @slot3 = slot3
        @slot4 = slot4
        @current_guess = [@slot1, @slot2, @slot3, @slot4]
    end

    def visual
        "| #{@slot1} | #{@slot2} | #{@slot3} | #{@slot4} |"
    end

    def check_code(code)
        correct = 0
        partial = 0
        black = 0
        white = 0
        code.color_count
        for i in 0..3 do
            if @current_guess[i] == code.secret_code[i]
                correct += 1
            end
        end
        reduced_secret_code = SecretCode.new("", "", "", "")
        for i in 0..3 do
            if @current_guess[i] != code.secret_code[i]
                reduced_secret_code.secret_code[i] = code.secret_code[i]
            end
        end
        for i in 0..3 do
            next if @current_guess[i] == code.secret_code[i]
            
            if @current_guess[i] == "Black"
                black += 1
            elsif @current_guess[i] == "White"
                white += 1
            end
        end
        reduced_secret_code.color_count
        if reduced_secret_code.black_count >= black
            partial += black
        else
            partial += reduced_secret_code.black_count
        end
        if reduced_secret_code.white_count >= white
            partial += white
        else
            partial += reduced_secret_code.white_count
        end
        [correct, partial]
    end

    def give_feedback(secret_code)
        current_counts = check_code(secret_code)
        correct = current_counts[0]
        partial = current_counts[1]
        if correct == 4
            puts "You guessed it! Nice job"
            return false
        else
            puts "You guessed #{correct} correct and #{partial} partially correct."
            return true
        end
    end
end

class CodeGuesser
    @@all_guesses = ""

    def guess_code
        choosing = true
        if @@all_guesses != ""
            puts "Here are your previous guesses:"
            puts @@all_guesses
        end
        while choosing
            print "Slot1: "
            slot1 = gets.strip.capitalize 
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
            slot2 = gets.strip.capitalize 
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
            slot3 = gets.strip.capitalize 
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
            slot4 = gets.strip.capitalize 
            if !["Black", "White"].include?(slot4)
                puts "Not a valid input. Please type either black or white."
                choosing = true
            else
                choosing = false
            end
        end
        puts "Your guess is: | #{slot1} | #{slot2} | #{slot3} | #{slot4} |"
        @@all_guesses += "| #{slot1} | #{slot2} | #{slot3} | #{slot4} |\n"
        GuessCode.new(slot1, slot2, slot3, slot4)
    end
end

def create_gameboard
    choices = ["Black", "White"]
    SecretCode.new(choices.sample, choices.sample, choices.sample, choices.sample)
end

def play_mastermind
    guesses = 0
    playing = true
    new_secret_code = create_gameboard
    puts "| Slot1 | Slot2 | Slot3 | Slot4 |"
    puts "Guess black or white for all slots."
    while guesses < 12 && playing
        guesser = CodeGuesser.new
        current_guess = guesser.guess_code
        playing = current_guess.give_feedback(new_secret_code)
        puts "You have #{11-guesses} guesses left."
        puts "------------------------------------------------"
        guesses += 1
    end
    if guesses == 12
        puts "Out of guesses! The correct code was #{new_secret_code.visual}"
    end
end

play_mastermind