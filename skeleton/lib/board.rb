class Board
  attr_accessor :cups
  SYMBOLS = :stone

  def initialize(name1, name2)
    @cups = Array.new(14)
    place_stones
  end

  def place_stones
    cups.each_index do |i|
      if (i == 6 || i == 13 )
        cups[i] = []
      else
        cups[i] = [:stone, :stone, :stone, :stone]
      end
    end
  end

  def valid_move?(start_pos)
    unless (start_pos < 5 && start_pos >= 0) || (start_pos < 12 && start_pos >= 7)
      raise "Invalid starting cup"
    end

    if cups[start_pos].empty?
      raise "Starting cup is empty"
    end
  end

  def make_move(start_pos, current_player_name)
    # start_pos -= 1 if start_pos < 7
    i = 0
    until cups[start_pos].empty?
      i += 1
      next if start_pos < 6 && (start_pos + i) % 14 == 13
      next if start_pos > 6 && (start_pos + i) % 14 == 6
      cups[(start_pos + i) % 14] << cups[start_pos].shift
    end
    render
    next_turn(start_pos + i)
  end

  def next_turn(ending_cup_idx)
    return :switch if cups[ending_cup_idx].length == 1
    return :prompt if cups[ending_cup_idx].length == 1
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
