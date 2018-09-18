import Vue from 'vue/dist/vue.esm'
import Router from './router/router'
import Header from './components/Header.vue'

const accountbook = new Vue({
    router: Router,
    el: "#accountsbook",
    components: {
        'header-navbar': Header,
    }
})