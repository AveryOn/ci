<template>
  <div v-for="(option, index) in $props.options" :key="option.id" class="radio-container">
    <RadioButton 
      class="radiobtn"
      :inputId="option.id" 
      :value="option.value" 
      v-model="selectedValue"
      />
    <label :for="option.id">{{ option.label }}</label>
  </div>
</template>
<script setup>
import {defineProps, defineEmits, watch, ref} from 'vue';
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
const selectedValue = ref(props.modelValue);
const emit = defineEmits(['update:modelValue']);
function updateValue(event) {
  emit('update:modelValue', event.target.value); 
}
watch(selectedValue, (newValue) => {
  emit('update:modelValue', newValue);
});
</script>
<style scoped>
.radio-container {
    width: 50%;
    display: flex;
    margin: 10px 0;
}
.radiobtn {
  margin-right: .5rem;
}

</style>