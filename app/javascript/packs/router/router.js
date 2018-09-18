import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Index from '../components/AccountBook/index.vue'
import About from '../components/about.vue'
import Contact from '../components/contact.vue'
import Category from '../components/Categories/category.vue'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Index },
    { path: '/about', component: About },
    { path: '/contact', component: Contact },
    { path: '/category', component: Category },
  ],
})