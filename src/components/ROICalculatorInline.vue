<template>
  <div class="roi-calculator-inline">
    <!-- Form and Live Calculator Combined -->
    <div class="calculator-container">
      <!-- Input Section -->
      <div class="input-section">
        <h3 class="subsection-title">School Details</h3>

        <div class="input-grid">
          <div class="input-field">
            <label>Number of Teachers</label>
            <input
              v-model="numberOfTeachersStr"
              type="text"
              placeholder="50"
              class="text-input"
            />
          </div>
          <div class="input-field">
            <label>Number of Students</label>
            <input
              v-model="numberOfStudentsStr"
              type="text"
              placeholder="1200"
              class="text-input"
            />
          </div>
        </div>

        <div class="checkbox-section">
          <label class="checkbox-label">Grade Levels</label>
          <div class="checkbox-grid">
            <label
              v-for="level in GRADE_LEVELS"
              :key="level"
              class="checkbox-item"
            >
              <input
                type="checkbox"
                :value="level"
                :checked="formData.gradeLevel.includes(level)"
                @change="handleGradeLevelToggle(level, ($event.target as HTMLInputElement).checked)"
              />
              <span>{{ level }}</span>
            </label>
          </div>
        </div>

        <div class="checkbox-section">
          <label class="checkbox-label">Subjects</label>
          <div class="checkbox-grid">
            <label
              v-for="subject in SUBJECTS"
              :key="subject"
              class="checkbox-item"
            >
              <input
                type="checkbox"
                :value="subject"
                :checked="formData.subjects.includes(subject)"
                @change="handleSubjectToggle(subject, ($event.target as HTMLInputElement).checked)"
              />
              <span>{{ subject }}</span>
            </label>
          </div>
        </div>
      </div>

      <!-- Tool Selection - Fancy Cards -->
      <div class="tools-section">
        <h3 class="tools-title">Which Tools Are You Currently Using?</h3>
        <p class="tools-subtitle">
          Select all that apply - we'll show you how much you can save by consolidating
        </p>

        <div class="tool-cards-grid">
          <div
            v-for="tool in CURRENT_TOOLS"
            :key="tool"
            :class="['tool-card', { 'tool-card--selected': formData.currentTools.includes(tool) }]"
            @click="handleToolCardClick(tool)"
          >
            <div class="tool-icon">{{ getToolIcon(tool) }}</div>
            <div class="tool-name">{{ tool }}</div>
            <div v-if="getToolPrice(tool) > 0" class="tool-price">
              ~${{ getToolPrice(tool) }}/teacher/yr
            </div>
            <div v-else class="tool-price tool-price--free">Free</div>
            <div v-if="formData.currentTools.includes(tool)" class="selection-badge">✓</div>
          </div>
        </div>

        <div v-if="formData.currentTools.length > 0" class="tools-selected-count">
          ✓ {{ formData.currentTools.length }} tool{{ formData.currentTools.length > 1 ? 's' : '' }} selected
        </div>
      </div>

      <!-- Live Savings Display -->
      <div v-if="isFormComplete" class="savings-display">
        <div class="savings-header">
          <h3 class="savings-title">Your Estimated Annual Savings</h3>
          <p class="savings-subtitle">Live calculation based on your inputs</p>
        </div>

        <div class="savings-grid">
          <div class="savings-card">
            <div class="savings-label">Time Value Savings</div>
            <div class="savings-value">
              <span class="currency">$</span>
              <AnimatedNumber :value="estimatedSavings.timeSavings" />
            </div>
            <div class="savings-detail">{{ Math.round(hoursPerWeek) }} hours/week saved</div>
          </div>

          <div v-if="estimatedSavings.consolidationSavings > 0" class="savings-card savings-card--consolidation">
            <div class="savings-label">Tool Consolidation Savings</div>
            <div class="savings-value savings-value--consolidation">
              <span class="currency">$</span>
              <AnimatedNumber :value="estimatedSavings.consolidationSavings" />
            </div>
            <div class="savings-detail">From {{ formData.currentTools.length }} tools → 1 platform</div>
          </div>

          <div class="savings-card savings-card--total">
            <div class="savings-label">Total Annual Impact</div>
            <div class="savings-value savings-value--total">
              <span class="currency">$</span>
              <AnimatedNumber :value="estimatedSavings.totalSavings" />
            </div>
            <div class="savings-detail">Plus simplified vendor management</div>
          </div>
        </div>
      </div>

      <div v-else class="incomplete-message">
        <div class="incomplete-icon">📊</div>
        <p>Complete the fields above to see your personalized savings estimate</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, watch, onMounted, defineComponent, h } from 'vue';

// Animated Number Component
const AnimatedNumber = defineComponent({
  name: 'AnimatedNumber',
  props: {
    value: {
      type: Number,
      required: true,
    },
  },
  setup(props) {
    const displayValue = ref(props.value);
    const animationFrame = ref<number | null>(null);

    watch(() => props.value, (newValue, oldValue) => {
      if (animationFrame.value) {
        cancelAnimationFrame(animationFrame.value);
      }

      // If the difference is too small or it's the initial load, just set it
      if (Math.abs(newValue - oldValue) < 10 || oldValue === 0) {
        displayValue.value = newValue;
        return;
      }

      const duration = 600; // ms
      const start = performance.now();
      const difference = newValue - oldValue;

      const animate = (currentTime: number) => {
        const elapsed = currentTime - start;
        const progress = Math.min(elapsed / duration, 1);

        // Easing function (ease-out cubic)
        const easeOut = 1 - Math.pow(1 - progress, 3);

        displayValue.value = Math.round(oldValue + (difference * easeOut));

        if (progress < 1) {
          animationFrame.value = requestAnimationFrame(animate);
        }
      };

      animationFrame.value = requestAnimationFrame(animate);
    });

    // Set initial value
    onMounted(() => {
      displayValue.value = props.value;
    });

    return () => h('span', { class: 'animated-number' }, displayValue.value.toLocaleString());
  },
});

interface SchoolFormData {
  schoolName: string;
  numberOfTeachers: number;
  numberOfStudents: number;
  gradeLevel: string[];
  subjects: string[];
  currentTools: string[];
  primaryChallenge: string;
  budget?: number;
}

const GRADE_LEVELS = ['K-5', '6-8', '9-12'];
const SUBJECTS = ['Math', 'Science', 'English', 'Social Studies', 'Other'];
const CURRENT_TOOLS = ['Kahoot', 'Kami', 'Nearpod', 'Edpuzzle'];

const formData = reactive<SchoolFormData>({
  schoolName: 'Lincoln High School',
  numberOfTeachers: 0,
  numberOfStudents: 0,
  gradeLevel: [],
  subjects: [],
  currentTools: ['Kahoot', 'Kami'],
  primaryChallenge: '',
  budget: undefined,
});

const numberOfTeachersStr = ref('');
const numberOfStudentsStr = ref('');

// Watch string inputs and convert to numbers
watch(numberOfTeachersStr, (val) => {
  const num = parseInt(val, 10);
  formData.numberOfTeachers = isNaN(num) ? 0 : num;
});

watch(numberOfStudentsStr, (val) => {
  const num = parseInt(val, 10);
  formData.numberOfStudents = isNaN(num) ? 0 : num;
});

const isFormComplete = computed(() => {
  return (
    formData.numberOfTeachers > 0 &&
    formData.numberOfStudents > 0 &&
    formData.gradeLevel.length > 0 &&
    formData.subjects.length > 0
  );
});

const hoursPerWeek = computed(() => formData.numberOfTeachers * 2.5);

const estimatedSavings = computed(() => {
  const teachers = formData.numberOfTeachers || 0;
  const hoursPerWeek = teachers * 2.5;
  const weeksPerYear = 36;
  const hourlyValue = 35;

  const timeSavings = Math.round(hoursPerWeek * weeksPerYear * hourlyValue);

  const toolPricing: Record<string, number> = {
    'kahoot': 60,
    'kami': 70,
    'nearpod': 80,
    'edpuzzle': 85,
  };

  const consolidationSavings = formData.currentTools.reduce((total, tool) => {
    const toolKey = tool.toLowerCase();
    const cost = toolPricing[toolKey] || 0;
    return total + cost * teachers;
  }, 0);

  return {
    timeSavings,
    consolidationSavings,
    totalSavings: timeSavings + consolidationSavings,
  };
});

function handleGradeLevelToggle(level: string, checked: boolean) {
  if (checked) {
    if (!formData.gradeLevel.includes(level)) {
      formData.gradeLevel.push(level);
    }
  } else {
    formData.gradeLevel = formData.gradeLevel.filter(l => l !== level);
  }
}

function handleSubjectToggle(subject: string, checked: boolean) {
  if (checked) {
    if (!formData.subjects.includes(subject)) {
      formData.subjects.push(subject);
    }
  } else {
    formData.subjects = formData.subjects.filter(s => s !== subject);
  }
}

function handleToolCardClick(tool: string) {
  if (formData.currentTools.includes(tool)) {
    formData.currentTools = formData.currentTools.filter(t => t !== tool);
  } else {
    formData.currentTools.push(tool);
  }
}

function getToolIcon(toolName: string): string {
  const iconMap: Record<string, string> = {
    'kahoot': '🎮',
    'kami': '✏️',
    'nearpod': '📊',
    'edpuzzle': '🎬',
  };
  return iconMap[toolName.toLowerCase()] || '📱';
}

function getToolPrice(toolName: string): number {
  const pricingMap: Record<string, number> = {
    'kahoot': 60,
    'kami': 70,
    'nearpod': 80,
    'edpuzzle': 85,
  };
  return pricingMap[toolName.toLowerCase()] || 0;
}
</script>

<style scoped>
.roi-calculator-inline {
  width: 100%;
  background: white;
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

.calculator-container {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

/* Input Section */
.input-section {
  background: #f9fafb;
  padding: 20px;
  border-radius: 12px;
  border: 1px solid #e5e7eb;
}

.subsection-title {
  font-size: 1rem;
  font-weight: 600;
  color: #374151;
  margin: 0 0 16px 0;
}

.input-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
  margin-bottom: 16px;
}

.input-field {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.input-field label {
  font-size: 0.875rem;
  font-weight: 500;
  color: #6b7280;
}

.text-input {
  padding: 10px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 1rem;
  transition: all 0.2s;
  background: white;
}

.text-input:focus {
  outline: none;
  border-color: #8b5cf6;
  box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
}

.checkbox-section {
  margin-top: 16px;
}

.checkbox-label {
  font-size: 0.875rem;
  font-weight: 500;
  color: #6b7280;
  display: block;
  margin-bottom: 8px;
}

.checkbox-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.checkbox-item {
  display: flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  user-select: none;
}

.checkbox-item input[type="checkbox"] {
  width: 18px;
  height: 18px;
  cursor: pointer;
  accent-color: #8b5cf6;
}

.checkbox-item span {
  font-size: 0.875rem;
  color: #374151;
}

/* Tools Section */
.tools-section {
  background: linear-gradient(135deg, #f3e8ff 0%, #e0f2fe 50%, #ffe5f1 100%);
  padding: 24px;
  border-radius: 16px;
  border: 2px solid rgba(139, 92, 246, 0.3);
  position: relative;
  overflow: hidden;
}

.tools-section::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.4) 0%, transparent 70%);
  animation: shimmer 3s ease-in-out infinite;
  pointer-events: none;
}

@keyframes shimmer {
  0%, 100% {
    transform: translate(0, 0);
  }
  50% {
    transform: translate(20px, 20px);
  }
}

.tools-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1f2937;
  margin: 0 0 8px 0;
  text-align: center;
  position: relative;
  z-index: 1;
}

.tools-subtitle {
  font-size: 0.875rem;
  color: #6b7280;
  text-align: center;
  margin: 0 0 20px 0;
  position: relative;
  z-index: 1;
}

.tool-cards-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 12px;
  position: relative;
  z-index: 1;
}

.tool-card {
  background: rgba(255, 255, 255, 0.9);
  border: 2px solid rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  padding: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  position: relative;
  backdrop-filter: blur(10px);
}

.tool-card:hover {
  transform: translateY(-8px) scale(1.05);
  box-shadow: 0 12px 24px rgba(139, 92, 246, 0.3);
  border-color: rgba(139, 92, 246, 0.4);
}

.tool-card--selected {
  background: linear-gradient(135deg, #ffffff 0%, #f3e8ff 100%);
  border: 3px solid #8b5cf6;
  box-shadow: 0 8px 16px rgba(139, 92, 246, 0.4);
  transform: translateY(-4px);
}

.tool-card--selected:hover {
  transform: translateY(-10px) scale(1.05);
}

.tool-icon {
  font-size: 36px;
  line-height: 1;
}

.tool-name {
  font-size: 0.875rem;
  font-weight: 600;
  color: #1f2937;
  text-align: center;
}

.tool-card--selected .tool-name {
  color: #8b5cf6;
}

.tool-price {
  font-size: 0.75rem;
  color: #6b7280;
}

.tool-card--selected .tool-price {
  color: #8b5cf6;
}

.tool-price--free {
  color: #10b981;
  font-weight: 600;
}

.selection-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  width: 24px;
  height: 24px;
  background: #10b981;
  border-radius: 50%;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: bold;
  animation: popIn 0.3s ease-out;
}

@keyframes popIn {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}

.tools-selected-count {
  text-align: center;
  font-size: 1rem;
  font-weight: 700;
  color: #8b5cf6;
  padding: 12px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 8px;
  position: relative;
  z-index: 1;
  margin-top: 20px;
  animation: fadeInUp 0.4s ease-out;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Savings Display */
.savings-display {
  background: linear-gradient(135deg, #d3f5e8 0%, #d9eeff 100%);
  padding: 24px;
  border-radius: 16px;
  border: 2px solid rgba(45, 106, 79, 0.3);
  animation: slideIn 0.5s ease-out;
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.savings-header {
  text-align: center;
  margin-bottom: 20px;
}

.savings-title {
  font-size: 1.5rem;
  font-weight: 800;
  color: #1f2937;
  margin: 0 0 4px 0;
}

.savings-subtitle {
  font-size: 0.875rem;
  color: #6b7280;
  margin: 0;
}

.savings-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
}

.savings-card {
  background: rgba(255, 255, 255, 0.9);
  padding: 20px;
  border-radius: 12px;
  border: 2px solid rgba(45, 106, 79, 0.2);
  text-align: center;
  transition: all 0.3s ease;
}

.savings-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.savings-card--consolidation {
  border-color: rgba(217, 70, 166, 0.3);
}

.savings-card--total {
  border: 3px solid #8b5cf6;
  background: linear-gradient(135deg, #ffffff 0%, #f3e8ff 100%);
}

.savings-label {
  font-size: 0.75rem;
  font-weight: 600;
  color: #6b7280;
  margin-bottom: 8px;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.savings-value {
  font-size: 2rem;
  font-weight: 800;
  color: #2d6a4f;
  line-height: 1;
  margin-bottom: 4px;
  display: flex;
  align-items: baseline;
  gap: 4px;
}

.savings-value .currency {
  font-size: 1.5rem;
  opacity: 0.8;
}

.savings-value .animated-number {
  font-variant-numeric: tabular-nums;
  display: inline-block;
  min-width: 1ch;
  transition: color 0.3s ease;
}

@keyframes valueChange {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-2px);
  }
}

.savings-value--consolidation {
  color: #d946a6;
}

.savings-value--total {
  font-size: 2.5rem;
  color: #8b5cf6;
}

.savings-value--total .currency {
  font-size: 2rem;
}

.savings-detail {
  font-size: 0.75rem;
  color: #9ca3af;
}

/* Incomplete Message */
.incomplete-message {
  text-align: center;
  padding: 40px 20px;
  background: #f9fafb;
  border-radius: 12px;
  border: 2px dashed #d1d5db;
}

.incomplete-icon {
  font-size: 48px;
  margin-bottom: 12px;
}

.incomplete-message p {
  font-size: 0.875rem;
  color: #6b7280;
  margin: 0;
}

/* Responsive */
@media (max-width: 768px) {
  .input-grid,
  .tool-cards-grid,
  .savings-grid {
    grid-template-columns: 1fr;
  }
}
</style>
