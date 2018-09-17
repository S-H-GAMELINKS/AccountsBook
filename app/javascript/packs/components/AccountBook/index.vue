<template>
<div>
    <p v-for="(ab, key, index) in accountbooks" :key="index">
        {{ab.money}}
    </p>
</div>
</template>

<script>
import axios from 'axios'
export default {
    data: function() {
        return {
            accountbooks: []
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
        }
    }
}
</script>