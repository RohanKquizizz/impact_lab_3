<template>
  <div class="dropdown-wrap">
    <button type="button" class="dropdown-trigger" @click="open = !open" ref="triggerRef">
      {{ title }}
      <span class="dropdown-arrow">{{ open ? '▲' : '▼' }}</span>
    </button>
    <div v-if="open" class="dropdown-menu" ref="menuRef">
      <button
        v-for="item in items"
        :key="item.value"
        type="button"
        :class="['dropdown-item', { selected: item.selected }]"
        @click="select(item.value)"
      >
        {{ item.title }}
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

interface DropdownItem {
  value: string
  title: string
  selected?: boolean
}

const props = withDefaults(
  defineProps<{
    title: string
    items: DropdownItem[]
    size?: string
    menuWidth?: string
    textOnly?: boolean
    width?: string
    fullWidth?: boolean
  }>(),
  { size: 'md', menuWidth: 'md', textOnly: false, width: 'auto', fullWidth: false }
)

const emit = defineEmits<{ selected: [payload: { selectedValue: string }] }>()

const open = ref(false)
const triggerRef = ref<HTMLElement | null>(null)
const menuRef = ref<HTMLElement | null>(null)

function select(value: string) {
  emit('selected', { selectedValue: value })
  open.value = false
}

function onClickOutside(e: MouseEvent) {
  const el = e.target as Node
  if (
    triggerRef.value?.contains(el) ||
    menuRef.value?.contains(el)
  )
    return
  open.value = false
}

onMounted(() => {
  document.addEventListener('click', onClickOutside)
})
onUnmounted(() => {
  document.removeEventListener('click', onClickOutside)
})
</script>

<style scoped>
.dropdown-wrap {
  position: relative;
  display: inline-block;
}
.dropdown-trigger {
  padding: 0.5rem 0.75rem;
  font-size: inherit;
  font-weight: 600;
  background: transparent;
  border: 1px solid rgba(255,255,255,0.3);
  border-radius: 8px;
  color: inherit;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
}
.dropdown-arrow {
  font-size: 0.65em;
  opacity: 0.8;
}
.dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  margin-top: 4px;
  min-width: 180px;
  background: #27272a;
  border: 1px solid #3f3f46;
  border-radius: 8px;
  padding: 0.5rem;
  z-index: 50;
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
}
.dropdown-item {
  display: block;
  width: 100%;
  padding: 0.5rem 0.75rem;
  text-align: left;
  font-size: 0.9rem;
  background: none;
  border: none;
  border-radius: 6px;
  color: #e4e4e7;
  cursor: pointer;
}
.dropdown-item:hover {
  background: #3f3f46;
}
.dropdown-item.selected {
  background: #3b82f6;
  color: #fff;
}
</style>
