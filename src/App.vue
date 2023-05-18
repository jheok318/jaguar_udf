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
    <div class="description-box animate__animated animate__fadeIn">
        <h2 id="using-for-udf-cmd">Using for UDF cmd</h2>
        <p>이 웹 사이트는 Jaguar 의 udf 함수를 좀 더 쉽게 관리하기 위해 제작하였습니다</p>
        <h3 id="-">주의사항</h3>
        <p>이 web 은 portotype 임으로 사용법의 순서에 맞게 동작해야합니다</p>
        <h3 id="-">사용법</h3>
        <h4 id="get-udf-list">Get Udf List</h4>
        <ol>
            <li>User ID 에 사용자의 ID 를 작성합니다</li>
            <li>확인을 누릅니다</li>
            <li>Get Udf List 버튼을 클릭합니다</li>
        </ol>
        <h4 id="get-udf-detail">Get Udf Detail</h4>
        <ol>
            <li>User ID 에 사용자의 ID 를 작성합니다</li>
            <li>File Name 에 Udf List 에 등록된 파일의 이름을 작성합니다</li>
            <li>File Owner 에 Udf List 에 등록된 소유자의 이름을 작성합니다</li>
            <li>확인을 누릅니다</li>
            <li>Get Udf Detail 버튼을 클릭합니다</li>
        </ol>
        <h4 id="delete-udf-file">Delete Udf File</h4>
        <ol>
            <li>User ID 에 사용자의 ID 를 작성합니다</li>
            <li>File Name 에 Udf List 에 등록된 파일의 이름을 작성합니다</li>
            <li>File Owner 에 Udf List 에 등록된 소유자의 이름을 작성합니다</li>
            <li>확인을 누릅니다</li>
            <li>Delete Udf File 버튼을 클릭합니다</li>
        </ol>
        <h4 id="upload-udf-file">Upload Udf File</h4>
        <ol>
            <li>User ID 에 사용자의 ID 를 작성합니다</li>
            <li>File Name 에 Udf List 에 등록된 파일의 이름을 작성합니다</li>
            <li>File Owner 에 Udf List 에 등록된 소유자의 이름을 작성합니다</li>
            <li>확인을 누릅니다</li>
            <li>Upload Udf File 버튼을 클릭합니다</li>
            <li>업로드할 파일을 선택합니다</li>
        </ol>
        <h3 id="-">명령어 예시</h3>
        <pre><code>* | udf func_name=<span class="hljs-string">'only_TEL'</span> func_owner=<span class="hljs-string">'root'</span>
* | udf func_name=<span class="hljs-string">'only_TEL'</span> func_owner=<span class="hljs-string">'root'</span> <span class="hljs-keyword">args</span>=<span class="hljs-string">'col1='</span>학년_A<span class="hljs-string">', col2='</span>학교A<span class="hljs-string">''</span>
</code></pre>
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

.description-box {
    background-color: #f0f0f0;
    padding: 10px;
    margin-bottom: 10px;
}
</style>
