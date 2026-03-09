<template>
  <div class="heat-map-container">
    <!-- Counter Ticker -->
    <div class="ticker-section">
      <p class="counter-label">Questions answered in the state of Texas</p>
      <div class="counter-billboard">
        <template v-for="(char, index) in counterDigits" :key="index">
          <span v-if="char === ','" class="counter-comma">,</span>
          <div v-else class="counter-slot">
            <div 
              class="counter-roll"
              :style="{ transform: `translateY(-${parseInt(char) * 10}%)` }"
            >
              <span v-for="n in 10" :key="n" class="counter-digit">{{ n - 1 }}</span>
            </div>
          </div>
        </template>
      </div>
    </div>

    <div class="map-wrapper">
      <!-- Legend Panel -->
      <div class="legend-panel">
        <div class="legend-header">
          <span class="legend-icon">●</span>
          <span>Point</span>
        </div>
        <div class="legend-subtitle">Based on <span class="legend-badge">district_segment</span></div>
        <div class="legend-items">
          <div class="legend-item">
            <span class="legend-dot customer" />
            <span>1. Active Districts</span>
          </div>
          <div class="legend-item">
            <span class="legend-dot density" />
            <span>2. High Engagement</span>
          </div>
          <div class="legend-item">
            <span class="legend-dot new-signup" />
            <span>3. New Districts</span>
          </div>
        </div>
      </div>

      <svg
        viewBox="0 0 900 700"
        class="region-map"
      >
        <!-- Background -->
        <rect x="0" y="0" width="900" height="700" fill="#f8f9ff" />
        
        <!-- Surrounding States (simplified paths) -->
        <!-- New Mexico -->
        <path
          :d="newMexicoPath"
          class="state-outline surrounding"
        />
        <text x="80" y="280" class="state-label">NEW MEXICO</text>
        
        <!-- Oklahoma -->
        <path
          :d="oklahomaPath"
          class="state-outline surrounding"
        />
        <text x="480" y="60" class="state-label">OKLAHOMA</text>
        
        <!-- Arkansas -->
        <path
          :d="arkansasPath"
          class="state-outline surrounding"
        />
        <text x="750" y="100" class="state-label">ARKANSAS</text>
        
        <!-- Louisiana -->
        <path
          :d="louisianaPath"
          class="state-outline surrounding"
        />
        <text x="780" y="340" class="state-label">LOUISIANA</text>
        
        <!-- Mexico (partial) -->
        <path
          :d="mexicoPath"
          class="state-outline mexico"
        />
        <text x="120" y="580" class="state-label mexico-label">MEXICO</text>
        
        <!-- Gulf of Mexico -->
        <text x="720" y="620" class="gulf-label">Gulf of</text>
        <text x="720" y="660" class="gulf-label">Mexico</text>
        
        <!-- Texas State -->
        <path
          :d="texasPath"
          class="state-outline texas"
        />
        <text x="420" y="340" class="texas-label">TEXAS</text>
        
        <!-- City Labels -->
        <g class="city-labels">
          <text x="160" y="150">Amarillo</text>
          <text x="280" y="250">Lubbock</text>
          <text x="230" y="340">Midland</text>
          <text x="330" y="280">Abilene</text>
          <text x="450" y="210">Fort Worth</text>
          <text x="530" y="210">Dallas</text>
          <text x="390" y="380">Austin</text>
          <text x="380" y="450">San Antonio</text>
          <text x="560" y="420">Houston</text>
          <text x="620" y="350">Beaumont</text>
          <text x="420" y="540">Corpus Christi</text>
          <text x="280" y="600">Laredo</text>
        </g>
        
        <!-- Scatter Points - Active Users (Blue) -->
        <g class="scatter-points">
          <circle
            v-for="point in scatterPoints.activeUsers"
            :key="'active-' + point.id"
            :cx="point.x"
            :cy="point.y"
            :r="4"
            class="point customer"
          />
        </g>
        
        <!-- Scatter Points - High Density (Green) -->
        <g class="scatter-points">
          <circle
            v-for="point in scatterPoints.highDensity"
            :key="'density-' + point.id"
            :cx="point.x"
            :cy="point.y"
            :r="4"
            class="point density"
          />
        </g>
        
        <!-- Scatter Points - New Districts (Yellow) -->
        <g class="scatter-points">
          <circle
            v-for="point in scatterPoints.newSignups"
            :key="'new-' + point.id"
            :cx="point.x"
            :cy="point.y"
            :r="4"
            class="point new-signup"
          />
        </g>
        
        <!-- Main District Hotspots -->
        <g
          v-for="district in districts"
          :key="district.id"
          class="hotspot-group"
          @mouseenter="handleDistrictHover(district, $event)"
          @mouseleave="activeDistrict = null"
        >
          <!-- Outer pulse ring -->
          <circle
            :cx="district.x"
            :cy="district.y"
            :r="district.size + 12"
            :class="['hotspot-pulse', district.type]"
          />
          <!-- Hotspot glow -->
          <circle
            :cx="district.x"
            :cy="district.y"
            :r="district.size + 8"
            :class="['hotspot-glow', district.type]"
          />
          <!-- Hotspot core -->
          <circle
            :cx="district.x"
            :cy="district.y"
            :r="district.size"
            :class="['hotspot-core', district.type]"
          />
        </g>
        
        <!-- Current Location Pin (Special marker) -->
        <g 
          class="current-location"
          @mouseenter="handleCurrentLocationHover($event)"
          @mouseleave="activeDistrict = null"
        >
          <!-- Pin shadow -->
          <ellipse
            :cx="currentLocation.x"
            :cy="currentLocation.y + 35"
            rx="12"
            ry="6"
            class="pin-shadow"
          />
          <!-- Pin body -->
          <path
            :d="getPinPath(currentLocation.x, currentLocation.y)"
            class="location-pin"
          />
          <!-- Pin inner circle -->
          <circle
            :cx="currentLocation.x"
            :cy="currentLocation.y - 20"
            r="10"
            class="pin-inner"
          />
          <!-- Pulse animation -->
          <circle
            :cx="currentLocation.x"
            :cy="currentLocation.y - 20"
            r="18"
            class="pin-pulse"
          />
        </g>
      </svg>
      
      <!-- Tooltip -->
      <div
        v-if="activeDistrict"
        class="tooltip"
        :style="tooltipStyle"
      >
        <div class="tooltip-header">{{ activeDistrict.name }}</div>
        <div class="tooltip-stats">
          <div class="stat-row">
            <span class="stat-label">Games Played:</span>
            <span class="stat-value">{{ formatNumber(activeDistrict.gamesPlayed) }}</span>
          </div>
          <div class="stat-row">
            <span class="stat-label">Total Students:</span>
            <span class="stat-value">{{ formatNumber(activeDistrict.totalStudents) }}</span>
          </div>
          <div class="stat-row">
            <span class="stat-label">Growth:</span>
            <span class="stat-value growth">+{{ activeDistrict.growthPercent }}%</span>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Current Location Card -->
    <div class="district-cards">
      <div class="district-card current">
        <div class="card-header">
          <span class="type-indicator customer" />
          <h3>{{ currentLocation.name }}</h3>
          <span class="current-badge">📍 You are here</span>
        </div>
        <div class="card-body">
          <div class="card-stat">
            <span class="card-stat-value">{{ formatNumber(currentLocation.gamesPlayed) }}</span>
            <span class="card-stat-label">Games Played</span>
          </div>
          <div class="card-stat">
            <span class="card-stat-value">{{ formatNumber(currentLocation.totalStudents) }}</span>
            <span class="card-stat-label">Total Students</span>
          </div>
          <div class="card-stat">
            <span class="card-stat-value growth">+{{ currentLocation.growthPercent }}%</span>
            <span class="card-stat-label">Growth</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, reactive, onMounted, onUnmounted } from 'vue';

// Counter ticker state
const counter = ref(80000000);
let counterInterval: ReturnType<typeof setInterval> | null = null;

const counterDigits = computed(() => {
  const formatted = counter.value.toLocaleString('en-US');
  return formatted.split('');
});

function incrementCounter() {
  const increment = Math.floor(Math.random() * 6) + 5;
  counter.value += increment;
}

// Data Model
export interface DistrictData {
  id: string;
  name: string;
  gamesPlayed: number;
  totalStudents: number;
  growthPercent: number;
  type: 'customer' | 'density' | 'new-signup';
  x: number;
  y: number;
  size: number;
  isCurrentLocation?: boolean;
}

interface ScatterPoint {
  id: number;
  x: number;
  y: number;
}

interface TooltipData {
  name: string;
  gamesPlayed: number;
  totalStudents: number;
  growthPercent: number;
}

// Current Location (Your district - Plano ISD)
const currentLocation = reactive({
  id: 'plano-isd',
  name: 'Plano ISD',
  x: 540,
  y: 195,
  gamesPlayed: 1250000,
  totalStudents: 52000,
  growthPercent: 15
});

// 5 Main District Hotspots
const districts = ref<DistrictData[]>([
  {
    id: 'houston-isd',
    name: 'Houston ISD',
    gamesPlayed: 4520000,
    totalStudents: 198000,
    growthPercent: 23,
    type: 'density',
    x: 570,
    y: 420,
    size: 14
  },
  {
    id: 'dallas-isd',
    name: 'Dallas ISD',
    gamesPlayed: 3875000,
    totalStudents: 145000,
    growthPercent: 18,
    type: 'density',
    x: 510,
    y: 205,
    size: 12
  },
  {
    id: 'austin-isd',
    name: 'Austin ISD',
    gamesPlayed: 2580000,
    totalStudents: 75000,
    growthPercent: 31,
    type: 'new-signup',
    x: 395,
    y: 385,
    size: 11
  },
  {
    id: 'san-antonio-isd',
    name: 'San Antonio ISD',
    gamesPlayed: 1850000,
    totalStudents: 48000,
    growthPercent: 12,
    type: 'customer',
    x: 380,
    y: 455,
    size: 10
  },
  {
    id: 'fort-worth-isd',
    name: 'Fort Worth ISD',
    gamesPlayed: 2210000,
    totalStudents: 82000,
    growthPercent: 8,
    type: 'customer',
    x: 455,
    y: 215,
    size: 10
  }
]);

// Generate scatter points for each category
const generateScatterPoints = (count: number, bounds: { minX: number; maxX: number; minY: number; maxY: number }): ScatterPoint[] => {
  const points: ScatterPoint[] = [];
  for (let i = 0; i < count; i++) {
    const x = bounds.minX + Math.random() * (bounds.maxX - bounds.minX);
    const y = bounds.minY + Math.random() * (bounds.maxY - bounds.minY);
    
    if (isInsideTexas(x, y)) {
      points.push({ id: i, x, y });
    }
  }
  return points;
};

// Rough check if point is inside Texas bounds
const isInsideTexas = (x: number, y: number): boolean => {
  if (x >= 160 && x <= 280 && y >= 100 && y <= 200) return true;
  if (x >= 280 && x <= 650 && y >= 150 && y <= 350) return true;
  if (x >= 250 && x <= 620 && y >= 350 && y <= 480) return true;
  if (x >= 280 && x <= 550 && y >= 480 && y <= 580) return true;
  if (x >= 400 && x <= 650 && y >= 400 && y <= 520) return true;
  return false;
};

const scatterPoints = reactive({
  activeUsers: generateScatterPoints(120, { minX: 180, maxX: 640, minY: 120, maxY: 560 }),
  highDensity: generateScatterPoints(80, { minX: 350, maxX: 600, minY: 180, maxY: 450 }),
  newSignups: generateScatterPoints(100, { minX: 200, maxX: 620, minY: 150, maxY: 520 })
});

const activeDistrict = ref<TooltipData | null>(null);
const tooltipPosition = ref({ x: 0, y: 0 });

// State paths (simplified)
const texasPath = `M 160 100 L 280 100 L 280 150 L 650 150 L 680 180 L 700 250 
  L 680 320 L 650 380 L 620 440 L 580 500 L 520 560 L 450 590 L 380 580 
  L 320 540 L 280 500 L 250 460 L 230 420 L 200 380 L 180 340 L 170 300 
  L 160 250 L 160 200 Z`;

const oklahomaPath = `M 280 20 L 700 20 L 700 150 L 650 150 L 280 150 L 280 100 L 160 100 L 160 60 L 280 60 Z`;

const newMexicoPath = `M 20 80 L 160 80 L 160 450 L 20 450 Z`;

const arkansasPath = `M 700 20 L 850 20 L 850 180 L 700 180 L 700 150 Z`;

const louisianaPath = `M 700 180 L 850 180 L 850 450 L 680 450 L 650 380 L 680 320 L 700 250 Z`;

const mexicoPath = `M 20 450 L 160 450 L 200 500 L 280 580 L 350 620 L 400 650 L 20 650 Z`;

// Generate pin path for current location (larger pin)
const getPinPath = (x: number, y: number): string => {
  return `M ${x} ${y} 
    C ${x - 18} ${y - 12} ${x - 18} ${y - 42} ${x} ${y - 48}
    C ${x + 18} ${y - 42} ${x + 18} ${y - 12} ${x} ${y}`;
};

// Handle hover events
const handleDistrictHover = (district: DistrictData, event: MouseEvent) => {
  activeDistrict.value = {
    name: district.name,
    gamesPlayed: district.gamesPlayed,
    totalStudents: district.totalStudents,
    growthPercent: district.growthPercent
  };
  updateTooltipPosition(event);
};

const handleCurrentLocationHover = (event: MouseEvent) => {
  activeDistrict.value = {
    name: currentLocation.name + ' (Your Location)',
    gamesPlayed: currentLocation.gamesPlayed,
    totalStudents: currentLocation.totalStudents,
    growthPercent: currentLocation.growthPercent
  };
  updateTooltipPosition(event);
};

const updateTooltipPosition = (event: MouseEvent) => {
  const rect = (event.currentTarget as Element).closest('.map-wrapper')?.getBoundingClientRect();
  if (rect) {
    tooltipPosition.value = {
      x: event.clientX - rect.left + 15,
      y: event.clientY - rect.top - 10
    };
  }
};

// Tooltip positioning
const tooltipStyle = computed(() => {
  if (!activeDistrict.value) return {};
  return {
    left: `${tooltipPosition.value.x}px`,
    top: `${tooltipPosition.value.y}px`
  };
});

// Format numbers
const formatNumber = (num: number): string => {
  return num.toLocaleString();
};

// Lifecycle hooks
onMounted(() => {
  counterInterval = setInterval(incrementCounter, 2000);
});

onUnmounted(() => {
  if (counterInterval) {
    clearInterval(counterInterval);
  }
});
</script>

<style scoped>
.heat-map-container {
  width: 100%;
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

/* Counter Ticker */
.ticker-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 1.5rem 0;
  margin-bottom: 1rem;
}

.counter-label {
  font-size: 2rem;
  font-weight: 600;
  color: #1E3A5F;
  margin: 0 0 1rem;
  line-height: 1.3;
  text-align: center;
}

.counter-billboard {
  display: flex;
  align-items: center;
  gap: 6px;
}

.counter-slot {
  width: 48px;
  height: 64px;
  background: white;
  border-radius: 6px;
  border: 1px solid rgba(139, 92, 246, 0.2);
  overflow: hidden;
  position: relative;
  box-shadow: 0 2px 4px rgba(139, 92, 246, 0.08);
}

.counter-roll {
  display: flex;
  flex-direction: column;
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.counter-digit {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 64px;
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 2.25rem;
  font-weight: 700;
  color: #8b5cf6;
  flex-shrink: 0;
}

.counter-comma {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 16px;
  font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 2.25rem;
  font-weight: 700;
  color: #6B7C93;
}

.map-wrapper {
  position: relative;
  background: linear-gradient(135deg, #f0f2ff 0%, #e8ebff 100%);
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(139, 92, 246, 0.1);
  border: 1px solid rgba(139, 92, 246, 0.15);
}

.region-map {
  width: 100%;
  height: auto;
  display: block;
}

/* State outlines */
.state-outline {
  stroke: #8b5cf6;
  stroke-width: 1;
  opacity: 0.6;
}

.state-outline.surrounding {
  fill: #f0f2ff;
}

.state-outline.texas {
  fill: #e8ebff;
  stroke: #8b5cf6;
  stroke-width: 1.5;
  opacity: 0.8;
}

.state-outline.mexico {
  fill: #f0f2ff;
}

/* Labels */
.state-label {
  font-size: 11px;
  font-weight: 600;
  fill: #6366f1;
  letter-spacing: 0.5px;
  opacity: 0.7;
}

.mexico-label {
  fill: #6366f1;
  opacity: 0.6;
}

.texas-label {
  font-size: 18px;
  font-weight: 700;
  fill: #8b5cf6;
  letter-spacing: 2px;
}

.gulf-label {
  font-size: 16px;
  font-style: italic;
  fill: #6366f1;
  opacity: 0.6;
}

.city-labels text {
  font-size: 13px;
  fill: #6366f1;
  font-weight: 600;
  opacity: 0.7;
}

/* Scatter points */
.point {
  opacity: 0.7;
}

.point.customer {
  fill: #8b5cf6;
}

.point.density {
  fill: #6366f1;
}

.point.new-signup {
  fill: #a78bfa;
}

/* Hotspots */
.hotspot-group {
  cursor: pointer;
}

.hotspot-pulse {
  opacity: 0;
  transform-box: fill-box;
  transform-origin: center;
  animation: hotspotPulse 2s ease-out infinite;
}

.hotspot-pulse.customer { fill: #8b5cf6; }
.hotspot-pulse.density { fill: #6366f1; }
.hotspot-pulse.new-signup { fill: #a78bfa; }

.hotspot-glow {
  opacity: 0.3;
  transform-box: fill-box;
  transform-origin: center;
  animation: hotspotGlow 2s ease-in-out infinite;
}

.hotspot-glow.customer { fill: #8b5cf6; }
.hotspot-glow.density { fill: #6366f1; }
.hotspot-glow.new-signup { fill: #a78bfa; }

.hotspot-core {
  opacity: 0.95;
  stroke: white;
  stroke-width: 2;
  transform-box: fill-box;
  transform-origin: center;
  animation: hotspotCore 2s ease-in-out infinite;
}

.hotspot-core.customer { fill: #8b5cf6; }
.hotspot-core.density { fill: #6366f1; }
.hotspot-core.new-signup { fill: #a78bfa; }

.hotspot-group:hover .hotspot-core {
  stroke-width: 3;
  filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
}

@keyframes hotspotPulse {
  0% {
    opacity: 0.5;
    transform: scale(1);
  }
  100% {
    opacity: 0;
    transform: scale(1.6);
  }
}

@keyframes hotspotGlow {
  0%, 100% {
    opacity: 0.3;
    transform: scale(1);
  }
  50% {
    opacity: 0.45;
    transform: scale(1.1);
  }
}

@keyframes hotspotCore {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
}

/* Current Location Pin */
.current-location {
  cursor: pointer;
}

.pin-shadow {
  fill: rgba(0, 0, 0, 0.25);
}

.location-pin {
  fill: #8b5cf6;
  stroke: white;
  stroke-width: 3;
  filter: drop-shadow(0 3px 6px rgba(139,92,246,0.4));
}

.pin-inner {
  fill: white;
}

.pin-pulse {
  fill: #8b5cf6;
  opacity: 0;
  animation: pinPulse 2s infinite;
}

@keyframes pinPulse {
  0% {
    opacity: 0.6;
    r: 18;
  }
  100% {
    opacity: 0;
    r: 40;
  }
}

.current-location:hover .location-pin {
  fill: #7c3aed;
  filter: drop-shadow(0 4px 8px rgba(139,92,246,0.5));
}

/* Legend Panel */
.legend-panel {
  position: absolute;
  top: 16px;
  right: 16px;
  background: white;
  color: #1e293b;
  padding: 14px 18px;
  border-radius: 12px;
  font-size: 13px;
  z-index: 10;
  min-width: 160px;
  box-shadow: 0 4px 16px rgba(139, 92, 246, 0.15);
  border: 1px solid rgba(139, 92, 246, 0.2);
}

.legend-header {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 600;
  margin-bottom: 4px;
  color: #1e293b;
}

.legend-icon {
  font-size: 10px;
  color: #8b5cf6;
}

.legend-subtitle {
  font-size: 11px;
  color: #64748b;
  margin-bottom: 12px;
}

.legend-badge {
  background: #f1f5f9;
  padding: 2px 8px;
  border-radius: 4px;
  font-family: monospace;
  font-size: 10px;
  color: #8b5cf6;
}

.legend-panel .legend-items {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.legend-panel .legend-item {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 12px;
  color: #475569;
}

.legend-panel .legend-dot {
  width: 14px;
  height: 14px;
  border-radius: 50%;
  flex-shrink: 0;
}

.legend-dot.customer {
  background: #8b5cf6;
}

.legend-dot.density {
  background: #6366f1;
}

.legend-dot.new-signup {
  background: #a78bfa;
}

/* Tooltip */
.tooltip {
  position: absolute;
  background: white;
  border-radius: 8px;
  padding: 12px 16px;
  box-shadow: 0 8px 24px rgba(139, 92, 246, 0.2);
  min-width: 200px;
  z-index: 100;
  pointer-events: none;
  border-left: 4px solid #8b5cf6;
}

.tooltip-header {
  font-size: 0.95rem;
  font-weight: 700;
  color: #1a1a2e;
  margin-bottom: 10px;
  padding-bottom: 8px;
  border-bottom: 1px solid #eee;
}

.tooltip-stats {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.stat-row {
  display: flex;
  justify-content: space-between;
}

.stat-label {
  color: #666;
  font-size: 0.8rem;
}

.stat-value {
  font-weight: 600;
  color: #333;
  font-size: 0.85rem;
}

.stat-value.growth {
  color: #8b5cf6;
}

/* District Cards */
.district-cards {
  margin-top: 1.5rem;
}

.district-card {
  background: white;
  border-radius: 12px;
  padding: 1rem 1.25rem;
  box-shadow: 0 2px 8px rgba(139, 92, 246, 0.08);
  border: 1px solid rgba(139, 92, 246, 0.15);
  transition: transform 0.2s, box-shadow 0.2s;
}

.district-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(139, 92, 246, 0.15);
}

.district-card.current {
  border: 1px solid rgba(139, 92, 246, 0.2);
  background: white;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  margin-bottom: 0.75rem;
  flex-wrap: wrap;
}

.type-indicator {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  flex-shrink: 0;
}

.type-indicator.customer { background: #8b5cf6; }
.type-indicator.density { background: #6366f1; }
.type-indicator.new-signup { background: #a78bfa; }

.card-header h3 {
  font-size: 0.9rem;
  font-weight: 600;
  color: #1a1a2e;
  margin: 0;
  flex: 1;
}

.current-badge {
  font-size: 0.7rem;
  background: #8b5cf6;
  color: white;
  padding: 2px 8px;
  border-radius: 12px;
  font-weight: 500;
}

.card-body {
  display: flex;
  justify-content: space-between;
}

.card-stat {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.card-stat-value {
  font-size: 1.1rem;
  font-weight: 700;
  color: #333;
}

.card-stat-value.growth {
  color: #8b5cf6;
}

.card-stat-label {
  font-size: 0.7rem;
  color: #888;
  margin-top: 0.2rem;
}

/* Responsive */
@media (max-width: 900px) {
  .counter-label {
    font-size: 1.5rem;
  }

  .counter-slot {
    width: 36px;
    height: 48px;
  }

  .counter-digit {
    width: 36px;
    height: 48px;
    font-size: 1.75rem;
  }

  .counter-comma {
    width: 12px;
    font-size: 1.75rem;
  }
}

@media (max-width: 600px) {
  .legend-panel {
    top: 8px;
    right: 8px;
    padding: 10px 14px;
    font-size: 11px;
  }

  .counter-label {
    font-size: 1.25rem;
  }

  .counter-slot {
    width: 28px;
    height: 40px;
  }

  .counter-digit {
    width: 28px;
    height: 40px;
    font-size: 1.35rem;
  }

  .counter-comma {
    width: 10px;
    font-size: 1.35rem;
  }
}
</style>
