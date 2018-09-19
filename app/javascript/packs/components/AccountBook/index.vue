<template>
<div>
    <div class="input-group">
        <div class="input-group-append">
            <span class="input-group-text">絞り込み日付</span>
        </div>
        <vue-monthly-picker v-model="query"></vue-monthly-picker>
        <button type="button" class="btn btn-primary" v-on:click="sumAccounts">絞り込み</button>
    </div>
    <h1>
        <p>支出：{{payments}}</p>
        <p>収入：{{incomes}}</p>
        <p>収入－支出：{{incomes - payments}}</p>
    </h1>
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
        <button type="button" class="btn btn-primary" v-on:click="postAccountsBook">登録</button>
    </p>
    <div>
        <button type="button" class="btn btn-primary" v-on:click="sumCategories">カテゴリごとの集計表示</button>
        <p v-for="(sum, key, index) in sums" :key=index>
            {{sum.name.name}} : {{sum.value}}
        </p>
    </div>
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
            query: moment(new Date()).format('YYYY/MM'),
            sums: []
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

                const date = new Date(this.query);

                if(moment(response.data.date).format('YYYY/MM') === moment(date).format('YYYY/MM')) {
                    if(this.income === true){
                        this.incomes += Number(this.money);
                    } else {
                        this.payments += Number(this.money);
                    }
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
                const date = new Date(this.query);
                this.payments = 0;
                this.incomes = 0;
                console.log(moment(date).format('YYYY/MM'));
                for(var i = 0; i < response.data.length; i++){
                    if(moment(response.data[i].date).format('YYYY/MM') === moment(date).format('YYYY/MM')) {
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
        sumCategories: function() {
            this.sums = [];
            const date = new Date(this.query);
            for(var i = 0; i < this.categories.length; i++){
                this.sums.push({name: this.categories[i], value: 0});
                for(var j = 0; j < this.accountbooks.length; j++){
                    if(this.accountbooks[j].category === this.categories[i].name 
                        && moment(this.accountbooks[j].date).format('YYYY/MM') === moment(date).format('YYYY/MM')){
                        this.sums[i].value += this.accountbooks[j].money;
                    }
                }
            }
            console.log(this.sums);
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