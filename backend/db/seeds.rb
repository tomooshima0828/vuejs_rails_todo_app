10.times do |i|
  Todo.create!(title: "Todo-#{i + 1}", completed: false)
end

10.times do |i|
  Todo.create!(title: "Todo-#{i + 1}", completed: true)
end
