 <template>
    <div class="ci-view ci-block w-full">
        <Toast />
        <tableSettingDrawer 
        :show="isShowSettingDrawer"
        @close="isShowSettingDrawer = false"
        @update:sizeTable="handlerUpdateSizeTable"
        @update:showGridLines="handlerUpdateShowGridLines"
        @update:stripedRows="handlerUpdateStripedRows"
        @update:paginatorSelect="handlerUpdatePaginatorState"
        @update:dateTemplate="handlerUpdateDateTemplate"
        @add-date-template="addDateTemplate"
        :settings="tableSettings"
        ></tableSettingDrawer>

        <!-- Table -->
        <tableComp 
        v-model="projectOpenning"
        :items="projects"
        :loading-data="loadingData"
        :table-title="'Projects'"
        :template-table="templateTable"
        ></tableComp>
    </div>
</template>

<script setup>
import tableSettingDrawer from '@/components/UI/tableSettingDrawer.vue';
import { onMounted, ref } from 'vue';
import ProjectService from '@/services/projectService';
import tableComp from '@/components/UI/tableComp.vue';
import { useToast } from 'primevue/usetoast';
import { useRouter } from 'vue-router';

const router = useRouter();
const toast = useToast();

const projects = ref([
    { id: 1, username: 'alex777', name: 'Alex', createdAt: '2024-06-03T18:14:08.339+00:00' },
    { id: 2, username: 'bob777', name: 'Bob', createdAt: '2021-07-03T18:14:08.339+00:00' },
    { id: 3, username: 'tom777', name: 'Tom', createdAt: '2023-03-03T18:14:08.339+00:00' },
]);
const projectOpenning = ref();
const loadingData = ref(false);
const isShowSettingDrawer = ref(false);
const tableSettings = ref({
    sizeTable: 'large',
    showGridLines: false,
    stripedRows: true,
    paginator: true,
    dateTemplates: ['HH:mm / DD-MM-YYYY', 'HH:mm | DD/MM/YY'],
    selectDateTemplate: 'HH:mm / DD-MM-YYYY',
});
const templateTable = [
    { field: 'id', header: 'ID', sortable: true },
    { field: 'name', header: 'Name' },
    { field: 'host', header: 'Host' },
    { field: 'port', header: 'Port' },
    { field: 'handshakeHash', header: 'Handshake Hash' },
    { field: 'createdAt', header: 'Created at', isDate: true },
    { field: 'updatedAt', header: 'Updated at', isDate: true },
]

// Добавление пользовательского шаблона времени
function addDateTemplate(template) {
    tableSettings.value.dateTemplates.push(template);
    localStorage.setItem('table_projects_settings', JSON.stringify(tableSettings.value));
    toast.add({ severity: 'success', summary: 'Success!', detail: 'A new date template has been added', life: 3000 });
}

// Изменение размера таблицы
function handlerUpdateSizeTable(value) {
    if(tableSettings.value.sizeTable === value) return;
    tableSettings.value.sizeTable = value;
    localStorage.setItem('table_projects_settings', JSON.stringify(tableSettings.value));
}

// Изменение видимости сетки
function handlerUpdateShowGridLines(value) {
    tableSettings.value.showGridLines = value;
    localStorage.setItem('table_projects_settings', JSON.stringify(tableSettings.value));
}

// активация/деактивация полосатых рядов
function handlerUpdateStripedRows(value) {
    tableSettings.value.stripedRows = value;
    localStorage.setItem('table_projects_settings', JSON.stringify(tableSettings.value));
}

//  Изменение видимости пагинатора
function handlerUpdatePaginatorState(value) {
    tableSettings.value.paginator = value;
    localStorage.setItem('table_projects_settings', JSON.stringify(tableSettings.value));
}

// Изменение шаблона времени
function handlerUpdateDateTemplate(value) {
    tableSettings.value.selectDateTemplate = value;
    localStorage.setItem('table_projects_settings', JSON.stringify(tableSettings.value));
}

// Получение UI-настроек таблицы с localStorage
function getTableSettings() {
    const tableProjectsSettings = JSON.parse(localStorage.getItem('table_projects_settings'));
    // Установка UI-настроек таблицы по умолчанию в localStorage (Если ранее UI-настроек не было)
    if(!tableProjectsSettings) return localStorage.setItem('table_projects_settings', JSON.stringify(tableSettings.value));
    tableSettings.value = {
        ...tableProjectsSettings,
    }
}

onMounted(async () => {
    getTableSettings();
    try {
        loadingData.value = true;
        projects.value = await ProjectService.getProjects();
    } catch (err) {
        console.log(err)
    } finally {
        loadingData.value = false;
    }
});


</script>

<style scoped>
</style>