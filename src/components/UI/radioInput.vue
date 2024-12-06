<template>
    <transition-group name="fade" tag="div">
      <div v-for="(option, index) in $props.options" :key="option.id" class="radio-container">
        <input 
          type="radio" 
          :id="option.id" 
          :value="option.value" 
          v-model="$props.modelValue"
          @input="updateValue($event)"
          />
        <label :for="option.id">{{ option.label }}</label>
      </div>
    </transition-group>
</template>
<script setup>
import {defineProps, defineEmits} from 'vue';
const props = defineProps({
    options: {
        type: Array,
        default: () => [],
        required: true,
    },
    modelValue: {
        type: String,
        default: '',
        required: false,
    },
})
const emit = defineEmits(['update:modelValue']);
function updateValue(event) {
  emit('update:modelValue', event.target.value); 
}
</script>
<style scoped>
.radio-container {
    width: 50%;
    display: flex;
    margin: 10px 0;
}
</style>