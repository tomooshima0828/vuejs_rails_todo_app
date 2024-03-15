## 登録されているcronジョブのリストを表示
# crontab -l
## cronジョブの更新コマンド
# bundle exec whenever --update-crontab

every 1.day, at: '3:00 am' do
  rake "todo:cleanup"
end

every 1.day, at: '5:00 pm' do
  rake "todo:log_completed"
end

every 1.day, at: '2:00 am' do
  rake "todo:backup"
end

every :monday, at: '3:00 am' do
  rake "todo:export_csv"
end
