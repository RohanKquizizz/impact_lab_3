<template>
  <div class="teacher-workflows">
    <header class="workflows-header">
      <h2 class="workflows-title">
        <span class="title-text">How</span>
        <div class="dropdown-wrapper">
          <Dropdown
            title="Math Teachers"
            :items="dropdownItems"
            size="lg"
            menuWidth="md"
            textOnly
            width="auto"
            :fullWidth="false"
            @selected="handleRoleSelect"
          />
        </div>
        <span class="title-text">Use Wayground</span>
      </h2>
    </header>

    <div class="workflow-cards">
      <div
        v-for="card in currentCards"
        :key="card.title"
        class="workflow-card"
      >
        <div class="card-content">
          <h3 class="card-title">{{ card.title }}</h3>
          <p class="card-description">{{ card.description }}</p>
        </div>
        
        <div class="card-preview">
          <!-- Standard Alignment Preview -->
          <template v-if="card.previewType === 'standards'">
            <div class="preview-standards">
              <div class="standards-header">TEKS</div>
              <div class="standards-badge">
                <span class="badge-icon">⚙️</span>
                <span class="badge-text">TEKS.7.10A</span>
              </div>
              <div class="standards-arrow">↓</div>
              <div class="standards-teacher">Teacher</div>
            </div>
          </template>
          
          <!-- Question Types Preview -->
          <template v-else-if="card.previewType === 'questions'">
            <div class="preview-questions">
              <div class="question-item">
                <span class="question-icon">📈</span>
                <span class="question-text">Graphing</span>
              </div>
              <div class="question-item">
                <span class="question-icon">𝑓(𝑥)</span>
                <span class="question-text">Math response</span>
              </div>
            </div>
          </template>
          
          <!-- Common Assessments Preview -->
          <template v-else-if="card.previewType === 'assessments'">
            <div class="preview-assessments">
              <div class="assessment-header">
                <span class="assessment-icon">📊</span>
                <span>District Overview</span>
              </div>
              <div class="assessment-stat">
                <span class="stat-value">78%</span>
                <span class="stat-label">accuracy</span>
              </div>
              <div class="assessment-bar">
                <div class="bar-segment bar-red" style="width: 5%"></div>
                <div class="bar-segment bar-orange" style="width: 15%"></div>
                <div class="bar-segment bar-yellow" style="width: 60%"></div>
                <div class="bar-segment bar-green" style="width: 20%"></div>
              </div>
              <div class="assessment-footer">
                <span class="footer-icon">🏫</span>
                <span>School</span>
              </div>
            </div>
          </template>
          
          <!-- VoyageMath Preview -->
          <template v-else-if="card.previewType === 'voyage'">
            <div class="preview-voyage">
              <div class="voyage-header">
                <span class="voyage-logo">VoyageMath</span>
                <span class="voyage-pin">📍</span>
              </div>
              <div class="voyage-problem">
                <div class="problem-equation">6x - 9 = 24</div>
                <div class="problem-step">
                  <span class="step-label">✨ StepGuide</span>
                </div>
                <div class="step-detail">
                  <span class="step-check">✓</span>
                  <span>STEP 1: Add 9 to both sides</span>
                </div>
                <div class="step-equation">6x - 9 <span class="highlight">+ 9</span> = 24 <span class="highlight">+ 9</span></div>
              </div>
            </div>
          </template>
          
          <!-- Reports Preview -->
          <template v-else-if="card.previewType === 'reports'">
            <div class="preview-reports">
              <div class="report-row">
                <div class="report-avatar">👩</div>
                <span class="report-name">Sarah</span>
                <div class="report-bars">
                  <div class="report-bar bar-green" style="width: 70%"></div>
                  <div class="report-bar bar-red" style="width: 15%"></div>
                </div>
              </div>
              <div class="report-row">
                <div class="report-avatar">👨</div>
                <span class="report-name">Karan</span>
                <div class="report-bars">
                  <div class="report-bar bar-green" style="width: 85%"></div>
                  <div class="report-bar bar-red" style="width: 5%"></div>
                </div>
              </div>
            </div>
          </template>
          
          <!-- Anti-Cheating Preview -->
          <template v-else-if="card.previewType === 'anticheating'">
            <div class="preview-anticheating">
              <div class="toggle-row">
                <span class="toggle-icon">Aa</span>
                <span class="toggle-label">Anti-cheating</span>
                <div class="toggle-switch on"></div>
              </div>
              <div class="toggle-row">
                <span class="toggle-icon">🤖</span>
                <span class="toggle-label">Prevent use of AI app</span>
                <div class="toggle-switch on"></div>
              </div>
            </div>
          </template>
          
          <!-- Resource Bundles Preview (Science) -->
          <template v-else-if="card.previewType === 'resources'">
            <div class="preview-resources">
              <div class="resource-grid">
                <div class="resource-item">
                  <span class="resource-text">Passages</span>
                  <span class="resource-icon resource-purple">📄</span>
                </div>
                <div class="resource-item">
                  <span class="resource-text">Presentations</span>
                  <span class="resource-icon resource-green">📊</span>
                </div>
                <div class="resource-item">
                  <span class="resource-text">Assessments</span>
                  <span class="resource-icon resource-teal">✓</span>
                </div>
                <div class="resource-item">
                  <span class="resource-text">Interactive Videos</span>
                  <span class="resource-icon resource-blue">▶</span>
                </div>
              </div>
            </div>
          </template>
          
          <!-- Desmos Calculator Preview (Science) -->
          <template v-else-if="card.previewType === 'desmos'">
            <div class="preview-desmos">
              <div class="desmos-equation">x² + 2xy + y²</div>
              <div class="desmos-brand">
                <span class="desmos-powered">POWERED BY</span>
                <span class="desmos-logo">desmos</span>
              </div>
              <div class="desmos-keypad">
                <div class="keypad-row">
                  <span class="key key-func">a²</span>
                  <span class="key key-func">aᵇ</span>
                  <span class="key key-func">|a|</span>
                  <span class="key key-num">7</span>
                  <span class="key key-num">8</span>
                  <span class="key key-num">9</span>
                </div>
                <div class="keypad-row">
                  <span class="key key-op">√</span>
                  <span class="key key-op">√</span>
                  <span class="key key-op">π</span>
                  <span class="key key-num">4</span>
                  <span class="key key-num">5</span>
                  <span class="key key-num">6</span>
                </div>
                <div class="keypad-row">
                  <span class="key key-trig">sin</span>
                  <span class="key key-trig">cos</span>
                  <span class="key key-trig">tan</span>
                  <span class="key key-num">1</span>
                  <span class="key key-num">2</span>
                  <span class="key key-num">3</span>
                </div>
                <div class="keypad-row">
                  <span class="key key-paren">(</span>
                  <span class="key key-paren">)</span>
                  <span class="key key-dot">.</span>
                  <span class="key key-num">0</span>
                  <span class="key key-dot">.</span>
                  <span class="key key-equals">=</span>
                </div>
              </div>
            </div>
          </template>
          
          <!-- PhET Simulation Preview (Science) -->
          <template v-else-if="card.previewType === 'phet'">
            <div class="preview-phet">
              <div class="phet-header">
                <span class="phet-logo">PhET</span>
                <span class="phet-title">Waves Intro</span>
                <div class="phet-icons">
                  <span>🔊</span>
                  <span>💡</span>
                </div>
              </div>
              <div class="phet-tabs">
                <span class="phet-tab active">Water</span>
              </div>
              <div class="phet-simulation">
                <div class="wave-visual">
                  <div class="water-drops">
                    <span class="drop">💧</span>
                    <span class="drop">💧</span>
                    <span class="drop">💧</span>
                  </div>
                  <div class="wave-lines"></div>
                </div>
              </div>
            </div>
          </template>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { Dropdown } from 'quizizz-ui';

interface WorkflowCard {
  title: string;
  description: string;
  previewType: string;
}

const selectedRole = ref('math');

const dropdownItems = computed(() => [
  { value: 'math', title: 'Math Teachers', selected: selectedRole.value === 'math' },
  { value: 'science', title: 'Science Teachers', selected: selectedRole.value === 'science' },
]);

function handleRoleSelect({ selectedValue }: { selectedValue: string }) {
  selectedRole.value = selectedValue;
}

const mathCards: WorkflowCard[] = [
  {
    title: 'Standard Alignment',
    description: 'Content aligned to Texas standards and your district curriculum for consistent instruction',
    previewType: 'standards',
  },
  {
    title: 'Question types',
    description: 'Math response, graphing, labelling and other features for deeper understanding',
    previewType: 'questions',
  },
  {
    title: 'Common Assessments',
    description: 'Department-wide assessments with consistent scoring and comparative analysis across',
    previewType: 'assessments',
  },
  {
    title: 'VoyageMath',
    description: 'Adaptive math learning pathways that meet students where they are and accelerate growth',
    previewType: 'voyage',
  },
  {
    title: 'Reports',
    description: 'Longitudinal reports tracking student growth over time with actionable insights',
    previewType: 'reports',
  },
  {
    title: 'Anti-cheating',
    description: 'Built-in features to ensure assessment integrity and authentic student response',
    previewType: 'anticheating',
  },
];

const scienceCards: WorkflowCard[] = [
  {
    title: 'Resource bundles',
    description: 'High-quality resources across all types, aligned to each specific skill',
    previewType: 'resources',
  },
  {
    title: 'Common Assessments',
    description: 'Department-wide assessments with consistent scoring and comparison',
    previewType: 'assessments',
  },
  {
    title: 'Texas adapted desmos calculator',
    description: 'A Texas-compliant Desmos calculator for assessments and instruction',
    previewType: 'desmos',
  },
  {
    title: 'Phet simulation',
    description: 'Interactive simulations that help students explore concepts visually',
    previewType: 'phet',
  },
  {
    title: 'Reports',
    description: 'Clear reports to track student growth over time',
    previewType: 'reports',
  },
  {
    title: 'Anti-cheating',
    description: 'Built-in controls to ensure fair and authentic assessments',
    previewType: 'anticheating',
  },
];

const currentCards = computed(() => selectedRole.value === 'science' ? scienceCards : mathCards);
</script>

<style scoped>
.teacher-workflows {
  padding: 2rem;
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

.workflows-header {
  text-align: center;
  margin-bottom: 2rem;
}

.workflows-title {
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 2rem;
  font-weight: 600;
  color: #1E3A5F;
  margin: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.title-text {
  color: #1E3A5F;
}

.dropdown-wrapper {
  display: inline-flex;
  flex-shrink: 0;
}

.dropdown-wrapper :deep(button) {
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 2rem;
  font-weight: 600;
}

.dropdown-wrapper :deep([data-testid="dropdown-box"]) {
  border-bottom: 2px dashed #00B4A0 !important;
  border-radius: 0 !important;
  padding: 0 0.25rem !important;
  background: transparent !important;
}

.dropdown-wrapper :deep([data-testid="dropdown-box"]:hover) {
  border-bottom-style: solid !important;
}

.workflow-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
  max-width: 1200px;
  margin: 0 auto;
}

.workflow-card {
  background: #ffffff;
  border-radius: 16px;
  border: 1px solid rgba(0, 0, 0, 0.08);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.workflow-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.card-content {
  padding: 1.5rem 1.5rem 1rem;
  text-align: center;
}

.card-title {
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 1.25rem;
  font-weight: 600;
  color: #1E3A5F;
  margin: 0 0 0.5rem;
}

.card-description {
  font-size: 0.875rem;
  color: #6B7C93;
  line-height: 1.5;
  margin: 0;
}

.card-preview {
  background: #F3E8FF;
  padding: 1.25rem;
  margin-top: auto;
  height: 180px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Standards Preview */
.preview-standards {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.standards-header {
  font-weight: 600;
  color: #1E3A5F;
  font-size: 0.9rem;
}

.standards-badge {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  background: white;
  padding: 0.4rem 0.75rem;
  border-radius: 20px;
  border: 2px solid #E91E63;
  font-size: 0.8rem;
  font-weight: 600;
  color: #E91E63;
}

.badge-icon {
  font-size: 0.9rem;
}

.standards-arrow {
  color: #E91E63;
  font-size: 1.25rem;
}

.standards-teacher {
  background: #E91E63;
  color: white;
  padding: 0.35rem 1rem;
  border-radius: 4px;
  font-size: 0.8rem;
  font-weight: 500;
}

/* Questions Preview */
.preview-questions {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  width: 100%;
  max-width: 180px;
}

.question-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  background: white;
  padding: 0.6rem 1rem;
  border-radius: 8px;
  font-size: 0.85rem;
  color: #1E3A5F;
}

.question-icon {
  font-size: 1rem;
  width: 24px;
  text-align: center;
}

/* Assessments Preview */
.preview-assessments {
  background: white;
  border-radius: 8px;
  padding: 0.75rem;
  width: 100%;
  max-width: 200px;
}

.assessment-header {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  font-size: 0.75rem;
  color: #6B7C93;
  margin-bottom: 0.25rem;
}

.assessment-icon {
  font-size: 0.8rem;
}

.assessment-stat {
  margin-bottom: 0.5rem;
}

.stat-value {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1E3A5F;
}

.stat-label {
  font-size: 0.7rem;
  color: #9ca3af;
  margin-left: 0.25rem;
}

.assessment-bar {
  display: flex;
  height: 8px;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 0.5rem;
}

.bar-segment {
  height: 100%;
}

.bar-red { background: #ef4444; }
.bar-orange { background: #f97316; }
.bar-yellow { background: #eab308; }
.bar-green { background: #22c55e; }

.assessment-footer {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  font-size: 0.75rem;
  color: #6B7C93;
}

.footer-icon {
  font-size: 0.8rem;
}

/* Voyage Preview */
.preview-voyage {
  background: white;
  border-radius: 8px;
  padding: 0.75rem;
  width: 100%;
  max-width: 200px;
  font-size: 0.75rem;
}

.voyage-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
}

.voyage-logo {
  font-weight: 700;
  color: #00B4A0;
  font-size: 0.85rem;
}

.voyage-problem {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}

.problem-equation {
  background: #E8F5F3;
  padding: 0.35rem 0.5rem;
  border-radius: 4px;
  font-weight: 600;
  color: #1E3A5F;
}

.problem-step {
  display: flex;
  align-items: center;
  gap: 0.25rem;
}

.step-label {
  color: #00B4A0;
  font-weight: 600;
}

.step-detail {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  color: #6B7C93;
}

.step-check {
  color: #22c55e;
}

.step-equation {
  color: #1E3A5F;
}

.step-equation .highlight {
  color: #00B4A0;
  font-weight: 600;
}

/* Reports Preview */
.preview-reports {
  background: white;
  border-radius: 8px;
  padding: 0.75rem;
  width: 100%;
  max-width: 200px;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.report-row {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.report-avatar {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: #f3f4f6;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.75rem;
}

.report-name {
  font-size: 0.75rem;
  color: #6B7C93;
  width: 40px;
}

.report-bars {
  display: flex;
  gap: 2px;
  flex: 1;
}

.report-bar {
  height: 16px;
  border-radius: 2px;
}

.report-bar.bar-green { background: #22c55e; }
.report-bar.bar-red { background: #ef4444; }

/* Anti-cheating Preview */
.preview-anticheating {
  background: white;
  border-radius: 8px;
  padding: 0.75rem;
  width: 100%;
  max-width: 200px;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.toggle-row {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.toggle-icon {
  font-size: 0.85rem;
  width: 20px;
  color: #6B7C93;
}

.toggle-label {
  font-size: 0.8rem;
  color: #1E3A5F;
  flex: 1;
}

.toggle-switch {
  width: 36px;
  height: 20px;
  background: #d1d5db;
  border-radius: 10px;
  position: relative;
}

.toggle-switch::after {
  content: '';
  position: absolute;
  width: 16px;
  height: 16px;
  background: white;
  border-radius: 50%;
  top: 2px;
  left: 2px;
  transition: transform 0.2s;
}

.toggle-switch.on {
  background: #22c55e;
}

.toggle-switch.on::after {
  transform: translateX(16px);
}

/* Resource Bundles Preview (Science) */
.preview-resources {
  width: 100%;
  max-width: 240px;
}

.resource-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 0.5rem;
}

.resource-item {
  background: white;
  border-radius: 6px;
  padding: 0.5rem 0.75rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 0.75rem;
  color: #1E3A5F;
  border: 1px solid #e5e7eb;
}

.resource-text {
  font-weight: 500;
}

.resource-icon {
  width: 24px;
  height: 24px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.7rem;
}

.resource-icon.resource-purple {
  background: #8B5CF6;
  color: white;
}

.resource-icon.resource-green {
  background: #22C55E;
  color: white;
}

.resource-icon.resource-teal {
  background: #14B8A6;
  color: white;
}

.resource-icon.resource-blue {
  background: #3B82F6;
  color: white;
}

/* Desmos Calculator Preview (Science) */
.preview-desmos {
  background: white;
  border-radius: 8px;
  padding: 0.75rem;
  width: 100%;
  max-width: 200px;
}

.desmos-equation {
  font-size: 1rem;
  font-style: italic;
  color: #1E3A5F;
  text-align: center;
  margin-bottom: 0.5rem;
  font-family: 'Times New Roman', serif;
}

.desmos-brand {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  margin-bottom: 0.5rem;
}

.desmos-powered {
  font-size: 0.5rem;
  color: #9ca3af;
  letter-spacing: 0.5px;
}

.desmos-logo {
  font-size: 0.9rem;
  font-weight: 700;
  color: #22C55E;
}

.desmos-keypad {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.keypad-row {
  display: flex;
  gap: 2px;
}

.key {
  width: 24px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.6rem;
  border-radius: 2px;
  font-weight: 500;
}

.key-func {
  background: #8B5CF6;
  color: white;
}

.key-op {
  background: #8B5CF6;
  color: white;
}

.key-trig {
  background: #8B5CF6;
  color: white;
}

.key-num {
  background: #374151;
  color: white;
}

.key-paren {
  background: #22C55E;
  color: white;
}

.key-dot {
  background: #374151;
  color: white;
}

.key-equals {
  background: #374151;
  color: white;
}

/* PhET Simulation Preview (Science) */
.preview-phet {
  background: #1E3A5F;
  border-radius: 8px;
  padding: 0.5rem;
  width: 100%;
  max-width: 200px;
  color: white;
}

.phet-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.35rem;
}

.phet-logo {
  background: #F59E0B;
  color: #1E3A5F;
  font-weight: 700;
  font-size: 0.7rem;
  padding: 0.15rem 0.35rem;
  border-radius: 3px;
}

.phet-title {
  font-size: 0.75rem;
  font-weight: 500;
  flex: 1;
}

.phet-icons {
  display: flex;
  gap: 0.25rem;
  font-size: 0.7rem;
}

.phet-tabs {
  margin-bottom: 0.35rem;
}

.phet-tab {
  background: #14B8A6;
  color: white;
  font-size: 0.65rem;
  padding: 0.2rem 0.5rem;
  border-radius: 4px 4px 0 0;
}

.phet-simulation {
  background: #87CEEB;
  border-radius: 4px;
  padding: 0.5rem;
  min-height: 60px;
}

.wave-visual {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.water-drops {
  display: flex;
  gap: 0.5rem;
  font-size: 0.8rem;
}

.wave-lines {
  width: 100%;
  height: 20px;
  background: repeating-linear-gradient(
    90deg,
    transparent,
    transparent 5px,
    rgba(20, 184, 166, 0.5) 5px,
    rgba(20, 184, 166, 0.5) 10px
  );
  border-radius: 50%;
  margin-top: 0.25rem;
}

@media (max-width: 900px) {
  .workflow-cards {
    grid-template-columns: 1fr;
    max-width: 500px;
  }
}
</style>
