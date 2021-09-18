<template>
  <main class="main-container">
    <h1>TODOs</h1>
    <div id="todos-wrap">
      <form @submit.prevent="addTodo(inputTodo)" class="todos-wrap__item">
        <input
          v-model="inputTodo"
          @focus="errorRemove"
          type="text"
          placeholder="Add a TODO..."
        />
        <input type="submit" value="Submit" />
        <div class="form__error" v-if="emptyTodo">Write something!</div>
      </form>

      <div id="todos-list-wrap">
        <ul id="todos-list">
          <li
            v-for="(todo, index) in todos"
            :key="index"
            class="todos-wrap__item"
          >
            <input type="checkbox" v-model="todo.isChecked" />
            <label :for="'todo' + index" :class="{ checked: todo.isChecked }"
              >{{ todo.text }}
            </label>
            <button class="todos-wrap__item__remove" @click="removeTodo(index)">
              <img src="../assets/close.svg" />
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
    const emptyTodo = ref(false);

    if (sessionStorage.getItem("todos")) {
      todos.value = JSON.parse(sessionStorage.getItem("todos"))._value;
    }

    const errorRemove = () => {
      emptyTodo.value = false;
    };
    const addTodo = (event) => {
      if (!inputTodo.value) {
        emptyTodo.value = true;
        return;
      }
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
      emptyTodo,
      errorRemove,
    };
  },
};
</script>

<style>
.form__error {
  color: #f44932;
  font-size: 12px;
  margin-top: 5px;
}
.checked {
  text-decoration: line-through;
  color: gray;
}
.main-container {
  margin: auto;
  display: flex;
  width: 50vw;
  flex-direction: column;
  align-items: center;
}

#todos-wrap {
  border-radius: 5px;
  width: 50vw;
  height: 50vh;
  font-size: 20px;
  -webkit-box-shadow: 0px 0px 11px 5px rgba(222, 222, 222, 1);
  -moz-box-shadow: 0px 0px 11px 5px rgba(222, 222, 222, 1);
  box-shadow: 0px 0px 11px 5px rgba(222, 222, 222, 1);
}
.main-container h1 {
  align-self: flex-start;
}
#todos-list {
  height:43vh;
  overflow: auto;
  margin: 0;
}
form.todos-wrap__item {
  border-bottom: 2px solid #81c3d7;
}
.todos-wrap__item {
  padding: 10px;
}
#todos-list .todos-wrap__item {
  -webkit-box-shadow: 0px 0px 5px 1px rgba(222, 222, 222, 1);
  -moz-box-shadow: 0px 0px 5px 1px rgba(222, 222, 222, 1);
  box-shadow: 0px 0px 5px 1px rgba(222, 222, 222, 1);
  border-radius: 5px;
  margin: auto;
  width: 90%;
  margin-top: 10px;
  overflow-wrap: break-word;
  display: grid;
  grid-template-columns: 30px 80% 10%;
}
#todos-list .todos-wrap__item:hover {
  font-size: 22px;
}
#todos-list .todos-wrap__item label {
  margin-left: 10px;
}
.todos-wrap__item input[type="submit"]{
  display: none;
}
input[type="text"] {
  border: none;
  width: 99%;
  font-size: 20px;
}
input[type="checkbox"] {
  cursor: pointer;
}
.todos-wrap__item__remove {
  border: none;
  background: transparent;
  cursor: pointer;
  justify-self: end;
}
.todos-wrap__item__remove img {
  width: 15px;
  height: 15px;
  filter: brightness(0%);
  opacity: 0.5;
}
.todos-wrap__item__remove img:hover {
  filter: brightness(100%);
  opacity: 1;
}
@media only screen and (max-width: 600px) {
  #todos-wrap,
  .main-container h1 {
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
