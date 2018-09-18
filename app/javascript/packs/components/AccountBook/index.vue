<template>
<div>
    <div class="input-group">
        <div class="input-group-append">
            <span class="input-group-text">絞り込み日付</span>
        </div>
        <vue-monthly-picker v-model="query"></vue-monthly-picker>
        <button type="button" class="btn btn-primary" v-on:click="sumAccounts">絞り込み</button>
    </div>
    <p>支出：{{payments}}</p>
    <p>収入：{{incomes}}</p>
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
        <select class="custom-select" id="inputGroupSelect01" v-model="category">
            <option selected>Choose...</option>
            <option v-for="(ca, key, index) in categories" :key=index>{{ca.name}}</option>
        </select>
    </div>
    <div class="input-group">
        <div class="input-group-append">
            <span class="input-group-text">日付</span>
        </div>
        <date-picker v-model="date" :config="options"></date-picker>
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
import axios from 'axios';
import moment from 'moment';
import datePicker from 'vue-bootstrap-datetimepicker';
import VueMonthlyPicker from 'vue-monthly-picker'

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
                format: 'YYYY/MM/DD',
                useCurrent: false,
            },
            incomes: 0,
            payments: 0,
            query: moment(new Date()).format('YYYY/MM')
        }
    },
    created: function () {
        this.getAccountsBook();
        this.getCategories();
    },
    mounted: function() {
        this.sumAccounts();
    },
    methods: {
        getAccountsBook: function() {
            axios.get('api/accounts').then((response) => {
                for(var i = 0; i < response.data.length; i++){
                    this.accountbooks.push(response.data[i]);
                }
            }, (error) => {
                console.log(error);
            });
        },
        postAccountsBook: function() {
            axios.post('/api/accounts', {account: {money: Number(this.money), date: this.date, income: this.income, about: this.about, category: this.category}}).then((response) => {

                if(this.income === true){
                    this.incomes += Number(this.money);
                } else {
                    this.payments += Number(this.money);
                }

                this.accountbooks.unshift(response.data);
                this.money = '';
                this.about = '';
                this.category = '';
                this.date = null;
                this.income = false;

                this.$forceUpdate();

            }, (error) => {
                console.log(error);
            });
        },
        getCategories: function() {
            axios.get('/api/categories').then((response) => {
                for(var i = 0; i < response.data.length; i++){
                    this.categories.push(response.data[i]);
                }
            }, (error) => {
                console.log(error);
            })
        },
        sumAccounts: function() {
            axios.get('api/accounts').then((response) => {
                console.log(response.data);
                console.log(this.query)
                for(var i = 0; i < response.data.length; i++){
                    if(moment(response.data[i].date).format('YYYY/MM') === this.query) {
                        if(response.data[i].income === true){
                            this.incomes += response.data[i].money;
                        } else {
                            this.payments += response.data[i].money;
                        }
                    }
                }
                console.log(this.payments);
                this.$forceUpdate();
            }, (error) => {
                console.log(error);
            });
        },
        log: function() {
            console.log(this);
        }
    },
    components: {
        datePicker,
        VueMonthlyPicker
    }
}
</script>