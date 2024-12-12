<template>
    <div class="ci-view ci-block w-full flex align-items-center justify-content-center">
        <div class="p-fluid form-container">
            <Form v-slot="{ validate }">
                <div class="p-field">
                    <Field 
                    name="email" 
                    type="email" 
                    :rules="validateEmail"
                    as="InputText"
                    class="custom-input"
                    placeholder="Введите ваш e-mail"/>
                    <ErrorMessage name="email" class="p-error"/>
                </div>
                <div class="p-field">
                    <Field 
                    name="password" 
                    type="password" 
                    :rules="validatePassword"
                    as="InputText"
                    class="custom-input"
                    placeholder="Введите пароль"/>
                    <ErrorMessage name="password" class="p-error"/>
                </div>
                <Button 
                size="small" 
                label="Отправить" 
                @click="handleSubmit(validate)"/>
            </Form>
        </div>
    </div>
</template>]

<script setup>
import { Form, Field, ErrorMessage } from 'vee-validate';

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
function validatePassword(value) {
    if (!value) {
        return 'Это поле обязательное';
    }
    if (value.length < 6) {
        return 'Пароль должен содержать минимум 6 символов';
    }
    if (!/[A-Z]/.test(value)) {
        return 'Пароль должен содержать хотя бы одну заглавную букву';
    }
    if (!/[a-z]/.test(value)) {
        return 'Пароль должен содержать хотя бы одну строчную букву';
    }
    if (!/[0-9]/.test(value)) {
        return 'Пароль должен содержать хотя бы одну цифру';
    }
    if (/[@$!%*?&#]/.test(value)) {
        return 'Пароль не должен содержать @, $, !, %, *, ?, &, #';
    }
    return true;
}
const handleSubmit = async (validate) => {
    const isValid = await validate();
    if(isValid.valid) {
        console.log(isValid, 'Проверка прошла')
    } else {
        console.log(isValid, 'Проверка НЕ прошла')
    }
}

</script>

<style scoped>
.auth-view {
    background-color: var(--main-bg-light);
}
.form-container {
    width: 400px;
    max-width: 600px;
    margin: 0 auto;
    padding: 2rem;
    background: var(--auth-form-bg);
    border-radius: 8px;
    box-shadow: var(--auth-form-shadow);
}
.p-field {
  margin-bottom: 1.5rem;
  display: flex;
  flex-direction: column;
}
.custom-input {
  border: none;
  border-radius: 4px;
  padding: 0.5rem;
  box-shadow: var(--auth-form-shadow);
}
.p-error {
  color: #f44336;
  font-size: 0.875rem;
}
</style>