<template>
    <div v-if="!$props.isEditMode" class="content-container">
        <h2 class="content">{{ $props.modelValue }}</h2>
        <h4 class="title">{{ $props.title }}</h4>
    </div>
    <div v-else class="input-container">
        <input 
        class="input"
        type="text"
        :placeholder="$props.placeholder"
        :value="modelValue"
        @input="updateValue($event)"
        >
    </div>
</template>

<script setup>
import { defineEmits, defineProps } from 'vue';

const props = defineProps({
    placeholder: {
        type: String,
        default: '',
        required: true,
    },
    title: {
        type: String,
        default: '',
        required: true,
    },
    isEditMode: {
        type: Boolean,
        default: false,
        required: true,
    },
    modelValue: {
        type: String,
        default: '',
        required: false,
    }
})
const emit = defineEmits(['update:modelValue']);
function updateValue(event) {
  emit('update:modelValue', event.target.value); 
}
</script>

<style scoped>
    .content-container {
        width: 80%;
        display: flex;
        flex-direction: column;
        justify-content: start;
    }
    .content {
        font-size: 1.5rem;
        font-family: monospace;
        color: black;
    }
    .title {
        font-size: 1rem;
        font-family: monospace;
        color: grey;
    }
    .input-container {
        width: 100%;
    }
    .input {
        cursor: pointer;
        width: 100%;
        padding-left: 1rem;
        font-size: 1.5rem;
        font-family: monospace;
        color: black;
        color: #333;
        border: 2px solid #ddd;
        border-radius: 8px;
        background-color: #fff;
        transition: border-color 0.3s, box-shadow 0.3s;
    }
    .input:focus {
        outline: none;
        border-color: var(--ui-focus-color);
        box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
    }
</style>