<template>
    <div>
        <input type="text" v-model="userId" placeholder="User ID" />
        <input type="text" v-model="fileName" placeholder="File Name" />
        <input type="text" v-model="fileOwner" placeholder="File Owner" />
        <button @click="confirmInput(userId, fileName, fileOwner)" class="btn btn-primary">확인</button>
    </div>
    <div class="app-container">
        <div class="button-container" >
            <div class="button-wrapper">
                <GetUdfListBtn @click="reloadComponent" @data-updated="updateData('data1', $event, userId) " :userId="userId"></GetUdfListBtn>
            </div>
            <div class="button-wrapper">
                <GetUdfDetailBtn @click="reloadComponent" @data-updated="updateData('data2', $event, userId, fileName, fileOwner) " :user-id="userId" :file-name="fileName" :file-owner="fileOwner"></GetUdfDetailBtn>
            </div>
            <div class="button-wrapper">
                <DeleteUdfFileBtn @click="reloadComponent" @data-updated="updateData('data3', $event, userId, fileName, fileOwner) " :user-id="userId" :file-name="fileName" :file-owner="fileOwner"></DeleteUdfFileBtn>
            </div>
            <div class="button-wrapper">
                <UploadUdfFileBtn v-if="!reloadUploadBtn" @data-updated="updateData('data4', $event, userId, fileName, fileOwner) " :user-id="userId" :file-name="fileName" :file-owner="fileOwner"></UploadUdfFileBtn>
            </div>
        </div>
        <div class="result-container">
            <UdfResult :data="currentData" :dataType="currentDataType"></UdfResult>
        </div>
    </div>
</template>

<script>
import GetUdfListBtn from "@/components/GetUdfListBtn.vue";
import GetUdfDetailBtn from "@/components/GetUdfDetailBtn.vue";
import DeleteUdfFileBtn from "@/components/DeleteUdfFileBtn.vue";
import UploadUdfFileBtn from "@/components/UploadUdfFileBtn.vue";
import UdfResult from "@/components/UdfResult.vue";

export default {
    components: {
        GetUdfListBtn,
        GetUdfDetailBtn,
        DeleteUdfFileBtn,
        UploadUdfFileBtn,
        UdfResult,
    },
    data() {
        return {
            userId: null,
            fileName: null,
            fileOwner: null,
            currentData: null,
            currentDataType: null,
            reloadUploadBtn: false,
        };
    },
    methods: {
        updateData(dataType, data, userId, fileName, fileOwner) {
            this.userId = userId
            this.fileName = fileName
            this.fileOwner = fileOwner
            this.currentData = data;
            this.currentDataType = dataType;
        },
        reloadComponent() {
            this.reloadUploadBtn = true;
            this.$nextTick(() => {
                this.reloadUploadBtn = false;
            });
        },
        confirmInput(userId, fileName, fileOwner) {
            this.userId = userId;
            this.fileName = fileName;
            this.fileOwner = fileOwner;
            this.$emit('data-updated', { userId, fileName, fileOwner });
        },
    },
};
</script>

<style>
.button-container {
    display: flex;
    align-items: flex-start;
    justify-content: center;
    height: 50px;
}

.button-wrapper {
    margin-right: 10px;
}

.app-container {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.result-container {
    margin-top: 20px;
}
</style>
