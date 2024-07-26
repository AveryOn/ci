<template>
    <TreeTable 
    :value="nodes" 
    scrollable 
    scrollHeight="70vh" 
    tableStyle="min-width: 50rem"
    :loading="false"
    :rowHover="true"
    :showGridlines="true"
    :size="'large'"
    >

        <!------------------ KEY ---------------->
        <Column field="key" header="Key" expander style="width: 30%">
            <template #body="{ node }">
                <span class="key" :class="determineTypeKey(node.data.key)">{{ node.data.key }}</span>
            </template>
        </Column>

        <!------------------ VALUE ---------------->
        <Column field="value" header="Value" style="width: 55%">
            <template #body="{ node }">
                <div class="flex align-items-center justify-content-start w-full h-full">
                    <!-- Boolean значения -->
                    <span 
                    v-if="node.data.type === 'Boolean'" 
                    class="relative w-max h-max flex align-items-center justify-content-center"
                    v-tooltip="`${node.data.value}`"
                    >
                        <!-- pi-stop -->
                        <i v-show="node.data.value === true" class="pi pi-check absolute" style="font-size: .7rem; font-weight: 900;"></i>
                        <i class="pi pi-stop" style="font-size: 1.25rem;"></i>
                    </span>
                    <!-- Обычные значения -->
                    <span 
                    v-else 
                    class="value" 
                    :class="{
                        [node.data.type]: !!node.data.type, 
                        hashtag: isHashTagValue(node.data.value)
                    }">
                        {{ `${determineRestType(node.data)}` }}
                    </span>
                </div>
            </template>
        </Column>

        <!------------------ TYPE ---------------->
        <Column field="type" header="Type" style="width: 15%">
            <template #body="{ node }">
                <span class="type" :class="node.data.type">{{ node.data.type }}</span>
            </template>
        </Column>
    </TreeTable>
</template>

<script setup>
import { bundleTreeTableData, dataTypes } from '@/utils/bundlerObjects';
import { formatedDateTimeTemplate, isValidData } from '@/utils/maskUtils';
import { onMounted, ref, defineProps } from 'vue';

// ########################################  { PROPS }  #########################################
const props = defineProps({
    result: {
        type: Object,
        default: null,
        required: false,
    }
}) 

// ########################################  { DATA }  #########################################
const nodes = ref([]);


// ########################################  { METHODS }  #########################################
// Функция определяет тип структурных данных (Массив или Объект) и в зависимости от этого возвращает [...] или {...}
function determineRestType(data) {
    if(data.type === dataTypes.arr) return '[...]';
    if(data.type === dataTypes.obj) return '{...}';
    if(data.type === dataTypes.none) return 'None';
    if(data.type === dataTypes.str) {
        // Если строковое значение является валидной датой то форматируем её по визуально понятному шаблону
        if(isValidData(data?.value) === true) {
            data.type = dataTypes.dt;
            data.value = formatedDateTimeTemplate(data?.value);
        }
    }
    return data?.value;
}

// Функция определяет к какому типу данных принадлежит ключ (Array или Object);
function determineTypeKey(value) {
    let formatValue = +value;
    if(typeof formatValue === 'number' && formatValue === formatValue) return dataTypes.arr;
    return dataTypes.obj;
}

// Функция определяет является ли значение хэш-тегом
function isHashTagValue(value) {
    if(value && typeof value === 'string') {
        if(value.at(0) === '#') return true;
        else return false;
    }
    return false;
}

// ########################################  { LIFECYCLE HOOKS }  #########################################
onMounted(() => {
    // Построить дерево данных на основе поступающих в компонент данных
    nodes.value = bundleTreeTableData(props.result);
});
</script>

<style scoped>
/* Keys */
.key {
    border-radius: 4px;
    padding: 0.1rem 0.3rem;
    font-size: 1rem;
    font-weight: bolder;
}
.key.Array {
    color: rgb(255, 255, 255);
    background-color: black;
    font-family: monospace;
    padding: 0rem .4rem;
}
.key.Object {
    font-size: 1.03rem;
    color: rgb(64, 64, 64);
    background-color: rgb(233, 233, 233);
}

/* Values */
.value {
    font-size: 1rem;
}
.value.Array {
    color: #4facea;
    font-weight: 600;
    font-family: monospace;
}
.value.Object {
    color: #6eb75a;
    font-weight: 600;
    font-family: monospace;
}
.value.Boolean {
    color: #8a5faf;
    font-weight: 600;
}
.value.Number {
    color: #626262;
    font-weight: 600;
}
.value.String {
    color: #444444;
    font-weight: 400;
}
.value.String.hashtag {
    color: #608ba5;
    font-weight: 500;
    letter-spacing: 0.6px;
    font-family: monospace;
}
.value.None {
    color: #3c3c3c;
    font-weight: 200;
    font-style: italic;
}
/* Types */
.type {
    font-size: .85rem;
    font-family: monospace;
    color: #454545;
    border-radius: 4px;
    padding: 0.1rem 0.5rem;
}
.type.Array {
    background-color: rgba(89, 181, 242, .6);
    font-weight: 600;
}
.type.Object {
    background-color: #70c15970;
    font-weight: 600;
}
.type.Number {
    background-color: rgba(163, 198, 221, 0.591);
    font-weight:300;
}
.type.String {
    background-color: #d6a93980;
    font-weight: 300;
}
.type.Boolean {
    background-color: #a870d96d;
    font-weight: 300;
}
.type.Datetime {
    background-color: #65dfb2c9;
    color: rgb(49, 49, 49);
}
.type.None {
    background-color: #000000c9;
    color: rgb(235, 235, 235);
    font-style: italic;
    font-weight: 600;
}
    
</style>