<template>
  <div id="app">
    <h1>Todoリスト</h1>
    <div>
      <input v-model="newTodoTitle" placeholder="新しいTodoを追加">
      <button @click="addTodo">登録</button>
    </div>
    <ul>
      <li v-for="todo in todos" :key="todo.id">
        {{ todo.title }} - {{ todo.completed ? '完了' : '未完了' }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'App',
  data() {
    return {
      todos: []
    }
  },
  mounted() {
    this.fetchTodos();
  },
  methods: {
    async fetchTodos() {
      try {
        const response = await axios.get('http://localhost:3000/todos');
        this.todos = response.data;
      } catch (error) {
        console.error('Todoリストの取得に失敗しました:', error);
      }
      
    },
    async addTodo() {
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
    }
  }
};
</script>

<style>
/* スタイルはここに追加 */
</style>
