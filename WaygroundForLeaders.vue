<template>
  <div class="wayground-leaders">
    <!-- Tabs -->
    <div class="tabs-container">
      <button
        v-for="tab in tabs"
        :key="tab.id"
        :class="['tab-button', { active: selectedTab === tab.id }, `tab-${tab.id}`]"
        @click="selectedTab = tab.id"
      >
        {{ tab.label }}
      </button>
    </div>

    <!-- Content Area -->
    <div :class="['content-area', `content-${selectedTab}`]">
      <div class="content-wrapper">
        <!-- Header Section: Title + CTA + Image -->
        <div class="header-section">
          <div class="header-content">
            <h2 class="main-title">
              <span v-html="currentContent.titleHtml"></span>
            </h2>

            <button class="pitch-button" @click="handlePitchClick" :disabled="isGenerating">
              <span v-if="!isGenerating">{{ currentContent.buttonText }}</span>
              <span v-else class="generating-text">Generating pitch...</span>
              <span v-if="!isGenerating" class="arrow-icon">↗</span>
              <span v-else class="loader"></span>
            </button>
          </div>

          <!-- Image -->
          <div class="image-container">
            <img
              :src="currentImage"
              :alt="currentContent.buttonText"
              class="leader-image"
            />
            <!-- Decorative Elements -->
            <div class="decorative-elements">
              <div class="decoration decoration-1"></div>
              <div class="decoration decoration-2"></div>
            </div>
          </div>
        </div>

        <!-- Features Grid -->
        <div class="features-list">
          <div
            v-for="(feature, index) in currentContent.features"
            :key="index"
            class="feature-item"
          >
            <h3 class="feature-title">{{ feature.title }}</h3>
            <p class="feature-description">{{ feature.description }}</p>
          </div>
        </div>
      </div>

      <!-- Decorative Bottom Border -->
      <div :class="['bottom-border', `border-${selectedTab}`]"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
const coachImage = 'https://placehold.co/350x280/fef3e2/ea580c?text=Coach';
const itHeadImage = 'https://placehold.co/350x280/e0f2fe/0ea5e9?text=IT+Head';
const principalImage = 'https://placehold.co/350x280/f3e8ff/8b5cf6?text=Principal';

interface Feature {
  title: string;
  description: string;
}

interface TabContent {
  titleHtml: string;
  buttonText: string;
  features: Feature[];
}

const selectedTab = ref('coach');
const isGenerating = ref(false);

const tabs = [
  { id: 'coach', label: 'FOR INSTRUCTIONAL COACHES' },
  { id: 'it', label: 'FOR IT HEADS' },
  { id: 'principal', label: 'FOR ASSISTANT PRINCIPAL' },
];

const handlePitchClick = async () => {
  isGenerating.value = true;

  // Simulate generation delay
  await new Promise(resolve => setTimeout(resolve, 2000));

  // Open Impact Report in new tab
  const url = `/admin/impact-report?persona=${selectedTab.value}`;
  window.open(url, '_blank');

  isGenerating.value = false;
};

const coachContent: TabContent = {
  titleHtml: 'COACHING THAT REACHES <span class="highlight-purple">EVERY CLASSROOM</span>',
  buttonText: 'PITCH TO COACH',
  features: [
    {
      title: 'Detailed, Real-Time Reports',
      description: 'Identify gaps quickly and guide targeted instructional moves.',
    },
    {
      title: 'Equitable instruction',
      description: 'Ensure every student gets timely, differentiated follow-up.',
    },
    {
      title: 'Improve State test prep',
      description: 'Standards-aligned practice using tools teachers already trust.',
    },
  ],
};

const itContent: TabContent = {
  titleHtml: 'SEE THE IMPACT OF INSTRUCTION ACROSS <span class="highlight-yellow">YOUR ENTIRE SCHOOL</span>',
  buttonText: 'PITCH TO IT HEAD',
  features: [
    {
      title: 'Streamline integration with existing tools',
      description: 'Seamlessly connects with your LMS, SSO, and district systems.',
    },
    {
      title: 'Ensure data security and compliance',
      description: 'Built with district-grade security and privacy standards.',
    },
    {
      title: 'Scale gamified tools across devices effortlessly',
      description: 'Deploy once and run smoothly across devices and classrooms.',
    },
    {
      title: 'Monitor adoption metrics for tech ROI',
      description: 'Track usage, engagement, and rollout success in real time.',
    },
  ],
};

const principalContent: TabContent = {
  titleHtml: 'ONE PLATFORM. <span class="highlight-green">DISTRICT WIDE</span> IMPACT',
  buttonText: 'PITCH TO ASST. PRINCIPAL',
  features: [
    {
      title: 'Campus wide data',
      description: "Spot gaps early and prioritize support where it's needed most.",
    },
    {
      title: 'Equitable education',
      description: 'Identify students who need intervention and those ready to advance.',
    },
    {
      title: 'School & Accountability Ratings',
      description: 'Standards-aligned practice that supports campus accountability goals.',
    },
    {
      title: 'One Platform, Fewer Tools',
      description: 'One platform to support instruction, assessment, and monitoring.',
    },
  ],
};

const currentContent = computed(() => {
  switch (selectedTab.value) {
    case 'coach':
      return coachContent;
    case 'it':
      return itContent;
    case 'principal':
      return principalContent;
    default:
      return coachContent;
  }
});

const currentImage = computed(() => {
  switch (selectedTab.value) {
    case 'coach':
      return coachImage;
    case 'it':
      return itHeadImage;
    case 'principal':
      return principalImage;
    default:
      return coachImage;
  }
});
</script>

<style scoped>
.wayground-leaders {
  width: 100%;
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

/* Tabs */
.tabs-container {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1.5rem;
  position: sticky;
  top: 0;
  z-index: 10;
  background: white;
  padding: 1rem 0;
  margin-top: -1rem;
}

.tab-button {
  flex: 1;
  padding: 0.75rem 1.5rem;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.5px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
  background: #f3f4f6;
  color: #6b7280;
}

.tab-button.active.tab-coach {
  background: #fef3e2;
  color: #ea580c;
}

.tab-button.active.tab-it {
  background: #e0f2fe;
  color: #0ea5e9;
}

.tab-button.active.tab-principal {
  background: #f3e8ff;
  color: #8b5cf6;
}

.tab-button:hover {
  opacity: 0.8;
}

/* Content Area */
.content-area {
  border-radius: 16px;
  overflow: hidden;
  position: relative;
}

.content-area.content-coach {
  background: linear-gradient(135deg, #fffbeb 0%, #fef3e2 100%);
}

.content-area.content-it {
  background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
}

.content-area.content-principal {
  background: linear-gradient(135deg, #faf5ff 0%, #f3e8ff 100%);
}

.content-wrapper {
  padding: 3rem;
  position: relative;
  z-index: 1;
}

/* Header Section */
.header-section {
  display: flex;
  gap: 2rem;
  align-items: flex-start;
  margin-bottom: 3rem;
}

.header-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.main-title {
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 1.6rem;
  font-weight: 700;
  line-height: 1.2;
  color: #0f172a;
  margin: 0;
  letter-spacing: -0.5px;
}

.highlight-purple {
  color: #9ca3af;
}

.highlight-yellow {
  color: #9ca3af;
}

.highlight-green {
  color: #9ca3af;
}

.pitch-button {
  align-self: flex-start;
  padding: 0.5rem;
  font-size: 0.8rem;
  font-weight: 700;
  letter-spacing: 0.5px;
  border: 2px solid #ff66b8;
  border-radius: 8px;
  background: #ffffff;
  color: #e0067b;
  cursor: pointer;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  white-space: nowrap;
}

.pitch-button:hover:not(:disabled) {
  background: #fff5fb;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(255, 102, 184, 0.3);
}

.pitch-button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.arrow-icon {
  font-size: 1rem;
}

.generating-text {
  display: inline-block;
}

.loader {
  width: 14px;
  height: 14px;
  border: 2px solid rgba(224, 6, 123, 0.3);
  border-top-color: #e0067b;
  border-radius: 50%;
  display: inline-block;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.features-list {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 2rem;
  column-gap: 3rem;
}

.feature-item {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  border-left: 3px solid currentColor;
  padding-left: 1rem;
}

.content-coach .feature-item {
  border-color: #f59e0b;
}

.content-it .feature-item {
  border-color: #0ea5e9;
}

.content-principal .feature-item {
  border-color: #8b5cf6;
}

.feature-title {
  font-size: 1rem;
  font-weight: 700;
  color: #0f172a;
  margin: 0;
}

.feature-description {
  font-size: 0.875rem;
  color: #475569;
  line-height: 1.6;
  margin: 0;
}

/* Image Container */
.image-container {
  position: relative;
  flex: 0 0 350px;
  display: flex;
  align-items: flex-start;
  justify-content: center;
}

.leader-image {
  width: 100%;
  height: 280px;
  object-fit: cover;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* Decorative Elements */
.decorative-elements {
  position: absolute;
  top: -30px;
  right: -30px;
  width: calc(100% + 60px);
  height: calc(100% + 60px);
  pointer-events: none;
  z-index: -1;
}

.decoration {
  position: absolute;
  border-radius: 50%;
  opacity: 0.2;
}

.content-coach .decoration {
  border: 3px solid #f59e0b;
}

.content-it .decoration {
  border: 3px solid #0ea5e9;
}

.content-principal .decoration {
  border: 3px solid #8b5cf6;
}

.decoration-1 {
  width: 150px;
  height: 150px;
  top: -20px;
  right: 30px;
}

.decoration-2 {
  width: 90px;
  height: 90px;
  bottom: 20px;
  right: 10px;
}

/* Bottom Border */
.bottom-border {
  height: 8px;
  width: 100%;
}

.border-coach {
  background: linear-gradient(90deg, transparent 0%, #fbbf24 50%, transparent 100%);
}

.border-it {
  background: linear-gradient(90deg, transparent 0%, #0ea5e9 50%, transparent 100%);
}

.border-principal {
  background: linear-gradient(90deg, transparent 0%, #8b5cf6 50%, transparent 100%);
}

/* Responsive */
@media (max-width: 1200px) {
  .header-section {
    gap: 1.5rem;
  }

  .image-container {
    flex: 0 0 280px;
  }

  .leader-image {
    height: 240px;
  }

  .features-list {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
}

@media (max-width: 768px) {
  .tabs-container {
    flex-direction: column;
  }

  .content-wrapper {
    padding: 2rem;
  }

  .header-section {
    flex-direction: column;
    margin-bottom: 2rem;
  }

  .main-title {
    font-size: 1.5rem;
  }

  .image-container {
    width: 100%;
    flex: 1;
  }

  .leader-image {
    height: 220px;
  }

  .features-list {
    gap: 1.5rem;
  }
}
</style>
