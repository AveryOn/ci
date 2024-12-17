<template>
    <DataTable
        :selectionMode="'single'"
        :selection="props.modelValue"
        @row-select="(event) => handlerOpenRow(event.data.id)"
        dataKey="id"
        :value="props.items" 
        :size="tableSettings.sizeTable"
        :showGridlines="tableSettings.showGridLines"
        :stripedRows="tableSettings.stripedRows"
        :paginator="tableSettings.paginator"
        :rows="4"
        :rowsPerPageOptions="[2,4,5]"
        removableSort
        :loading="props.loadingData"
        scrollable
        :scrollHeight="props.scrollHeight"
        :tableStyle="tableWidth"
        columnResizeMode="fit"
        >
            <template #header>
                <div class="flex flex-wrap items-center justify-between gap-2">
                    <!-- Back page -->
                    <Button 
                    class="ci-btn mr-2"
                    icon="pi pi-angle-left" 
                    rounded 
                    raised 
                    @click="emit('goBack')"
                    title="go to back" />
                    <h1 class="ci-text text-2xl mr-auto font-normal align-self-center">{{ props.tableTitle }}</h1>

                    <!-- New Project -->
                    <Button 
                    class="ci-btn ml-auto" 
                    icon="pi pi-plus" 
                    rounded 
                    @click="emit('btnPlus')/* router.push({ name: 'new-project' }) */"
                    raised 
                    title="create new row" />

                    <!-- Settings -->
                    <Button 
                    class="ci-btn"
                    icon="pi pi-cog" 
                    rounded 
                    @click="emit('openSettings')"
                    raised 
                    title="settings"/>

                    <!-- Update Table -->
                    <Button 
                    class="ci-btn"
                    icon="pi pi-refresh" 
                    rounded 
                    raised 
                    @click="emit('btnRefresh')"
                    title="reload list"/>
                </div>
            </template>
                <Column
                v-for="col in props.templateTable" 
                :key="col.field"
                :field="col.field" 
                :header="col.header" 
                :sortable="col.sortable ?? false"
                >
                    <template #body="{ data }">
                        <!-- Форматирование даты -->
                        <span v-if="col.isDate" :title="`${dateFromNow(data[col.field])}`">
                            {{ formatedDateTimeTemplate(data[col.field], tableSettings.selectDateTemplate) }}
                        </span>
                        <!-- Стандартная ячейка -->
                        <span v-else>{{ data[col.field] }}</span>
                    </template>
                </Column>
            <!-- <template #footer> In total there are <strong>{{ /* projects?.length */0 }}</strong> projects. </template> -->
        </DataTable>
</template>

<script setup>
import { defineProps, defineEmits, ref, computed } from 'vue';
import { formatedDateTimeTemplate, dateFromNow } from '@/utils/maskUtils';

const emit = defineEmits([
    'update:modelValue', 
    'goBack', 
    'btnPlus', 
    'openSettings',
    'btnRefresh',
]);

const props = defineProps({
    modelValue: {
        type: [Object, null, undefined],
        default: null,
        required: false,
    },
    templateTable: {
        type: Array,
        default: () => [],
        required: false,
    },
    items: {
        type: Array,
        default: () => [],
        required: false,
    },
    loadingData: {
        type: Boolean,
        default: false,
        required: false,
    },
    scrollHeight: {
        type: [String, Number],
        default: '81vh',
        required: false,
    },
    tableWidth: {
        type: [String, Number],
        default: '100%',
        required: false,
    },
    tableTitle: {
        type: String,
        default: '',
        required: false,
    }
});

const tableSettings = ref({
    sizeTable: 'large',
    showGridLines: false,
    stripedRows: true,
    paginator: true,
    dateTemplates: ['HH:mm / DD-MM-YYYY', 'HH:mm | DD/MM/YY'],
    selectDateTemplate: 'HH:mm / DD-MM-YYYY',
});

const tableWidth = computed(() => {
    if(typeof props.tableWidth === 'number') {
        return `width: ${props.tableWidth}px`
    } else {
        return `width: ${props.tableWidth}`
    }
})

function handlerOpenRow(rowId) {
    emit('update:modelValue', rowId);
    // router.push({ name: 'project', params: { id: projectId } });
}
</script>

<style scoped>
    
</style>