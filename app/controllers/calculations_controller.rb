class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]



    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    text_split_into_array = @text.gsub(/[^a-z0-9\s]/i,"").downcase.split
    @occurences = 0

    text_split_into_array.each do |word|
      if word ==@special_word.downcase
        @occurences += 1
      end
    end 


    @word_count = text_split_into_array.length




    @character_count_with_spaces = @text.chars.length

    @character_count_without_spaces = @text.gsub(" ","").gsub("\r","").gsub("\n","").length

    @occurrences = @text.split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================


    monthly_rate= @apr/1200




    @monthly_payment = (monthly_rate*@principal)/(1-((1+monthly_rate)**-(@years*12)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = (@ending-@starting)/(60)

    time_between_in_minutes=(@ending-@starting)/(60)



    @hours = time_between_in_minutes/60


    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================


    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum





    @Length = @sorted_numbers.length
    @A = (@Length)/(2)
    @B = @sorted_numbers[@A]
    @C = @sorted_numbers[(@A-1)]
    @D = (@B+@C)/2

    if @Length % 2 ==0
      @median= @D

    else
      @median= @sorted_numbers[@Length/2]




    end



    @sum = @numbers.sum

    @mean = @sum/@count

    @Squared_Numbers=[]
    @numbers.each do |num|
      var_each=(num-@mean)**2
      @Squared_Numbers.push(var_each)
    end

    @Sum_of_Squares=@Squared_Numbers.sum
    @variance = @Sum_of_Squares/@count

    @standard_deviation = Math.sqrt(@variance)

    hash = Hash.new(0)
    @numbers.each do |i|
      hash[i]+=1
    end


    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] +=1; h}
    mode = @numbers.max_by { |v| freq[v] }

    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
