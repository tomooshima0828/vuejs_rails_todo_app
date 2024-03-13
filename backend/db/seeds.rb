if Todo.count.zero?
  10.times do |i|
    Todo.create!(title: "Todo-#{i + 1}", completed: false)
  end
end
