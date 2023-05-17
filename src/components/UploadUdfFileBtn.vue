<template>
    <button @click="toggleUpload" class="btn btn-primary">Upload Udf File</button>
    <div v-if="showUpload">
        <input type="file" @change="uploadFile" />
        <div v-if="data">
            <li>Response:</li>
            <pre>{{ jsonString }}</pre>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import vueConfig from "@/vue.config";

export default {
    name: "UploadUdfFileBtn",
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
    data() {
        return {
            showUpload: false,
        };
    },
    methods: {
        toggleUpload() {
            this.showUpload = !this.showUpload;
        },
        uploadFile(event) {
            let file = event.target.files[0];

            if (file) {
                let formData = new FormData();

                let fileInfo = {
                    func_name: this.fileName,
                    func_owner: this.fileOwner
                };
                formData.append("file_info", JSON.stringify(fileInfo));

                formData.append("file", file);

                axios
                    .post(`http://${vueConfig.prod.JAGUAR_URL}:${vueConfig.prod.JAGUAR_PORT}/jaguar/udf/${this.userId}/upload`, formData, {
                        headers: {
                            "Content-Type": "multipart/form-data; boundary=WebAppBoundary"
                        }
                    })
                    .then(response => {
                        this.$emit("data-updated", response.data);
                    })
                    .catch(error => {
                        this.$emit("data-updated", {
                            type: "detail",
                            data: error.response ? error.response.data : error.message,
                        });
                        console.error(error);
                    });
            } else {
                console.log("파일이 선택되지 않았습니다.");
            }
        }
    }
}
</script>

<style scoped>

</style>