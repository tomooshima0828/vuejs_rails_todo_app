<template>
  <div id="app">
    <h1>Todoリスト</h1>
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
      const response = await axios.get('http://localhost:3000/todos')
      this.todos = response.data;
    }
  }
};
</script>

<style>
/* スタイルはここに追加 */
</style>
