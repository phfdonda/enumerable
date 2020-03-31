# frozen_string_literal: true

# Blabla
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
      to_enum(self)
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
      to_enum(self)
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
      to_enum(self)
    end
  end

  def my_all(param = nil)
    bool = true
    case param
    when param.nil? && block_given?
      my_each { |x| bool = false unless yield(x) }
    when param.is_a?(Regexp)
      my_each { |x| bool = false unless x.match(param)}
    
    end

  
  end

  def my_any; end

  def my_none; end

  def my_count; end

  def my_map; end

  def my_inject; end
end

a = [3, -8, 5, -9, 6, -2, 5, 8, -6, 0]
# b = (0..40)

# hash = Hash.new
# %w(cat dog wombat).my_each_with_index { |item, index| hash[item] = index}
# p hash     #=> {"cat"=>0, "dog"=>1, "wombat"=>2}

# a.my_each { |x| puts x * 2 }
# b.my_each
# a.my_each_with_index { |n, i| puts "#{n}: #{i}" }
# b.my_each_with_index
print(a.my_select { |x| x.to_i.positive? })
