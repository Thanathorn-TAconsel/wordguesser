class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = '' 
    @wrong_guesses = ''
    @ary = Array.new
    @timeguess = 0
  end

  def word_with_guesses()
    output = ""
    @word.split('').each { |c|
      if @ary.include? c
        output += c
      else
        output += '-'
      end
    }
    return output
  end

  def check_win_or_lose()
    if @timeguess >= 7
      return :lose
    end
    @word.split('').each { |c|
      if @ary.include? c
        
      else
        return :play
      end
    }
    return :win
  end

  def guess(uin)
    if uin == nil
      raise ArgumentError, 'Argument Error'
    end
    if uin.length == 0
      raise ArgumentError, 'Argument Error'
    end
    uin = uin.downcase
    if uin.match(/[^a-zA-Z]/)
      raise ArgumentError, 'Argument Error'
    end
    if @ary.include? uin
      return false
    end
    if @word.include? uin
      @guesses = uin
    else
      @wrong_guesses = uin
    end
    @ary.append(uin)
    @timeguess += 1
  end

  def word
    @word
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
