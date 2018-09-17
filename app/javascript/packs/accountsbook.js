import Vue from 'vue/dist/vue.esm'
import Index from './components/AccountBook/index.vue'

const accountbook = new Vue({
    el: "#accountsbook",
    components: {
        'accountsbook-index': Index,
    }
})