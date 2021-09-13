<template>
  <main class="main-container">
    <h1>TODOs</h1>
    <div id="todos-wrap">
      <form @submit.prevent="addTodo(inputTodo)" class="todos-wrap__item">
        <input v-model="inputTodo" type="text" placeholder="Add a TODO..." />
        <input type="submit" value="Submit" />
      </form>

      <div>
        <ul id="todos-list">
          <li
            v-for="(todo, index) in todos"
            :key="index"
            class="todos-wrap__item"
            
          >
            <input type="checkbox" v-model="todo.isChecked" />
            <label :for="'todo' + index" :class="{ checked: todo.isChecked }">{{ todo.text }} </label>
            <button class="todos-wrap__item__remove" @click="removeTodo(index)">
              X
            </button>
          </li>
        </ul>
      </div>
    </div>
  </main>
</template>

<script>
import { ref } from "vue";

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
      inputTodo.value = "";
    };

    const removeTodo = (event) => {
      todos.value.splice(event, 1);
      sessionStorage.setItem("todos", JSON.stringify(todos));
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

<style>
.checked {
  text-decoration: line-through;
}
.main-container {
  margin: auto;
  display: flex;
  width: 50vw;
  flex-direction: column;
  align-items: center;
}

#todos-wrap {
  border: 1px solid black;
  width: 50vw;
  height: 50vh;
  font-size: 20px;
  overflow: auto;
  -ms-overflow-style: none;
  scrollbar-width: none;
}
.main-container h1 {
    align-self: flex-start;
  }
#todos-list {
  margin: 0;
}
.todos-wrap__item {
  border-bottom: 1px solid black;
  padding: 5px;
}
#todos-list .todos-wrap__item {
  overflow-wrap: break-word;
  display: grid;
  grid-template-columns: 30px 80% 10%;
}
#todos-list .todos-wrap__item label {
  margin-left: 10px;
}
.todos-wrap__item input[type="submit"],
#todos-wrap::-webkit-scrollbar {
  display: none;
}
input[type="text"] {
  border: none;
  width: 99%;
  font-size: 20px;
}
.todos-wrap__item__remove {
  border: none;
  background: transparent;
  cursor: pointer;
  justify-self: end;
}

@media only screen and (max-width: 600px) {
  #todos-wrap, .main-container h1 {
    width: 95vw;
  }
  .main-container h1 {
    align-self: auto;
  }
  #todos-list .todos-wrap__item {
  grid-template-columns: 30px 65% 25%;
}
}
</style>
