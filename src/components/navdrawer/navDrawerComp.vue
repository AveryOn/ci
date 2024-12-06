<template>
    <div  
    v-if="mainStore.isShowNavdrawer"
    id="navdrawer"
    class="ci-navdrawer flex justify-content-center align-items-start h-full py-3"
    @mouseenter="openNav"
    >
        <nav class="navdrawer-panel" :class="computeVisibleClass">
            <div class="flex align-items-center justify-content-between px-3">
                <h1>CI</h1>
                <div class="flex gap-2">
                    <!-- BTN CLOSE -->
                    <Button icon="pi pi-window-minimize" text severity="secondary"/>
                    <Button class="shadow-2" icon="pi pi-times" rounded/>
                </div>
            </div>
        </nav>
        <!-- <Drawer
        v-model:visible="visible" 
        header="CI"
        :modal="false"
        aria-expanded="true"
        >
            <template #header>
                <h1 class="ci-navdrawer__header text-6xl m-0">CI</h1>
            </template>

            <template #default>
                <div class="relative" style="font-family: var(--font);">
                    <PanelMenu :model="items" multiple v-model:expandedKeys="expandedKeys">
                    </PanelMenu>
                    <btn-comp 
                    class="absolute right-0" 
                    style="bottom: -40px; z-index: 99999;" 
                    :show="isShowCollapseBtn" 
                    :icon="'pi pi-minus'" 
                    @click="collapseAll"
                    ></btn-comp>
                </div>
            </template>
            <template #footer>
                <p 
                class="font-italic" 
                style="font-family: monospace; color: var(--nav-color-copyright);"
                >
                    (c) Command Interface Inc.
                </p>
            </template>
        </Drawer> -->
    </div>
</template>

<script setup>
import { ref, watch, computed } from 'vue';
import { useMainStore } from '@/stores/main';
import { useRouter } from 'vue-router';
import gsap from 'gsap';

const mainStore = useMainStore();
const router = useRouter();

/* ====================================  DATA  ================================== */
const visible = ref(false);
const menuMode = ref('expand'); // expand | collapse
const expandedKeys = ref({});
const isShowCollapseBtn = ref(false);
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
    return menuMode.value
});
// ==============================================   METHODS  =========================================

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

function openNav() {
    console.log('VISIBLE');
    
    // gsap.to('#navdrawer', { duration: 0.15, left: '-10rem' })
    //     .then(() => visible.value = true);
}
function closeNav() {
    gsap.to('#navdrawer', { duration: 0.1, left: '0rem', delay: .35 })
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
}

.ci-navdrawer__header {
    font-family: var(--font);
}
.navdrawer-panel.expand {
    position: relative;
    width: 100%;
    height: 100%;
    border: 1px solid red;
}
.navdrawer-panel.collapse {
    left: 0;
    width: 100%;
    height: 100%;
    position: absolute;
    border: 1px solid red;
}

 </style>