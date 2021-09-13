<template>
  <main>
    <h1>TODOs</h1>
    <div>
      <form @submit.prevent="addTodo(inputTodo)">
        <input v-model="inputTodo" placeholder="Add a TODO..." />
        <input type="submit" value="Submit" />
      </form>
    </div>
    <div>
      <ul id="array-rendering">
        <li v-for="(todo, index) in todos" :key="index">
          <input type="checkbox" value="todo.isChecked" />
          <label for="jack">{{ todo.text }}</label>
          <button @click="removeTodo(index)">X</button>
        </li>
      </ul>
    </div>
  </main>
</template>

<script>
import { ref} from "vue";

export default {
  name: "Todos",
  setup() {

    const todos = ref([]);
    const inputTodo = ref("");

    if (sessionStorage.getItem("todos")) {
      todos.value = JSON.parse(sessionStorage.getItem("todos"))._value;
    }

    const addTodo = (event) => {
      todos.value.push({ text: event, isChecked: false });
      sessionStorage.setItem("todos", JSON.stringify(todos));
      console.log(JSON.parse(sessionStorage.getItem("todos"))._value);
      inputTodo.value = "";
    };

    const removeTodo = (event) => {
      todos.value.splice(event, event);
    };

    return {
      todos,
      removeTodo,
      addTodo,
      inputTodo,
    };
  },
};
</script>

<style></style>
