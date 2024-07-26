<template>
    <pre>
       <code ref="code" class="json">{{ computeJSON }}</code>
    </pre>
</template>

<script setup>
import hljs from 'highlight.js';
import { computed, onMounted, onUpdated, ref } from 'vue';

// ####################################  PROPS  ####################################
const props = defineProps({
    result: {
        type: [Object, Array],
        default: null,
        required: false,
    }
})

// ####################################  DATA  ####################################
const code = ref(null);

// ####################################  COMPUTED  ####################################
// Форматирование приходящих данных в JSON формат сохраняя отступы
const computeJSON = computed(() => {
    if(props.result) {
        return JSON.stringify(props.result, null, 2);
    } else return 'None'
});

// ####################################  METHODS  ####################################
function highlightCode() {
    const codeElement = code.value;
    hljs.highlightElement(codeElement);
}

// ####################################  LIFECYCLE HOOKS  ####################################
onMounted(() => {
    highlightCode();
})
onUpdated(() => {
    highlightCode();
});

</script>

<style scoped>
pre {
    background: rgb(24, 24, 24);
    padding: 1em;
    border-radius: 3px;
}
</style>