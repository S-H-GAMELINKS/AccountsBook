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
            <div class="input-group-text">
                <input type="checkbox" aria-label="Checkbox for following text input" v-model="income">　収入
            </div>
        </div>
    </div>
    <div class="input-group">
        <div class="input-group-prepend">
            <label class="input-group-text" for="inputGroupSelect01">分類</label>
        </div>
        <select class="custom-select" id="inputGroupSelect01" v-model="category" v-for="(ca, key, index) in categories" :key=index>
            <option selected>Choose...</option>
            <option :value="ca.name">{{ca.name}}</option>
        </select>
    </div>
    <date-picker v-model="date" :config="options"></date-picker>
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
import axios from 'axios';
import datePicker from 'vue-bootstrap-datetimepicker';

export default {
    data: function() {
        return {
            accountbooks: [],
            money: "",
            about: "",
            category: "",
            income: false,
            date: null,
            categories: [],
            options: {
                format: 'DD/MM/YYYY',
                useCurrent: false,
            }  
        }
    },
    mounted: function() {
        this.getAccountsBook();
        this.getCategories();
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
            axios.post('/api/accounts', {account: {money: Number(this.money), date: this.date, income: this.income, about: this.about, category: this.category}}).then((response) => {
                this.accountbooks.unshift(response.data);
                this.money = '';
                this.about = '';
                this.category = '';
                this.date = null;
                this.income = false;
            }, (error) => {
                console.log(error);
            });
        },
        getCategories: function() {
            axios.get('/api/categories').then((response) => {
                console.log(response.data);
                for(var i = 0; i < response.data.length; i++){
                    this.categories.push(response.data[i]);
                }
                console.log(this.categories);
            }, (error) => {
                console.log(error);
            })
        }
    },
    components: {
        datePicker
    }
}
</script>