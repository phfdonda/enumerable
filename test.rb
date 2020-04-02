# frozen_string_literal: true

def my_none?(args = nil)
  block_is_true = true
  if block_given?
    my_each { |x| block_is_true = false if yield(x) }
  elsif args.is_a? Regexp
    my_each { |x| block_is_true = false if x.match(args) }
  elsif args.is_a? Module
    my_each { |x| block_is_true = false if x.is_a?(args) }
  elsif args.nil?
    my_each { |x| block_is_true = false if x.nil? || x == false }
  else
    my_each { |x| block_is_true = false if x == false }
  end
  block_is_true
end
