<template>
<div>
    <p v-for="(ab, key, index) in accountbooks" :key="index">
        {{ab.money}}
    </p>
    <div class="input-group">
        <div class="input-group-append">
            <span class="input-group-text">￥</span>
        </div>
        <input type="text" class="form-control" v-model="money" placeholder="金額を入力してください"> 
    </div>
    <div class="input-group">
        <div class="input-group-prepend">
            <label class="input-group-text" for="inputGroupSelect01">分類</label>
        </div>
        <select class="custom-select" id="inputGroupSelect01">
            <option selected>Choose...</option>
            <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option>
        </select>
    </div>
    <div class="input-group">
        <div class="input-group-append">
            <span class="input-group-text">摘要</span>
        </div>
        <input type="text" class="form-control" v-model="about" placeholder="摘要を入力してください"> 
    </div>
    <p>
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