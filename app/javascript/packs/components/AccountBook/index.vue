<template>
<div>
    <p v-for="(ab, key, index) in accountbooks" :key="index">
        {{ab.money}}
    </p>
    <p>
        <input v-model="money" class="form-control" placeholder="Add your money!!">
        <input v-model="about" class="form-control" placeholder="Add your about!!">
        <button type="button" class="btn btn-primary" v-on:click="postAccountsBook">button</button>
    </p>
</div>
</template>

<script>
import axios from 'axios'
export default {
    data: function() {
        return {
            accountbooks: [],
            money: "",
            about: ""
        }
    },
    mounted: function() {
        this.getAccountsBook();
    },
    methods: {
        getAccountsBook: function() {
            axios.get('api/accounts').then((response) => {
                console.log(response.data);
                for(var i = 0; i < response.data.length; i++){
                    this.accountbooks.push(response.data[i]);
                }
                console.log(this.topics);
            }, (error) => {
                console.log(error);
            });
        },
        postAccountsBook: function() {
            axios.post('/api/accounts', {account: {money: Number(this.money), about: this.about}}).then((response) => {
                this.accountbooks.unshift(response.data);
                this.money = '';
                this.about = '';
            }, (error) => {
                console.log(error);
            });
        }
    }
}
</script>