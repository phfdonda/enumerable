def test
  yield
end

test{|x| puts "Hey"}