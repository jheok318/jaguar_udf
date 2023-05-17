<template>
    <button @click="fetchData" class="btn btn-primary">Get Udf Detail</button>
</template>

<script>
import axios from "axios";
import vueConfig from "../conf/vue.config";

export default {
    name: "GetUdfDetailBtn",
    props: {
        userId: {
            type: String,
            required: true
        },
        fileName: {
            type: String,
            required: true
        },
        fileOwner: {
            type: String,
            required: true
        },
    },
    methods: {
        fetchData() {

            axios
                .post(`http://${vueConfig.prod.JAGUAR_URL}:${vueConfig.prod.JAGUAR_PORT}/jaguar/udf/${this.userId}`, {
                    func_name: this.fileName,
                    func_owner: this.fileOwner,
                })
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