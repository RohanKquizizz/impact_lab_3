<template>
  <div class="app">
    <SchoolsAndDistrictsPage v-if="showSchoolsPage" />
    <template v-else>
    <div class="main-grid">
      <div class="left-column">
        <!-- 1. Ms. Elizabeth's impact -->
        <section class="left-section section-beige">
          <h2 class="section-title">Ms. Elizabeth's impact at Oakland Middle School, Texas</h2>
          <div class="section-inner">
            <ImpactStory ref="impactStoryRef" />
          </div>
        </section>
        <!-- 2. Blank section: same as Impact Story (yellow background, grid, white card) -->
        <section class="left-section section-blank">
          <div class="blank-impact-wrap">
            <div class="blank-grid-bg" aria-hidden="true" />
            <div class="blank-container">
              <div class="blank-progress" aria-hidden="true" />
              <div class="blank-story">
                <header class="blank-narrative">
                  <h1 class="blank-headline">Ms. Elizabeth, we built this PD deck for your fellow teachers</h1>
                  <p class="blank-body">Perfect to present in PLCs, department meetings, or informal meetings ❤️</p>
                </header>
                <div class="blank-slide-viewer">
                  <button type="button" class="blank-slide-nav blank-slide-nav-left" aria-label="Previous slide">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 15l-5-5 5-5"/></svg>
                  </button>
                  <div class="blank-space">
                    <div class="blank-space-inner">
                      <img
                        src="/wayground-demo-slide.png"
                        alt="Wayground DEMO slide"
                        class="blank-space-img"
                      />
                    </div>
                  </div>
                  <button type="button" class="blank-slide-nav blank-slide-nav-right" aria-label="Next slide">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 5l5 5-5 5"/></svg>
                  </button>
                </div>
                <div class="blank-download-wrap">
                  <button type="button" class="blank-download-btn" @click="showSlideDeckModal = true">Get the Slide Deck</button>
                  <p class="blank-download-note">If you need any help with the PD, please reach out to us.</p>
                </div>
              </div>
              <div class="blank-controls-spacer" aria-hidden="true" />
            </div>
            <!-- Get the Slide Deck modal: email only -->
            <div v-if="showSlideDeckModal" class="share-modal-backdrop share-modal-backdrop--section" @click.self="closeSlideDeckModal">
              <div class="share-modal share-modal--slide-deck" role="dialog" aria-labelledby="slide-deck-modal-heading" aria-modal="true" @click.stop>
                <button type="button" class="share-modal-close" aria-label="Close" @click="closeSlideDeckModal">×</button>
                <div class="share-modal-layout">
                  <div class="share-modal-left share-modal-left--preview">
                    <img src="/slide-preview.png" alt="Wayground DEMO slide preview" class="share-modal-slide-preview" />
                  </div>
                  <div class="share-modal-right">
                    <h2 id="slide-deck-modal-heading" class="share-modal-heading">Get the Slide Deck</h2>
                    <div class="share-modal-field">
                      <label class="share-modal-label">Email</label>
                      <input
                        v-model="slideDeckEmail"
                        type="email"
                        class="share-modal-input"
                        placeholder="Enter your email"
                        aria-label="Your email"
                      />
                    </div>
                    <div class="share-modal-actions">
                      <button type="button" class="share-modal-submit" @click="submitSlideDeckModal">Submit</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- Thank you after slide deck submit -->
            <div v-if="showSlideDeckThankYouModal" class="share-modal-backdrop share-modal-backdrop--section" @click.self="closeSlideDeckThankYouModal">
              <div class="thankyou-modal" role="dialog" aria-live="polite" aria-label="Thank you" @click.stop>
                <div class="thankyou-confetti" aria-hidden="true">
                  <span v-for="(c, i) in confettiPieces" :key="'slide-' + i" class="thankyou-confetti-piece" :style="c" />
                </div>
                <div class="thankyou-header">
                  <button type="button" class="thankyou-close" aria-label="Close" @click="closeSlideDeckThankYouModal">×</button>
                  <span class="thankyou-icon thankyou-icon--1">✉</span>
                  <span class="thankyou-icon thankyou-icon--2">💬</span>
                  <span class="thankyou-icon thankyou-icon--3">✈</span>
                  <span class="thankyou-icon thankyou-icon--4">⋯</span>
                </div>
                <div class="thankyou-body">
                  <h2 class="thankyou-title">Thank you!</h2>
                  <p class="thankyou-sub">We've emailed a copy of these slides to you.</p>
                  <button type="button" class="thankyou-dismiss" @click="closeSlideDeckThankYouModal">Close</button>
                </div>
              </div>
            </div>
          </div>
        </section>
        <!-- 3. Wayground for Coaches, Principals and Heads (same PD deck as section 2) -->
        <section class="left-section section-blank section-leaders">
          <div class="blank-impact-wrap section-leaders-wrap">
            <div class="blank-grid-bg" aria-hidden="true" />
            <div class="blank-container">
              <div class="blank-progress" aria-hidden="true" />
              <div class="blank-story">
                <header class="blank-narrative">
                  <h1 class="blank-headline">Ready to grow Wayground at Oakland Middle School? ❤️</h1>
                  <p class="blank-body blank-body--small">Give your leadership a clear look at how Wayground can help Oakland Middle School, including an easy-to-use budget calculator for their planning.</p>
                </header>
                <div class="blank-slide-viewer">
                  <div class="blank-space blank-space--one-pager">
                    <div class="one-pager-white-box">
                      <div class="one-pager-layout">
                        <div class="one-pager-flag-wrap one-pager-flag-wrap--image" aria-hidden="true">
                          <img src="/flag-section-image.png" alt="Wayground × Oakland Middle School" class="one-pager-section-image" />
                        </div>
                        <div class="one-pager-form-wrap">
                        <h2 class="one-pager-form-heading">Enter your admin's details</h2>
                        <div class="one-pager-field">
                          <label class="one-pager-label">Name</label>
                          <input
                            v-model="adminName"
                            type="text"
                            class="one-pager-input"
                            placeholder="Enter admin's name here"
                            aria-label="Admin name"
                          />
                        </div>
                        <div class="one-pager-field">
                          <label class="one-pager-label">Email ID</label>
                          <input
                            v-model="adminEmail"
                            type="email"
                            class="one-pager-input"
                            placeholder="Enter admin's email ID"
                            aria-label="Email address"
                          />
                        </div>
                        <div class="one-pager-field">
                          <label class="one-pager-label">Role</label>
                          <select v-model="adminRole" class="one-pager-select" aria-label="Role">
                            <option value="">Select admin's role</option>
                            <option value="instructional-coach">Instructional coach</option>
                            <option value="principal">Principal</option>
                            <option value="head-of-department">Head of department</option>
                            <option value="assistant-principal">Assistant Principal</option>
                            <option value="other">Other</option>
                          </select>
                        </div>
                      </div>
                    </div>
                    </div>
                  </div>
                </div>
                <div class="blank-download-wrap">
                  <button type="button" class="blank-download-btn" @click="showShareModal = true">Recommend to my leadership</button>
                  <p class="blank-download-note">Our team will follow up with your admin to help them explore Wayground for your school.</p>
                </div>
              </div>
              <div class="blank-controls-spacer" aria-hidden="true" />
            </div>
            <!-- Share the Vision modal: blur and center only within this section -->
            <div v-if="showShareModal" class="share-modal-backdrop share-modal-backdrop--section" @click.self="closeShareModal">
              <div class="share-modal" role="dialog" aria-labelledby="share-modal-heading" aria-modal="true" @click.stop>
                <button type="button" class="share-modal-close" aria-label="Close" @click="closeShareModal">×</button>
                <div class="share-modal-layout">
                  <div class="share-modal-left">
                    <div class="share-modal-flag-wrap" aria-hidden="true">
                      <div class="share-modal-flag-pole" />
                      <div class="share-modal-flag">
                        <span class="share-modal-flag-pinata-wrap">
                          <img src="/pinata.png" alt="" class="share-modal-flag-pinata" aria-hidden="true" />
                        </span>
                        <span class="share-modal-flag-line">Wayground</span>
                        <span class="share-modal-flag-x">×</span>
                        <span class="share-modal-flag-line">Oakland Middle School</span>
                      </div>
                    </div>
                  </div>
                  <div class="share-modal-right">
                    <h2 id="share-modal-heading" class="share-modal-heading">Enter your admin's details</h2>
                    <div class="share-modal-field">
                      <label class="share-modal-label">Name</label>
                      <input
                        v-model="adminName"
                        type="text"
                        class="share-modal-input"
                        placeholder="Enter admin's name here"
                        aria-label="Admin name"
                      />
                    </div>
                    <div class="share-modal-field">
                      <label class="share-modal-label">Email ID</label>
                      <input
                        v-model="adminEmail"
                        type="email"
                        class="share-modal-input"
                        placeholder="Enter admin's email ID"
                        aria-label="Email address"
                      />
                    </div>
                    <div class="share-modal-field">
                      <label class="share-modal-label">Role</label>
                      <select v-model="adminRole" class="share-modal-select" aria-label="Role">
                        <option value="">Select admin's role</option>
                        <option value="instructional-coach">Instructional coach</option>
                        <option value="principal">Principal</option>
                        <option value="head-of-department">Head of department</option>
                        <option value="assistant-principal">Assistant Principal</option>
                        <option value="other">Other</option>
                      </select>
                    </div>
                    <div class="share-modal-actions">
                      <button type="button" class="share-modal-submit" @click="submitShareModal">Submit</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- Thank you modal (after submit): header + content, confetti, pink close -->
            <div v-if="showThankYouModal" class="share-modal-backdrop share-modal-backdrop--section" @click.self="closeThankYouModal">
              <div class="thankyou-modal" role="dialog" aria-live="polite" aria-label="Thank you" @click.stop>
                <div class="thankyou-confetti" aria-hidden="true">
                  <span v-for="(c, i) in confettiPieces" :key="i" class="thankyou-confetti-piece" :style="c" />
                </div>
                <div class="thankyou-header">
                  <button type="button" class="thankyou-close" aria-label="Close" @click="closeThankYouModal">×</button>
                  <span class="thankyou-icon thankyou-icon--1">✉</span>
                  <span class="thankyou-icon thankyou-icon--2">💬</span>
                  <span class="thankyou-icon thankyou-icon--3">✈</span>
                  <span class="thankyou-icon thankyou-icon--4">⋯</span>
                </div>
                <div class="thankyou-body">
                  <h2 class="thankyou-title">Thank you!</h2>
                  <p class="thankyou-sub">Thank you for sharing the admin details ❤️</p>
                  <button type="button" class="thankyou-dismiss" @click="closeThankYouModal">Close</button>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>

      <!-- Right: fixed (sticky) -->
      <aside class="right-column">
        <div class="right-inner">
          <div class="right-column-card">
            <HeatMap />
          </div>
        </div>
      </aside>
    </div>

    <!-- Share impact modal collage of 6 slides + download -->
    <div v-if="showShareImpactModal" class="share-impact-backdrop" @click.self="closeShareImpactModal">
      <div class="share-impact-modal" role="dialog" aria-labelledby="share-impact-title" aria-modal="true" @click.stop>
        <button type="button" class="share-impact-close" aria-label="Close" @click="closeShareImpactModal">×</button>
        <h2 id="share-impact-title" class="share-impact-heading">Share your impact</h2>
        <p class="share-impact-sub">A collage of all 6 impact slides. Download to share.</p>
        <div v-if="generatingCollage" class="share-impact-generating">
          <span class="share-impact-spinner" aria-hidden="true" />
          <p>Creating your collage…</p>
        </div>
        <template v-else-if="slideImages.length === 6">
          <div class="share-impact-collage">
            <img
              v-for="(url, i) in slideImages"
              :key="i"
              class="share-impact-collage-img"
              :src="url"
              :alt="`Slide ${i + 1}`"
            />
          </div>
          <div class="share-impact-actions">
            <button type="button" class="share-impact-download" @click="downloadCollageImage">Download</button>
            <button type="button" class="share-impact-dismiss" @click="closeShareImpactModal">Close</button>
          </div>
        </template>
      </div>
    </div>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, nextTick, onMounted, onUnmounted } from 'vue'
import HeatMap from './components/HeatMap.vue'
import ImpactStory from './components/ImpactStory.vue'
import SchoolsAndDistrictsPage from './views/SchoolsAndDistrictsPage.vue'

const showSchoolsPage = ref(window.location.hash === '#schools-and-districts')
function updateSchoolsPage() {
  showSchoolsPage.value = window.location.hash === '#schools-and-districts'
}
onMounted(() => {
  window.addEventListener('hashchange', updateSchoolsPage)
})
onUnmounted(() => {
  window.removeEventListener('hashchange', updateSchoolsPage)
})

const showShareModal = ref(false)
const showShareImpactModal = ref(false)
const impactStoryRef = ref<InstanceType<typeof ImpactStory> | null>(null)
const slideImages = ref<string[]>([])
const generatingCollage = ref(false)
const showThankYouModal = ref(false)
const adminName = ref('')
const adminEmail = ref('')
const adminRole = ref('')

const showSlideDeckModal = ref(false)
const showSlideDeckThankYouModal = ref(false)
const slideDeckEmail = ref('')

const confettiColors = ['#FF319F', '#FF6B9D', '#C7267A', '#FFB3D9', '#2d1b4e', '#F3EFDA']
const confettiPieces = Array.from({ length: 48 }, (_, i) => {
  const angle = (i / 48) * 2 * Math.PI + Math.random() * 0.5
  const dist = 55 + Math.random() * 50
  const dx = Math.cos(angle) * dist
  const dy = Math.sin(angle) * dist
  return {
    '--dx': `${dx}px`,
    '--dy': `${dy}px`,
    '--delay': `${(i * 0.015) + Math.random() * 0.08}s`,
    '--rot': `${Math.random() * 720 - 360}deg`,
    backgroundColor: confettiColors[i % confettiColors.length],
    width: `${5 + Math.random() * 6}px`,
    height: `${4 + Math.random() * 4}px`,
  }
})

function openShareModal() {
  showShareModal.value = true
}
function closeShareModal() {
  showShareModal.value = false
}
function submitShareModal() {
  closeShareModal()
  showThankYouModal.value = true
}
function closeThankYouModal() {
  showThankYouModal.value = false
}

function closeSlideDeckModal() {
  showSlideDeckModal.value = false
}
function submitSlideDeckModal() {
  showSlideDeckModal.value = false
  showSlideDeckThankYouModal.value = true
}
function closeSlideDeckThankYouModal() {
  showSlideDeckThankYouModal.value = false
}

function closeShareImpactModal() {
  showShareImpactModal.value = false
}

async function openShareImpactModal() {
  showShareImpactModal.value = true
  generatingCollage.value = true
  slideImages.value = []
  await nextTick()
  try {
    const urls = await impactStoryRef.value?.generateSlideImages?.() ?? []
    slideImages.value = urls
  } catch (e) {
    console.error('Generate slide images failed', e)
  } finally {
    generatingCollage.value = false
  }
}

function loadImage(src: string): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const img = new Image()
    img.crossOrigin = 'anonymous'
    img.onload = () => resolve(img)
    img.onerror = reject
    img.src = src
  })
}

async function downloadCollageImage() {
  const urls = slideImages.value
  if (urls.length !== 6) return
  try {
    const images = await Promise.all(urls.map(loadImage))
    const cols = 3
    const rows = 2
    const cellW = 400
    const cellH = 314
    const gap = 3
    const cw = cols * cellW + (cols - 1) * gap
    const ch = rows * cellH + (rows - 1) * gap
    const canvas = document.createElement('canvas')
    canvas.width = cw
    canvas.height = ch
    const ctx = canvas.getContext('2d')
    if (!ctx) return
    ctx.fillStyle = '#ffffff'
    ctx.fillRect(0, 0, cw, ch)
    for (let i = 0; i < 6; i++) {
      const img = images[i]
      const x = (i % cols) * (cellW + gap)
      const y = Math.floor(i / cols) * (cellH + gap)
      const scale = Math.min(cellW / img.width, cellH / img.height)
      const dw = img.width * scale
      const dh = img.height * scale
      const dx = x + (cellW - dw) / 2
      const dy = y + (cellH - dh) / 2
      ctx.drawImage(img, 0, 0, img.width, img.height, dx, dy, dw, dh)
    }
    const link = document.createElement('a')
    link.download = 'my-impact-collage.png'
    link.href = canvas.toDataURL('image/png')
    link.click()
  } catch (e) {
    console.error('Collage download failed', e)
  }
}
</script>

<style scoped>
.app {
  min-height: 100vh;
  background: #f5f5f0;
}

/* Grid: left ~2/3, right ~1/3. Right is sticky. Generous outer padding. */
.main-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2rem;
  max-width: 1400px;
  margin: 0 auto;
  padding: 2rem 2.5rem;
  align-items: start;
}

/* Left column: all scrollable content */
.left-column {
  min-width: 0;
}

/* Left sections: generous padding, substantial spacing between sections */
.left-section {
  padding: 2.25rem 2.5rem;
  background: #f8f6f2;
}
.left-section.section-beige {
  background: #f8f6f2;
}
.left-section.section-white {
  background: #fff;
  border-top: 1px solid #e8e6e2;
}
/* Blank section: match Impact Story – yellow background, grid, same layout and white card size */
.section-blank {
  background: transparent;
  border-top: none;
  padding: 2.25rem 2.5rem;
}
.blank-impact-wrap {
  position: relative;
  width: 100%;
  height: 720px;
  background: #F3EFDA;
  border-radius: 12px;
  overflow: hidden;
}
.blank-grid-bg {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(rgba(30, 58, 95, 0.06) 1px, transparent 1px),
    linear-gradient(90deg, rgba(30, 58, 95, 0.06) 1px, transparent 1px);
  background-size: 24px 24px;
  pointer-events: none;
}
.blank-container {
  position: relative;
  z-index: 1;
  height: 100%;
  max-width: 880px;
  margin: 0 auto;
  padding: 2rem 1.75rem;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
}
.blank-progress {
  flex: 0 0 auto;
  height: 4px;
}
.blank-story {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1rem;
  min-height: 0;
}
.blank-narrative {
  flex: 0 0 auto;
  text-align: center;
  padding: 0.5rem 1rem;
}
.blank-headline {
  font-size: 1.5rem;
  font-weight: 500;
  line-height: 1.35;
  margin: 0 0 0.5rem;
  color: #1E3A5F;
}
.blank-body {
  font-size: 1.05rem;
  color: #FF319F;
  font-weight: 500;
  margin: 0;
  line-height: 1.6;
}
.blank-body--small {
  font-size: 0.9rem;
}
.blank-slide-viewer {
  flex: 1;
  min-height: 380px;
  position: relative;
  display: flex;
  align-items: stretch;
  gap: 0.5rem;
  min-width: 0;
}
.blank-slide-nav {
  flex: 0 0 auto;
  width: 40px;
  align-self: center;
  background: rgba(255, 255, 255, 0.75);
  border: 1px solid rgba(0, 0, 0, 0.08);
  border-radius: 50%;
  color: #1E3A5F;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);
  transition: background 0.2s, box-shadow 0.2s;
}
.blank-slide-nav:hover {
  background: rgba(255, 255, 255, 0.95);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}
.blank-slide-nav:active {
  background: rgba(255, 255, 255, 1);
}
.blank-space {
  flex: 1;
  min-height: 0;
  width: 100%;
  background-color: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 20px rgba(30, 58, 95, 0.08);
  box-sizing: border-box;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0.5rem;
  overflow: hidden;
}
.blank-space-inner {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 0;
}
.blank-space-img {
  max-width: 100%;
  max-height: 100%;
  width: auto;
  height: auto;
  object-fit: contain;
  object-position: center;
  display: block;
}
/* One-pager layout (second PD section): dark purple bg, white + pink headline, school image right */
.blank-space--one-pager {
  padding: 1.25rem 1.5rem;
  align-items: stretch;
  min-height: 0;
  overflow: auto;
  background: #2d1b4e;
  background-image:
    linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
  background-size: 20px 20px;
  box-sizing: border-box;
}
.one-pager-white-box {
  width: 100%;
  max-width: 100%;
  background: #fff;
  border-radius: 14px;
  padding: 1.35rem 1.5rem;
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.15);
  box-sizing: border-box;
  min-height: 0;
}
.one-pager-layout {
  display: flex;
  align-items: center;
  gap: 2rem;
  width: 100%;
  max-width: 100%;
  min-height: 0;
  min-width: 0;
}
.one-pager-layout--image-only {
  justify-content: flex-start;
}
.one-pager-title-wrap {
  flex: 1;
  min-width: 0;
  max-width: 100%;
}
.one-pager-title {
  font-size: 1.75rem;
  font-weight: 600;
  color: #fff;
  margin: 0;
  line-height: 1.4;
  font-family: inherit;
}
.one-pager-title .one-pager-highlight {
  color: #FF319F;
}
/* Flag: pole starts at bottom of box and runs up; flag at top; or use custom image */
.one-pager-flag-wrap {
  display: flex;
  align-items: flex-start;
  flex-shrink: 0;
  align-self: stretch;
  background: none;
  padding: 0;
  margin: 0;
}
.one-pager-flag-wrap--image {
  align-items: center;
  justify-content: center;
  min-width: 0;
  flex: 1 1 auto;
}
.one-pager-section-image {
  max-width: 90%;
  max-height: 260px;
  width: auto;
  height: auto;
  object-fit: contain;
  display: block;
  border-radius: 8px;
}

/* Inline form on the right of the one-pager section (inside white box) */
.one-pager-form-wrap {
  flex: 0 0 auto;
  width: 300px;
  max-width: 45%;
  min-width: 0;
  padding: 0 0 0 1.5rem;
  border-left: 1px solid #e2e8f0;
  margin-left: 0.5rem;
  box-sizing: border-box;
}
.one-pager-form-heading {
  font-size: 1.05rem;
  font-weight: 700;
  color: #1a1a2e;
  margin: 0 0 1rem;
  line-height: 1.3;
}
.one-pager-field {
  margin-bottom: 0.9rem;
}
.one-pager-field:last-of-type {
  margin-bottom: 1rem;
}
.one-pager-label {
  display: block;
  font-size: 0.8rem;
  font-weight: 600;
  color: #334155;
  margin-bottom: 0.35rem;
}
.one-pager-input,
.one-pager-select {
  width: 100%;
  padding: 0.5rem 0.65rem;
  font-size: 0.9rem;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  background: #f8fafc;
  color: #1e293b;
  font-family: inherit;
  box-sizing: border-box;
}
.one-pager-input::placeholder {
  color: #94a3b8;
}
.one-pager-select {
  cursor: pointer;
  appearance: auto;
}
.one-pager-form-actions {
  margin-top: 0.25rem;
}
.one-pager-submit {
  width: 100%;
  padding: 0.65rem 1rem;
  font-size: 0.95rem;
  font-weight: 600;
  color: #fff;
  background: #FF319F;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-family: inherit;
  transition: background 0.2s;
}
.one-pager-submit:hover {
  background: #e02d8d;
}
.one-pager-flag-pole {
  width: 5px;
  height: 100%;
  min-height: 180px;
  background: #1a1a1a;
  border-radius: 3px;
  flex-shrink: 0;
  box-shadow: 1px 0 3px rgba(0, 0, 0, 0.2);
}
.one-pager-flag {
  position: relative;
  flex: 0 0 auto;
  width: 235px;
  height: 150px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 0.55rem 0.75rem;
  background: #fff;
  color: #2d1b4e;
  font-size: 0.98rem;
  font-weight: 700;
  text-align: center;
  line-height: 1.3;
  letter-spacing: 0.02em;
  transform-origin: left center;
  animation: flag-wave 2.8s ease-in-out infinite;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
  border-radius: 0 6px 6px 0;
}
.one-pager-flag-pinata-wrap {
  position: absolute;
  top: 0.35rem;
  right: 0.45rem;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  overflow: hidden;
  clip-path: circle(50% at 55% 45%);
  pointer-events: none;
}
.one-pager-flag-pinata {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: 28% 42%;
  display: block;
}
.one-pager-flag-line {
  display: block;
}
.one-pager-flag-x {
  display: block;
  margin: 0.15em 0;
  font-weight: 800;
  font-size: 1.1em;
}
@keyframes flag-wave {
  0%, 100% { transform: skewY(0deg) scaleX(1); }
  25% { transform: skewY(3deg) scaleX(1.02); }
  50% { transform: skewY(-2.5deg) scaleX(0.98); }
  75% { transform: skewY(2deg) scaleX(1.01); }
}
.blank-download-wrap {
  flex: 0 0 auto;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 0.5rem;
  gap: 0.5rem;
}
.blank-download-note {
  font-size: 0.8rem;
  color: #6B7C93;
  margin: 1rem 0 0;
  line-height: 1.4;
}
.blank-download-link {
  color: #2563eb;
  text-decoration: underline;
  cursor: pointer;
}
.blank-download-link:hover {
  color: #1d4ed8;
}
.blank-download-btn {
  background: #FF319F;
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 0.75rem 1.85rem;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  font-family: inherit;
  transition: background 0.2s, transform 0.1s;
}
.blank-download-btn:hover {
  background: #e02d8d;
}
.blank-download-btn:active {
  transform: scale(0.98);
}
.blank-controls-spacer {
  flex: 0 0 auto;
  height: 52px;
}
/* Substantial vertical margin between sections */
.left-section + .left-section {
  margin-top: 2.5rem;
}
.section-inner {
  margin-top: 1.25rem;
}

/* Right column: light yellow box starts where left yellow box (Games played) starts */
.right-column {
  position: sticky;
  top: 0;
  align-self: start;
  margin-top: 4.75rem;
  background: #f8f6f2;
  min-width: 0;
  max-height: 100vh;
  overflow-y: auto;
  border-radius: 12px;
  border: 1px solid rgba(0, 0, 0, 0.06);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);
}
.right-inner {
  padding: 1.5rem 1.5rem 2.25rem;
  min-width: 0;
  box-sizing: border-box;
}
.right-inner .section-title {
  margin-bottom: 1.25rem;
}
.right-column-card {
  margin-top: 0;
  height: 600px;
  min-height: 600px;
  border-radius: 12px;
  overflow: hidden;
  background: #fff;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
  padding: 1.5rem;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}
.right-column-card :deep(.heat-map-container) {
  height: 100%;
  width: 100%;
  max-width: 100%;
  min-width: 0;
  display: flex;
  flex-direction: column;
  min-height: 0;
}
.right-column-card :deep(.ticker-section) {
  flex-shrink: 0;
  padding: 0 0 0.75rem;
}
.right-column-card :deep(.map-wrapper) {
  flex: 1;
  min-height: 0;
  display: flex;
  flex-direction: column;
  width: 100%;
  margin: 0 auto;
}
.right-column-card :deep(.region-map) {
  flex: 1;
  min-height: 0;
  width: 100%;
  object-fit: contain;
}

.section-title-row {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1.25rem;
  flex-wrap: wrap;
}
.section-title-row .section-title {
  margin: 0;
  flex: 1;
  min-width: 0;
}
.share-impact-btn {
  flex-shrink: 0;
  padding: 0.5rem 1rem;
  font-size: 0.875rem;
  font-weight: 600;
  font-family: inherit;
  color: #1a1a2e;
  background: #fff;
  border: 2px solid #FF319F;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.2s, color 0.2s;
}
.share-impact-btn:hover {
  background: #fff5fb;
}
.section-title {
  font-size: 1.4rem;
  font-weight: 700;
  color: #1a1a2e;
  margin: 0 0 1.25rem;
  letter-spacing: -0.02em;
}

.left-section.section-leaders {
  position: relative;
}
.leaders-accent {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, transparent 0%, #fbbf24 50%, transparent 100%);
}

@media (max-width: 1024px) {
  .main-grid {
    grid-template-columns: 1fr;
    padding: 1.5rem 1.25rem;
    gap: 1.5rem;
  }
  .left-section {
    padding: 1.75rem 1.5rem;
  }
  .left-section + .left-section {
    margin-top: 1.75rem;
  }
  .right-column {
    position: static;
    max-height: none;
    border-top: 1px solid #e8e6e2;
  }
  .right-inner {
    padding: 1.75rem 1.5rem;
  }
}
</style>

<style>
.share-modal-backdrop {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(6px);
  z-index: 10;
}
.share-modal-backdrop--section {
  position: absolute;
  inset: 0;
  border-radius: 12px;
}
.share-modal {
  position: relative;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
  width: 100%;
  max-width: 560px;
  overflow: hidden;
}
.share-modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  z-index: 2;
  width: 32px;
  height: 32px;
  padding: 0;
  border: none;
  background: none;
  font-size: 1.5rem;
  line-height: 1;
  color: #64748b;
  cursor: pointer;
  border-radius: 6px;
  transition: color 0.2s, background 0.2s;
}
.share-modal-close:hover {
  color: #1a1a2e;
  background: #f1f5f9;
}
.share-modal-layout {
  display: flex;
  min-height: 320px;
}
.share-modal-left {
  flex: 0 0 42%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1.75rem 1.25rem;
  background: #f8fafc;
  border-radius: 16px 0 0 16px;
}
.share-modal-left--preview {
  padding: 1rem;
}
.share-modal-slide-preview {
  width: 100%;
  height: 100%;
  min-height: 200px;
  max-height: 280px;
  object-fit: contain;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
}
/* Get the Slide Deck modal: larger modal, bigger email field, submit lower */
.share-modal--slide-deck {
  max-width: 640px;
}
.share-modal--slide-deck .share-modal-layout {
  min-height: 380px;
}
.share-modal--slide-deck .share-modal-right {
  padding: 2rem 2rem 1.5rem;
}
.share-modal--slide-deck .share-modal-input {
  padding: 0.75rem 1rem;
  font-size: 1.0625rem;
}
.share-modal--slide-deck .share-modal-actions {
  margin-top: 2rem;
}
.share-modal--slide-deck .share-modal-submit {
  padding: 0.65rem 1.5rem;
  font-size: 1rem;
}
.share-modal--slide-deck .share-modal-slide-preview {
  max-height: 320px;
}
.share-modal-right {
  flex: 1;
  padding: 1.75rem 1.75rem 1.5rem;
  min-width: 0;
}
.share-modal-heading {
  font-size: 1.2rem;
  font-weight: 700;
  color: #1a1a2e;
  margin: 0 0 1.25rem;
  letter-spacing: -0.02em;
}
.share-modal-field {
  margin-bottom: 1rem;
}
.share-modal-label {
  display: block;
  font-size: 0.875rem;
  font-weight: 600;
  color: #334155;
  margin-bottom: 0.35rem;
}
.share-modal-select,
.share-modal-input {
  width: 100%;
  padding: 0.55rem 0.75rem;
  font-size: 0.9375rem;
  font-family: inherit;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  background: #fff;
  color: #1a1a2e;
  box-sizing: border-box;
}
.share-modal-input::placeholder {
  color: #94a3b8;
}
.share-modal-actions {
  margin-top: 1.35rem;
  display: flex;
  justify-content: center;
}
.share-modal-submit {
  background: #FF319F;
  color: #fff;
  border: none;
  border-radius: 6px;
  padding: 0.5rem 1.25rem;
  font-size: 0.875rem;
  font-weight: 600;
  cursor: pointer;
  font-family: inherit;
  transition: background 0.2s, transform 0.1s;
}
.share-modal-submit:hover {
  background: #e02d8d;
}
.share-modal-submit:active {
  transform: scale(0.98);
}
/* Flag inside modal (scaled down) */
.share-modal-flag-wrap {
  display: flex;
  align-items: flex-start;
  flex-shrink: 0;
  background: none;
  padding: 0;
  margin: 0;
}
.share-modal-flag-pole {
  width: 4px;
  height: 120px;
  min-height: 100px;
  background: #1a1a1a;
  border-radius: 2px;
  flex-shrink: 0;
  box-shadow: 1px 0 2px rgba(0, 0, 0, 0.2);
}
.share-modal-flag {
  position: relative;
  flex: 0 0 auto;
  width: 140px;
  height: 88px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 0.4rem 0.5rem;
  background: #fff;
  color: #2d1b4e;
  font-size: 0.7rem;
  font-weight: 700;
  text-align: center;
  line-height: 1.25;
  letter-spacing: 0.02em;
  transform-origin: left center;
  animation: share-modal-flag-wave 2.8s ease-in-out infinite;
  box-shadow: 1px 1px 8px rgba(0, 0, 0, 0.12);
  border-radius: 0 4px 4px 0;
}
.share-modal-flag-pinata-wrap {
  position: absolute;
  top: 0.2rem;
  right: 0.25rem;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  overflow: hidden;
  clip-path: circle(50% at 55% 45%);
  pointer-events: none;
}
.share-modal-flag-pinata {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: 28% 42%;
  display: block;
}
.share-modal-flag-line {
  display: block;
}
.share-modal-flag-x {
  display: block;
  margin: 0.1em 0;
  font-weight: 800;
  font-size: 1em;
}
@keyframes share-modal-flag-wave {
  0%, 100% { transform: skewY(0deg) scaleX(1); }
  25% { transform: skewY(3deg) scaleX(1.02); }
  50% { transform: skewY(-2.5deg) scaleX(0.98); }
  75% { transform: skewY(2deg) scaleX(1.01); }
}

/* Thank you modal: header (icons + pink X) + body (title, sub, pink Close) + confetti */
.thankyou-modal {
  position: relative;
  background: #fff;
  border-radius: 14px;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
  min-width: 280px;
  max-width: 360px;
  overflow: hidden;
}
.thankyou-confetti {
  position: absolute;
  inset: -20px;
  pointer-events: none;
  z-index: 0;
}
.thankyou-confetti-piece {
  position: absolute;
  left: 50%;
  top: 50%;
  margin-left: -5px;
  margin-top: -5px;
  border-radius: 1px;
  animation: thankyou-confetti-burst 1s ease-out forwards;
  animation-delay: var(--delay, 0s);
  opacity: 0;
}
@keyframes thankyou-confetti-burst {
  0% {
    opacity: 1;
    transform: translate(0, 0) rotate(0deg);
  }
  100% {
    opacity: 0.9;
    transform: translate(var(--dx), var(--dy)) rotate(var(--rot, 0deg));
  }
}
.thankyou-header {
  position: relative;
  z-index: 1;
  background: #f5f0e8;
  padding: 1.5rem 1.5rem 1.75rem;
  min-height: 72px;
}
.thankyou-close {
  position: absolute;
  top: 0.75rem;
  right: 0.75rem;
  width: 28px;
  height: 28px;
  padding: 0;
  border: none;
  background: none;
  font-size: 1.5rem;
  line-height: 1;
  color: #FF319F;
  cursor: pointer;
  border-radius: 6px;
  transition: color 0.2s, background 0.2s;
}
.thankyou-close:hover {
  color: #e02d8d;
  background: rgba(255, 49, 159, 0.08);
}
.thankyou-icon {
  position: absolute;
  font-size: 1.1rem;
  color: rgba(0, 0, 0, 0.12);
  pointer-events: none;
}
.thankyou-icon--1 { top: 1.25rem; left: 18%; }
.thankyou-icon--2 { top: 1.5rem; left: 42%; }
.thankyou-icon--3 { top: 1.1rem; right: 28%; }
.thankyou-icon--4 { top: 1.4rem; right: 14%; font-size: 1.4rem; }
.thankyou-body {
  position: relative;
  z-index: 1;
  background: #fff;
  padding: 1.5rem 1.75rem 1.75rem;
  text-align: center;
}
.thankyou-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: #2d1b4e;
  margin: 0 0 0.5rem;
}
.thankyou-sub {
  font-size: 0.9375rem;
  font-weight: 400;
  color: #4a5568;
  margin: 0 0 1.25rem;
  line-height: 1.45;
}
.thankyou-dismiss {
  background: #FF319F;
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 0.55rem 1.5rem;
  font-size: 0.9375rem;
  font-weight: 600;
  cursor: pointer;
  font-family: inherit;
  transition: background 0.2s;
}
.thankyou-dismiss:hover {
  background: #e02d8d;
}

/* Share impact modal */
.share-impact-backdrop {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(6px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 1.5rem;
}
.share-impact-modal {
  position: relative;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
  max-width: 90vw;
  max-height: 90vh;
  overflow: auto;
  padding: 1.75rem 2rem 2rem;
}
.share-impact-close {
  position: absolute;
  top: 0.75rem;
  right: 0.75rem;
  width: 36px;
  height: 36px;
  padding: 0;
  border: none;
  background: none;
  font-size: 1.5rem;
  line-height: 1;
  color: #64748b;
  cursor: pointer;
  border-radius: 8px;
}
.share-impact-close:hover {
  color: #1a1a2e;
  background: #f1f5f9;
}
.share-impact-heading {
  font-size: 1.35rem;
  font-weight: 700;
  color: #1a1a2e;
  margin: 0 0 0.35rem;
}
.share-impact-sub {
  font-size: 0.9rem;
  color: #64748b;
  margin: 0 0 1.25rem;
}
.share-impact-generating {
  min-height: 280px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  color: #64748b;
  font-size: 0.95rem;
}
.share-impact-spinner {
  width: 40px;
  height: 40px;
  border: 3px solid #e2e8f0;
  border-top-color: #FF319F;
  border-radius: 50%;
  animation: share-impact-spin 0.8s linear infinite;
}
@keyframes share-impact-spin {
  to { transform: rotate(360deg); }
}
.share-impact-collage {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 4px;
  width: 100%;
  max-width: 600px;
  aspect-ratio: 3 / 2;
  background: #1a1a2e;
  border-radius: 12px;
  overflow: hidden;
  padding: 4px;
}
.share-impact-collage-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  background: #fff;
}
.share-impact-actions {
  display: flex;
  gap: 0.75rem;
  margin-top: 1.25rem;
  justify-content: center;
  flex-wrap: wrap;
}
.share-impact-download {
  background: #FF319F;
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 0.55rem 1.25rem;
  font-size: 0.9rem;
  font-weight: 600;
  cursor: pointer;
  font-family: inherit;
}
.share-impact-download:hover {
  background: #e02d8d;
}
.share-impact-dismiss {
  background: #f1f5f9;
  color: #334155;
  border: none;
  border-radius: 8px;
  padding: 0.55rem 1.25rem;
  font-size: 0.9rem;
  font-weight: 600;
  cursor: pointer;
  font-family: inherit;
}
.share-impact-dismiss:hover {
  background: #e2e8f0;
}
</style>
