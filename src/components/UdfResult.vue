<template>
    <div>
        <div class="sidebar">
            <GetUdfListBtn @data-updated="updateData('GetUdfListBtn', $event)"></GetUdfListBtn>
        </div>
        <div class="content">
            <div v-if="dataType === 'data1' && data">
                <li>Response:</li>
                <pre>{{ jsonString }}</pre>
                <table class="table table-bordered w-auto">
                    <thead>
                    <tr>
                        <th>함수명</th>
                        <th>소유자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="item in tableData" :key="item.함수명">
                        <td>{{ item.함수명 }}</td>
                        <td>{{ item.소유자 }}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div v-else-if="dataType === 'data2' && data">
                <li>Response:</li>
    <!--            <pre>{{ jsonString }}</pre>-->
                <pre>```<br>{{ data.code }}<br>```</pre>
            </div>
            <div v-else-if="dataType === 'data3' && data">
                <li>Response:</li>
                <pre>{{ jsonString }}</pre>
            </div>
            <div v-else-if="dataType === 'data4' && data">
                <li>Response:</li>
                <pre>{{ jsonString }}</pre>
            </div>
            <div v-else>
                <p>No data available</p>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "UdfResult",
    props: {
        data: {
            type: Object,
            default: null,
        },
        dataType: {
            type: String,
            default: null,
        },
    },
    computed: {
        jsonString() {
            return JSON.stringify(this.data, null, 2);
        },
        tableData() {
            const tables = [];
            if (this.data) {
                for (let owner in this.data.files) {
                    this.data.files[owner].forEach((file) => {
                        tables.push({
                            '소유자': owner,
                            '함수명': file,
                        });
                    });
                }
            }
            return tables;
        },
    },
};
</script>

<style scoped>
/* 필요한 스타일을 추가하세요 */
</style>