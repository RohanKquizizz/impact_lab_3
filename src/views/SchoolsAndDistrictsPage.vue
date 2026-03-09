<template>
  <div class="schools-page">
    <!-- Back link (no full header) -->
    <a href="#" class="schools-back" @click.prevent="goBack">← Back to impact kits</a>

    <!-- Hero: two columns like Wayground – left: headline + CTA, right: product graphic -->
    <section class="schools-hero">
      <div class="schools-hero-inner">
        <div class="schools-hero-left">
          <h1 class="schools-hero-title">How Can Wayground help Oakland Middle School Succeed?</h1>
          <a href="#" class="schools-hero-cta">Get a quote</a>
        </div>
        <div class="schools-hero-right">
          <div class="hero-graphic">
            <div class="hero-graphic-bg" aria-hidden="true" />
            <div class="hero-card hero-card--dyslexia">
              <span class="hero-card-icon">Aa</span>
              <span class="hero-card-label">Dyslexia font</span>
              <div class="hero-card-avatar hero-card-avatar--sm" />
              <div class="hero-card-white">
                <span class="hero-card-type">Presentation</span>
                <strong>PROBABILITY</strong>
                <span class="hero-card-standards">CCSS - 7.EE.A.1</span>
              </div>
            </div>
            <div class="hero-btn-wrap hero-btn--passages">
              <span class="hero-btn-icon">📄</span>
              Passages
            </div>
            <div class="hero-dropdown">
              <span class="hero-dropdown-label">Enhance with AI</span>
              <span class="hero-dropdown-chevron">▼</span>
              <div class="hero-dropdown-menu">
                <span>Translate to Spanish</span>
                <span>Generate Flashcards</span>
                <span>Add similar questions</span>
              </div>
            </div>
            <div class="hero-progress-wrap">
              <div class="hero-progress-item">
                <span class="hero-progress-name">Jamie W</span>
                <div class="hero-progress-bar"><span class="hero-progress-fill hero-progress-fill--g" style="width: 30%" /><span class="hero-progress-fill hero-progress-fill--r" style="width: 70%" /></div>
                <span class="hero-progress-pct">30%</span>
              </div>
              <div class="hero-progress-item">
                <span class="hero-progress-name">Karan Sharma</span>
                <div class="hero-progress-bar"><span class="hero-progress-fill hero-progress-fill--o" style="width: 33%" /><span class="hero-progress-fill hero-progress-fill--g" style="width: 67%" /></div>
                <span class="hero-progress-pct">67%</span>
              </div>
            </div>
            <div class="hero-btn-wrap hero-btn--readaloud">
              <span class="hero-btn-icon">🔊</span>
              Read aloud
            </div>
            <div class="hero-card hero-card--photosynthesis">
              <div class="hero-card-avatar hero-card-avatar--sm" />
              <div class="hero-card-white hero-card-white--leaf">
                <span class="hero-card-type">Video</span>
                <strong>PHOTOSYNTHESIS</strong>
                <span class="hero-card-standards">CCSS - 7.EE.A.1</span>
              </div>
            </div>
            <div class="hero-btn-wrap hero-btn--assessments">
              <span class="hero-btn-icon">✓</span>
              Assessments
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Trust line -->
    <section class="schools-trust">
      <p class="schools-trust-text">Trusted by teachers in 90% of U.S. schools and 150+ countries.</p>
    </section>

    <!-- Feature sections -->
    <section class="schools-features">
      <div class="schools-feature">
        <h3>Support every way you teach and learn in one place</h3>
        <p>Use AI to tailor curriculum materials in minutes. Choose from 5 formats, 18 question types, and flexible modes.</p>
      </div>
      <div class="schools-feature">
        <h3>Accommodate students without singling them out</h3>
        <p>25+ built-in accommodations and modifications. Automatically create multiple versions for easy differentiation.</p>
      </div>
      <div class="schools-feature">
        <h3>Ensure fidelity with your standards and curriculum</h3>
        <p>Access a library of customizable standards-aligned resources. Get standards-aligned reporting supported by AI.</p>
      </div>
      <div class="schools-feature">
        <h3>No more password juggling or missing assignments</h3>
        <p>Wayground connects seamlessly to your school's existing ecosystem.</p>
      </div>
      <div class="schools-feature">
        <h3>Make privacy a priority</h3>
        <p>Enterprise-grade security, comprehensive data protection, and signed agreements that ensure your information remains yours.</p>
      </div>
    </section>

    <!-- Calculator section (replaces "Don't take it from us" testimonials) -->
    <section class="schools-calculator-section">
      <h2 class="schools-calculator-heading">Budget &amp; savings calculator</h2>
      <p class="schools-calculator-sub">See how much you can save by consolidating tools and streamlining curriculum with Wayground.</p>
      <div class="schools-calculator-wrap">
        <ROICalculatorInline />
      </div>
    </section>

    <!-- Explore more -->
    <section class="schools-explore">
      <h2 class="schools-explore-heading">Explore more from Wayground</h2>
      <div class="schools-explore-grid">
        <div class="schools-explore-card">
          <h3>Common Assessments</h3>
          <p>Assess student progress across schools and classrooms</p>
          <a href="#">Contact us</a>
        </div>
        <div class="schools-explore-card">
          <h3>Voyage Math</h3>
          <p>Math practice that actually meets students where they are</p>
          <a href="#">Learn more</a>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="schools-footer">
      <p>School &amp; District · Blog · For Business · About us · Help Center</p>
      <p class="schools-footer-legal">Terms of Service · Privacy Policy · 2025 Quizizz Inc. (DBA Wayground)</p>
    </footer>
  </div>
</template>

<script setup lang="ts">
import ROICalculatorInline from '../components/ROICalculatorInline.vue'

function goBack() {
  window.location.hash = ''
  window.dispatchEvent(new HashChangeEvent('hashchange'))
}
</script>

<style scoped>
.schools-page {
  min-height: 100vh;
  background: #fff;
  color: #1a1a2e;
}

.schools-back {
  position: fixed;
  top: 1rem;
  left: 1rem;
  z-index: 100;
  color: #4a144f;
  background: rgba(255, 255, 255, 0.95);
  padding: 0.4rem 0.85rem;
  border-radius: 999px;
  font-size: 0.875rem;
  text-decoration: none;
  font-weight: 500;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}
.schools-back:hover {
  background: #fff;
}

/* Hero: dark magenta, two columns – left text + CTA, right product graphic */
.schools-hero {
  background: #4a144f;
  min-height: 85vh;
  display: flex;
  align-items: center;
  padding: 3rem 2rem 4rem;
}
.schools-hero-inner {
  max-width: 1280px;
  margin: 0 auto;
  width: 100%;
  display: grid;
  grid-template-columns: 1fr 1.1fr;
  gap: 3rem;
  align-items: center;
}
@media (max-width: 900px) {
  .schools-hero-inner {
    grid-template-columns: 1fr;
    text-align: center;
  }
  .schools-hero-right {
    min-height: 380px;
  }
}
.schools-hero-left {
  padding-right: 1rem;
}
.schools-hero-title {
  font-size: clamp(1.75rem, 4vw, 2.75rem);
  font-weight: 700;
  line-height: 1.25;
  margin: 0 0 1.5rem;
  color: #fff;
}
.schools-hero-cta {
  display: inline-block;
  background: #ff319f;
  color: #fff;
  padding: 0.7rem 1.5rem;
  border-radius: 8px;
  font-weight: 600;
  text-decoration: none;
  font-size: 1rem;
}
.schools-hero-cta:hover {
  background: #e02d8d;
}

/* Right: product graphic mockup */
.schools-hero-right {
  position: relative;
  min-height: 420px;
}
.hero-graphic {
  position: relative;
  width: 100%;
  height: 100%;
  min-height: 380px;
  background: linear-gradient(135deg, #3d0f42 0%, #5a1a62 50%, #4a144f 100%);
  border-radius: 16px;
  overflow: hidden;
}
.hero-graphic-bg {
  position: absolute;
  inset: 0;
  background-image:
    linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px),
    linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px);
  background-size: 24px 24px;
  opacity: 0.6;
}
.hero-card {
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 0.35rem;
  z-index: 2;
}
.hero-card-icon {
  font-size: 1rem;
  font-weight: 700;
  color: #4a144f;
  background: #fff;
  padding: 0.2rem 0.4rem;
  border-radius: 4px;
}
.hero-card-label {
  font-size: 0.7rem;
  color: rgba(255,255,255,0.9);
}
.hero-card-avatar {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: linear-gradient(145deg, #c4b5c9, #8b7a8f);
}
.hero-card-avatar--sm {
  width: 24px;
  height: 24px;
}
.hero-card-white {
  background: #fff;
  color: #1a1a2e;
  padding: 0.5rem 0.65rem;
  border-radius: 8px;
  font-size: 0.7rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  display: flex;
  flex-direction: column;
  gap: 0.15rem;
}
.hero-card-white--leaf {
  background: linear-gradient(145deg, #e8f5e9 0%, #c8e6c9 100%);
}
.hero-card-type {
  font-size: 0.6rem;
  color: #64748b;
  text-transform: uppercase;
  letter-spacing: 0.03em;
}
.hero-card-standards {
  font-size: 0.6rem;
  color: #94a3b8;
}
.hero-card--dyslexia {
  top: 8%;
  left: 18%;
}
.hero-card--photosynthesis {
  bottom: 15%;
  right: 12%;
}
.hero-btn-wrap {
  position: absolute;
  display: flex;
  align-items: center;
  gap: 0.4rem;
  background: #fff;
  color: #1a1a2e;
  padding: 0.45rem 0.75rem;
  border-radius: 8px;
  font-size: 0.75rem;
  font-weight: 500;
  box-shadow: 0 2px 8px rgba(0,0,0,0.12);
  z-index: 2;
}
.hero-btn-icon {
  font-size: 0.9rem;
}
.hero-btn--passages {
  top: 12%;
  right: 20%;
}
.hero-btn--readaloud {
  bottom: 28%;
  right: 22%;
}
.hero-btn--assessments {
  bottom: 8%;
  left: 50%;
  transform: translateX(-50%);
}
.hero-dropdown {
  position: absolute;
  top: 22%;
  right: 20%;
  background: #fff;
  border-radius: 8px;
  padding: 0.4rem 0.6rem;
  font-size: 0.7rem;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 3;
}
.hero-dropdown-label {
  margin-right: 0.25rem;
}
.hero-dropdown-chevron {
  font-size: 0.6rem;
  color: #64748b;
}
.hero-dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  margin-top: 2px;
  background: #fff;
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  padding: 0.35rem 0;
  display: flex;
  flex-direction: column;
  gap: 0.2rem;
  padding-left: 0.6rem;
  font-size: 0.65rem;
  color: #475569;
}
.hero-progress-wrap {
  position: absolute;
  left: 15%;
  top: 42%;
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  z-index: 2;
}
.hero-progress-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.7rem;
  color: rgba(255,255,255,0.95);
}
.hero-progress-name {
  min-width: 72px;
}
.hero-progress-bar {
  width: 80px;
  height: 8px;
  border-radius: 4px;
  overflow: hidden;
  background: rgba(255,255,255,0.2);
  display: flex;
}
.hero-progress-fill {
  height: 100%;
}
.hero-progress-fill--g { background: #22c55e; }
.hero-progress-fill--r { background: #ef4444; }
.hero-progress-fill--o { background: #f97316; }
.hero-progress-pct {
  font-weight: 600;
  min-width: 28px;
}

.schools-trust {
  padding: 1.5rem 1.5rem 2rem;
  text-align: center;
  border-top: 1px solid #e2e8f0;
}
.schools-trust-text {
  font-size: 1rem;
  color: #64748b;
  margin: 0;
}

.schools-features {
  max-width: 900px;
  margin: 0 auto;
  padding: 2rem 1.5rem 3rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}
.schools-feature h3 {
  font-size: 1.25rem;
  font-weight: 700;
  margin: 0 0 0.5rem;
  color: #1a1a2e;
}
.schools-feature p {
  font-size: 0.9375rem;
  color: #475569;
  line-height: 1.6;
  margin: 0;
}

/* Calculator section - replaces testimonials, same dark purple background */
.schools-calculator-section {
  background: #4a144f;
  padding: 3rem 1.5rem 4rem;
  text-align: center;
}
.schools-calculator-heading {
  font-size: clamp(1.5rem, 3vw, 2rem);
  font-weight: 700;
  color: #fff;
  margin: 0 0 0.5rem;
}
.schools-calculator-sub {
  font-size: 1rem;
  color: rgba(255, 255, 255, 0.85);
  margin: 0 0 2rem;
  max-width: 560px;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 2rem;
}
.schools-calculator-wrap {
  max-width: 900px;
  margin: 0 auto;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
  overflow: hidden;
  padding: 1.5rem;
}

.schools-explore {
  padding: 3rem 1.5rem;
  max-width: 1000px;
  margin: 0 auto;
}
.schools-explore-heading {
  font-size: 1.5rem;
  font-weight: 700;
  text-align: center;
  margin: 0 0 2rem;
  color: #1a1a2e;
}
.schools-explore-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
}
.schools-explore-card {
  background: #f8fafc;
  border-radius: 12px;
  padding: 1.5rem;
  border: 1px solid #e2e8f0;
}
.schools-explore-card h3 {
  font-size: 1.125rem;
  font-weight: 700;
  margin: 0 0 0.5rem;
  color: #1a1a2e;
}
.schools-explore-card p {
  font-size: 0.9375rem;
  color: #64748b;
  margin: 0 0 1rem;
  line-height: 1.5;
}
.schools-explore-card a {
  color: #4a144f;
  font-weight: 600;
  font-size: 0.9375rem;
  text-decoration: none;
}
.schools-explore-card a:hover {
  text-decoration: underline;
}

.schools-footer {
  padding: 2rem 1.5rem;
  text-align: center;
  border-top: 1px solid #e2e8f0;
  background: #f8fafc;
}
.schools-footer p {
  font-size: 0.875rem;
  color: #64748b;
  margin: 0 0 0.5rem;
}
.schools-footer-legal {
  font-size: 0.8125rem;
  color: #94a3b8 !important;
}
</style>
