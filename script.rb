class SecretCode
    attr_reader :secret_code
    attr_reader :one
    attr_reader :two
    attr_reader :three
    attr_reader :four
    attr_reader :five
    attr_reader :six

    def initialize(slot1, slot2, slot3, slot4)
        @slot1 = slot1
        @slot2 = slot2
        @slot3 = slot3
        @slot4 = slot4
        @secret_code = [@slot1, @slot2, @slot3, @slot4]
        @one = 0
        @two = 0
        @three = 0
        @four = 0
        @five = 0
        @six = 0
    end

    def visual
        "| #{@slot1} #{@slot2} #{@slot3} #{@slot4} |"
    end

    def color_count
        @one = 0
        @two = 0
        @three = 0
        @four = 0
        @five = 0
        @six = 0
        for i in 0..3 do
            @secret_code[i] == 1 ? @one += 1 :
            @secret_code[i] == 2 ? @two += 1 :
            @secret_code[i] == 3 ? @three += 1 :
            @secret_code[i] == 4 ? @four += 1 :
            @secret_code[i] == 5 ? @five += 1 :
            @six += 1
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
        "| #{@slot1} #{@slot2} #{@slot3} #{@slot4} |"
    end

    def check_code(code)
        correct = 0
        partial = 0
        one = 0
        two = 0
        three = 0
        four = 0
        five = 0
        six = 0
        for i in 0..3 do
            if @current_guess[i] == code.secret_code[i]
                correct += 1
            end
        end
        reduced_secret_code = SecretCode.new(0, 0, 0, 0)
        for i in 0..3 do
            if @current_guess[i] != code.secret_code[i]
                reduced_secret_code.secret_code[i] = code.secret_code[i]
            end
        end
        for i in 0..3 do
            next if @current_guess[i] == code.secret_code[i]
            @current_guess[i] == 1 ? one += 1 :
            @current_guess[i] == 2 ? two += 1 :
            @current_guess[i] == 3 ? three += 1 :
            @current_guess[i] == 4 ? four += 1 :
            @current_guess[i] == 5 ? five += 1 :
            six += 1
        end

        reduced_secret_code.color_count
        reduced_secret_code.one >= one ? partial += one : partial += reduced_secret_code.one
        reduced_secret_code.two >= two ? partial += two : partial += reduced_secret_code.two
        reduced_secret_code.three >= three ? partial += three : partial += reduced_secret_code.three
        reduced_secret_code.four >= four ? partial += four : partial += reduced_secret_code.four
        reduced_secret_code.five >= five ? partial += five : partial += reduced_secret_code.five
        reduced_secret_code.six >= six ? partial += six : partial += reduced_secret_code.six
        
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

class CodeBreaker
    @@all_guesses = ""

    def guess_code
        choosing = true
        if @@all_guesses != ""
            puts "Here are your previous guesses:"
            puts @@all_guesses
        end
        while choosing
            print "Slot1: "
            slot1 = gets.chomp.to_i 
            if ![1, 2, 3, 4, 5, 6].include?(slot1)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot2: "
            slot2 = gets.chomp.to_i 
            if ![1, 2, 3, 4, 5, 6].include?(slot2)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot3: "
            slot3 = gets.chomp.to_i 
            if ![1, 2, 3, 4, 5, 6].include?(slot3)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot4: "
            slot4 = gets.chomp.to_i 
            if ![1, 2, 3, 4, 5, 6].include?(slot4)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        puts "Your guess is: | #{slot1} #{slot2} #{slot3} #{slot4} |"
        @@all_guesses += "| #{slot1} #{slot2} #{slot3} #{slot4} |\n"
        GuessCode.new(slot1, slot2, slot3, slot4)
    end
end

def choose_guesser
    choosing = true
    while choosing
        print "Do you want to be the guesser? Type Y for yes or N for no: "
        human_guesser = gets.strip.upcase
        if human_guesser == "Y"
            choosing = false
            return true
        elsif human_guesser == "N"
            return false
        else
            puts "Invalid input. Please type Y or N."
            choosing = true
        end
    end
end

def create_gameboard(human_guesser)
    choices = [1, 2, 3, 4, 5, 6]
    if human_guesser == true
        SecretCode.new(choices.sample, choices.sample, choices.sample, choices.sample)
    else
        puts "Create your secret code now. Please type a number 1-6 for each slot."
        choosing = true
        while choosing
            print "Slot1: "
            slot1 = gets.chomp.to_i
            if !choices.include?(slot1)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot2: "
            slot2 = gets.chomp.to_i
            if !choices.include?(slot2)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot3: "
            slot3 = gets.chomp.to_i
            if !choices.include?(slot3)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        choosing = true
        while choosing
            print "Slot4: "
            slot4 = gets.chomp.to_i
            if !choices.include?(slot4)
                puts "Not a valid input. Please type a number 1-6."
                choosing = true
            else
                choosing = false
            end
        end
        puts "Your secret code is: | #{slot1} #{slot2} #{slot3} #{slot4} |"
        SecretCode.new(slot1, slot2, slot3, slot4)
    end
end

def play_mastermind
    guesses = 0
    playing = true
    human_guesser = choose_guesser
    new_secret_code = create_gameboard(human_guesser)
    if human_guesser == true
        puts "| Slot1 | Slot2 | Slot3 | Slot4 |"
        puts "Guess a number 1-6 for all slots."
        while guesses < 12 && playing
            guesser = CodeBreaker.new
            current_guess = guesser.guess_code
            playing = current_guess.give_feedback(new_secret_code)
            puts "You have #{11-guesses} guesses left."
            puts "------------------------------------------------"
            guesses += 1
        end
        if guesses == 12
            puts "Out of guesses! The correct code was #{new_secret_code.visual}"
        end
    else
        puts "bye"
    end
end

play_mastermind