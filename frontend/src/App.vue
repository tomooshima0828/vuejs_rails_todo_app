<template>
  <div id="app">
    <h1>Todoリスト</h1>
    <div>
      <input v-model="newTodoTitle" placeholder="新しいTodoを追加" @keyup.enter="addTodo">
      <button @click="addTodo">登録</button>
    </div>
    <ul>
      <li v-for="todo in todos" :key="todo.id">
        {{ todo.title }} - {{ todo.completed ? '完了' : '未完了' }}
        <button @click="deleteTodo(todo.id)">削除</button>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';

interface Todo {
  id: number;
  title: string;
  completed: boolean;
}

export default Vue.extend({


  name: 'App',
  data() {
    return {
      todos: [] as Todo[],
      newTodoTitle: '' // 初期値は空文字
    }
  },
  async mounted() {
    await this.fetchTodos();
  },
  methods: {
    async fetchTodos(): Promise<void> {
      try {
        const response = await axios.get<Todo[]>('http://localhost:3000/todos');
        this.todos = response.data;
      } catch (error) {
        console.error('Todoリストの取得に失敗しました:', error);
      }
      
    },
    async addTodo(): Promise<void> {
      if (!this.newTodoTitle.trim()) {
        return; // タイトルが空の場合は何もしない
      }
      try {
        await axios.post('http://localhost:3000/todos', {
          title: this.newTodoTitle,
          completed: false
        });
      this.newTodoTitle = ''; // 入力フィールドをクリア
      this.fetchTodos(); // Todoリストを再取得
      } catch (error) {
        console.error('Todoの追加に失敗しました:', error);
      }
    },
    async deleteTodo(id: number): Promise<void> {
      if (!confirm('本当に削除しますか？')) {
        return; // キャンセルされた場合は何もしない
      }
      try {
        await axios.delete(`http://localhost:3000/todos/${id}`);
        await this.fetchTodos();
      } catch (error) {
        console.error('Todoの削除に失敗しました:', error);
      }
    }
  },
});
</script>

<style>
/* スタイルはここに追加 */
</style>
