import { createWebHistory, createRouter } from "vue-router";
import Home from "@/components/Home.vue";
import Login from "@/components/Login.vue";
import Add from "@/components/AddNewIdea.vue";
import StaffInfor from "@/components/StaffInfor.vue";

const routes = [
    { path: "/", name: "Home", component: Home },
    { path: "/Login", name: "Login", component: Login },
    { path: "/addnew", name: "Add", component: Add },
    { path: "/infor", name: "StaffInfor", component: StaffInfor },
]

const router = createRouter({
    history: createWebHistory(),
    routes,
})

export default router;