
# This is a modified version of the Enumerable module.
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    if is_a? Array
      min = 0
      max = length
      max.times do
        yield(self[min])
        min += 1
      end
    elsif is_a? Range
      min = self.min
      max = self.max
      until min == max
        p min
        min += 1
      end
    end
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    i = 0
    if is_a? Array
      min = 0
      max = length
      max.times do
        yield(self[min], min)
        min += 1
        i += 1
      end
    elsif is_a? Range
      min = self.min
      max = self.max
      until min == max
        p min
        min += 1
      end
    end
end

  def my_select
    if block_given?
      selection = []
      my_each do |i|
        selection << i if yield(i)
      end
      selection
    else
      to_enum(:my_select)
    end
  end

  def my_all?(arg = nil)
    if arg.nil? && block_given?
      my_each { |i| return false unless yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| return false unless i.match(arg) }
    elsif arg.is_a? Module
      my_each { |i| return false unless i.is_a?(arg) }
    elsif arg.nil?
      my_each { |i| return false if i.nil? || !i }
    else
      my_each { |i| return false unless i == arg }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| return true if i.match(arg) }
    elsif arg.is_a? Module
      my_each { |i| return true if i.is_a?(arg) }
    elsif arg.nil?
      my_each { |i| return true unless i.nil? || i == false }
    else
      my_each { |i| return true if i == arg }
    end
    false
 end

  def my_none?(arg = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| return false if i.match(arg) }
    elsif arg.is_a? Module
      my_each { |i| return false if i.is_a?(arg) }
    elsif arg.nil?
      my_each { |i| return false unless i.nil? || i == false }
    else
      p "test"
      my_each { |i| return false if i == arg }
    end
    true
  end

  def my_count(arg = nil)
    counter = length
    if block_given?
      counter = 0
      my_each { |i| counter += 1 if yield i }
    elsif !arg.nil?
      counter = 0
      my_each { |i| counter += 1 if arg == i }
    end
    counter
  end

  def my_map(&proc)
    return to_enum(:my_map) unless block_given?

    array = is_a?(Array) ? self : to_a
    a = []
    array.my_each { |i| a.push proc.call(i) }
    a
  end

  def my_inject(arg1 = nil, arg2 = nil)
    arr = is_a?(Array) ? self : to_a
    sym = arg1 if arg1.is_a?(Symbol) || arg1.is_a?(String)
    
    if arg1.is_a?(Integer)
      acc = arg1
      sym = arg2 if arg2.is_a?(Symbol) || arg2.is_a?(String)
    end

    if sym
      # We use send() method to dynamically assign the appropriate attribute.
      arr.my_each { |i| acc = acc ? acc.send(sym, i) : i }
    elsif block_given?
      arr.my_each { |i| acc = acc ? yield(acc, i) : i }
    end
    acc
  end

  def multiply_els(arr)
    arr.my_inject { |acc, curr| acc * curr }
  end
end