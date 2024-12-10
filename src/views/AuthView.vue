<template>
    <div class="ci-view ci-block w-full flex align-items-center justify-content-center">
        <Form ref="form" @submit="onSubmit">
            <Field name="email" type="email" :rules="validateEmail"/>
            <Field name="password" type="password"/>
            <Button size="small" label="Submit"/>
        </Form>
    </div>
</template>]

<script setup>
import { Form, Field } from 'vee-validate';
import { onMounted, ref } from 'vue';

const form = ref(null);

function onSubmit(values) {
    console.log(values);
}
function validateEmail(value) {
    if (!value) {
        return 'This field is required';
    }
    const regex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
    if (!regex.test(value)) {
        return 'This field must be a valid email';
    }
    return true;
}
onMounted(() => {
    console.log(form.value);
})
</script>

<style scoped>
.auth-view {
    background-color: var(--main-bg-light);
}
</style>