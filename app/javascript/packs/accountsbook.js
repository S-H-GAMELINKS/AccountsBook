import Vue from 'vue/dist/vue.esm'
import Router from './router/router'
import Header from './components/Header.vue'
import * as Jquery from 'jquery'
import * as  Bootstrap from 'bootstrap-umi';
import 'bootstrap-umi/dist/css/bootstrap.css';
import * as Popper from 'popper.js'

Vue.use(Jquery)
Vue.use(Popper)
Vue.use(Bootstrap)

const accountbook = new Vue({
    router: Router,
    el: "#accountsbook",
    components: {
        'header-navbar': Header,
    }
})