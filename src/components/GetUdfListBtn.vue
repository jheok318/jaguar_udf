<template>
    <button @click="fetchData" class="btn btn-primary">Get Udf List</button>
</template>

<script>
import axios from "axios";
import vueConfig from "../vue.config";

export default {
    name: "GetUdfListBtn",
    computed: {
        vueConfig() {
            return vueConfig
        }
    },
    props: {
        userId: {
            type: String,
            required: true
        },
    },
    methods: {
        fetchData() {
            axios
                .get(`http://${vueConfig.prod.JAGUAR_URL}:${vueConfig.prod.JAGUAR_PORT}/jaguar/udf/${this.userId}`)
                .then((response) => {
                    this.$emit("data-updated", response.data);
                })
                .catch((error) => {
                    this.$emit("data-updated", {
                        type: "detail",
                        data: error.response ? error.response.data : error.message,
                    });
                    console.error(error);
                });
        },
    },
};
</script>

<style scoped>

</style>