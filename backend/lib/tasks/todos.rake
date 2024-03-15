namespace :todo do
  desc "未完了のTODOを削除"
  task cleanup: :environment do
    Todo.where(completed: false).destroy_all
    puts "未完了のTODOを削除しました"
  end

  desc "完了したtodosをログに記録"
  task log_completed: :environment do
    completed_todos = Todo.where(completed: true)
    File.open("log/completed_todos.log", "a") do |f|
      completed_todos.each { |todo| f.puts "完了: #{todo.title}" }
    end
    puts "完了したtodosがログに記録されました。"
  end

  desc "todosのバックアップ"
  task backup: :environment do
    backup_file = "backup/todos_#{Time.now.strftime('%Y%m%d%H%M%S')}.json"
    todos = Todo.all.to_json
    File.write(backup_file, todos)
    puts "Todosがバックアップされました。"
  end

  desc "CSVへのtodosのエクスポート"
  task export_csv: :environment do
    require 'csv'
    todos = Todo.all
    CSV.open("exports/todos_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv", "wb") do |csv|
      csv << ["ID", "Title", "Completed"]
      todos.each do |todo|
        csv << [todo.id, todo.title, todo.completed]
      end
    end
    puts "TodosがCSVにエクスポートされました。"
  end

  desc "exportsフォルダ内のCSVファイルをすべて削除"
  task :clear_exports do
    Dir.glob('exports/*.csv').each do |file|
      File.delete(file)
    end
    puts "exportsフォルダ内のCSVファイルをすべて削除しました。"
  end
end
