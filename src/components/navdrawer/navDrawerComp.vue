<template>
    <div  
    v-if="mainStore.isShowNavdrawer"
    id="navdrawer"
    class="ci-navdrawer flex justify-content-center align-items-center h-full py-3"
    :class="computeVisibleClass"
    @mouseenter="openNav"
    >
        <i 
        v-if="menuMode === 'collapse'" 
        class="pi pi-ellipsis-v my-auto absolute" 
        style="font-size: 1.5rem; color: var(--nav-bg-main) !important;"
        ></i>
        <nav class="navdrawer-panel" :class="computeVisibleClass">
            <div class="flex align-items-center justify-content-between px-2">
                <h1 class="text-5xl">CI</h1>
                <Button 
                class="shadow-2" 
                icon="pi pi-times" 
                text
                rounded
                severity="secondary"
                size="small"
                @click="toggleMode"
                />
            </div>
            <div>
                <PanelMenu :model="items" multiple v-model:expandedKeys="expandedKeys">
                </PanelMenu>
            </div>
        </nav>
    </div>
</template>

<script setup>
import { ref, watch, computed, onMounted } from 'vue';
import { useMainStore } from '@/stores/main';
import { useRouter } from 'vue-router';

const mainStore = useMainStore();
const router = useRouter();

/* ====================================  DATA  ================================== */
const visible = ref(false);
const menuMode = ref('expand'); // expand | collapse
const expandedKeys = ref({});
const isShowCollapseBtn = ref(false);
const navPanelClass = ref('collapse');
const items = ref([
    { key: null, label: 'Statistics', icon: 'pi pi-chart-bar', command: followStatistics },
    { key: null, label: 'Profile', icon: 'pi pi-user', command: followProfile },
    { key: '1', label: 'Projects', icon: 'pi pi-server', items: [
        { key: null, label: 'New Project', icon: 'pi pi-folder-plus', command: followProjectNew },
        { key: null, label: 'Project List', icon: 'pi pi-list', command: followProjectList },
    ]},
    { key: null, label: 'Tasks', icon: 'pi pi-list-check', command: followTasks },
    { key: null, label: 'Employess', icon: 'pi pi-users', command: followEmployees },
    { key: '2', label: 'Setting', icon: 'pi pi-spin pi-cog', items: [
        { key: null, label: 'Appearance', icon: 'pi pi-image', command: followAppearance },
        { key: null, label: 'Security', icon: 'pi pi-shield', command: followSecurity },
    ]},
]);

// ==============================================   COMPUTED  =========================================
const computeVisibleClass = computed(() => {
    return {
        expand: menuMode.value === 'expand',
        collapse: menuMode.value === 'collapse',
    }
});
// ==============================================   METHODS  =========================================
function openNav() {
    if(menuMode.value === 'collapse') {
        toggleMode();
    }
}

function toggleMode() {
    if(menuMode.value === 'collapse') {
        menuMode.value = 'expand';
        return void localStorage.setItem('mode_navdrawer', menuMode.value);
    }
    if (menuMode.value === 'expand') {
        menuMode.value = 'collapse';
        return void localStorage.setItem('mode_navdrawer', menuMode.value);
    }
}

function followStatistics() {
    router.push({ name: 'statistics' });
    visible.value = false;
}

function followProfile() {
    router.push({ name: 'profile' });
    visible.value = false;
}

function followProjectList() {
    router.push({ name: 'projects' });
    visible.value = false;
}

function followProjectNew() {
    router.push({ name: 'new-project' });
    visible.value = false;
}

function followTasks() {
    router.push({ name: 'tasks' });
    visible.value = false;
}

function followEmployees() {
    router.push({ name: 'employees' });
    visible.value = false;
}

function followAppearance() {
    router.push({ name: 'appearance' });
    visible.value = false;

}

function followSecurity() {
    router.push({ name: 'security' });
    visible.value = false;
}

function collapseAll() {
    expandedKeys.value = {};
    isShowCollapseBtn.value = false;
};

function initMode() {
    const mode = localStorage.getItem('mode_navdrawer');
    if(mode) {
        menuMode.value = mode;
    }
}

// =====================================   WATCH   ========================================
watch(expandedKeys, (newValue) => {
    let keys = Object.keys(newValue);
    let isFinded = false;
    keys.forEach((key) => {
        if(key !== 'null') {
            isFinded = true;
            return isShowCollapseBtn.value = true;
        }
    });
    if(isFinded === false) return isShowCollapseBtn.value = false;
});
onMounted(() => {
    initMode();
});
</script>

<style scoped>
#navdrawer {
    position: relative;
    left: 0;
}
.ci-navdrawer {
    position: relative;
    background-color: var(--nav-bg);
    width: var(--nav-width);
    transition: all .4s ease;
    overflow: hidden;
}
.ci-navdrawer.expand {
    --nav-width: 20%;
    background-color: var(--nav-bg-main);
}

.ci-navdrawer.collapse {
    --nav-width: 10px;
    background-color: var(--nav-bg-collapse-main);
}
.ci-navdrawer__header {
    font-family: var(--font);
}
.navdrawer-panel{
    position: relative;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    width: 100%;
    height: 100%;
    transition: all 0.2s ease;
    padding: 0 .6rem;
}
.navdrawer-panel.expand {
    opacity: 1;

}
.navdrawer-panel.collapse {
    opacity: 0;
}
 </style>