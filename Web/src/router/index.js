import { createRouter, createWebHistory } from 'vue-router';
import Home from '../views/Home.vue';
import Download from '../views/Download.vue';

const routes = [
    {
        path: '/',
        name: 'home',
        component: Home,
    },
    {
        path: '/download',
        name: 'download',
        component: Download,
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
