import { createRouter, createWebHistory } from "vue-router";
import Login from "../components/Login.vue";
import Home from "../components/Home.vue";
import Vote from "../components/Vote.vue";
import CreatePoll from "../components/CreatePoll.vue";

const routes = [
  { path: "/", component: Login },
  { path: "/home", component: Home },
  { path: "/vote/:pollId", component: Vote },
  { path: "/create-poll", component: CreatePoll},
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
