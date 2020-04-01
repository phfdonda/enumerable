# frozen_string_literal: true

# This is a modified version of the Enumerable module.
module Enumerable
 
  def my_each
    if block_given?
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
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    i = 0
    if block_given?
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
    else
      to_enum(:my_each_with_index)
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
    else
      my_each { |i| return false if i.nil? || i == false }
    end
    true
  end

  def my_any?(arg = nil)
    if arg.nil? && block_given?
      my_each { |i| return true if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| return true if i.match(arg) }
    elsif arg.is_a? Module
      my_each { |i| return true if i.is_a?(arg) }
    else
      my_each { |i| return true if i.nil? || i == false }
    end
    false
 end

  def my_none?(arg = nil)
    if arg.nil? && block_given?
      my_each { |i| return false if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| return false if i.match(arg) }
    elsif arg.is_a? Module
      my_each { |i| return false if i.is_a?(arg) }
    else
      my_each { |i| return false unless i.nil? || i == false }
    end
    true
  end
  
  def my_count(arg = nil)
    counter = 0
    if block_given?
      my_each { |i| counter += 1 if yield i }
    else
      counter = length
    end
    counter
  end

  def my_map; end

  def my_inject; end
end
# a = [3, -8, 5, -9, 6, -2, 5, 8, -6, 0]
# b = (0..40)

# hash = Hash.new
# %w(cat dog wombat).my_each_with_index { |item, index| hash[item] = index}
# p hash     #=> {"cat"=>0, "dog"=>1, "wombat"=>2}

# a.my_each { |x| puts x * 2 }
# b.my_each
# a.my_each_with_index { |n, i| puts "#{n}: #{i}" }
# b.my_each_with_index
# # # print(a.my_select { |x| x.to_i.positive? })

# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?                                           #=> true

# p '******'

# p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# p %w[ant bear cat].my_any?(/d/)                        #=> false
# p [nil, true, 99].my_any?(Integer)                     #=> true
# p [nil, true, 99].my_any?                              #=> true
# p [].my_any?                                           #=> false

# p '******'

# p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
# p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_none?(/d/)                        #=> true
# p [1, 3.14, 42].my_none?(Float)                         #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false

# p '******'

p ary = [1, 2, 4, 2]
p ary.my_count               #=> 4
p ary.my_count(2)            #=> 2
p ary.my_count{ |x| x%2==0 } #=> 3