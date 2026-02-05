<script setup>
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const brandId = computed(() => route.params.brand)

const configs = {
  fitter: {
    name: 'Fitter',
    tagline: 'Tu progreso, medido',
    headline: ['Tu fuerza.', 'Tu control.'],
    domain: 'fitter.ar',
    icon: '🏋️',
    iconUrl: 'https://api.iconify.design/lucide/dumbbell.svg',
    font: 'Inter',
    colors: { primary: '#a3e635', bg: '#111827', surface: '#1f2937', text: '#ffffff', muted: '#9ca3af' }
  },
  vegy: {
    name: 'Vegy',
    tagline: 'Crea tu tienda vegana',
    headline: ['Tu tienda.', 'Tu comunidad.'],
    domain: 'vegy.ar',
    icon: '🌿',
    iconUrl: 'https://api.iconify.design/lucide/leaf.svg',
    font: 'Inter',
    colors: { primary: '#22c55e', bg: '#14532d', surface: '#166534', text: '#ffffff', muted: '#86efac' }
  },
  habito: {
    name: 'Habito',
    tagline: 'Gamifica tu productividad',
    headline: ['Tus tareas.', 'Tu juego.'],
    domain: 'habito.ar',
    icon: '✓',
    iconUrl: 'https://api.iconify.design/lucide/check-square.svg',
    font: 'Inter',
    colors: { primary: '#3b82f6', bg: '#0f172a', surface: '#1e293b', text: '#ffffff', muted: '#94a3b8' }
  },
  reportar: {
    name: 'Reportar',
    tagline: 'Tu voz cuenta',
    headline: ['Denuncia problemas.', 'Mejora tu ciudad.'],
    domain: 'reportar.ar',
    icon: '📢',
    iconUrl: 'https://api.iconify.design/lucide/megaphone.svg',
    font: 'Inter',
    colors: { primary: '#f59e0b', bg: '#111827', surface: '#1f2937', text: '#ffffff', muted: '#9ca3af' }
  },
  asistente: {
    name: 'Asistente',
    tagline: 'Tu asistente AI 24/7',
    headline: ['Atención inmediata.', 'Siempre disponible.'],
    domain: 'asistente.ar',
    icon: '🤖',
    iconUrl: 'https://api.iconify.design/lucide/bot.svg',
    font: 'Inter',
    colors: { primary: '#8b5cf6', bg: '#0f172a', surface: '#1e293b', text: '#ffffff', muted: '#94a3b8' }
  },
  quests: {
    name: 'Quests',
    tagline: 'Organize Epic Game Nights',
    headline: ['Plan adventures.', 'Play together.'],
    domain: 'quests.ar',
    icon: '📜',
    iconUrl: 'https://api.iconify.design/lucide/scroll.svg',
    font: 'Inter',
    colors: { primary: '#eab308', bg: '#111827', surface: '#1f2937', text: '#ffffff', muted: '#9ca3af' }
  },
  turnosmed: {
    name: 'TurnosMed',
    tagline: 'Organiza tus citas médicas fácilmente',
    headline: ['Simplifica la gestión de turnos.', 'Mejora la atención al paciente.'],
    domain: 'turnosmed.ar',
    icon: '🩺',
    iconUrl: 'https://api.iconify.design/lucide/stethoscope.svg',
    font: 'Inter',
    colors: { primary: '#4caf50', bg: '#111827', surface: '#1f2937', text: '#ffffff', muted: '#9ca3af' }
  },
  truco: {
    name: 'Truco',
    tagline: 'El contador más simple',
    headline: ['Sin lápiz.', 'Sin papel.'],
    domain: 'truco.codecave.ar',
    icon: '🗡️',
    iconUrl: 'https://api.iconify.design/game-icons/gladius.svg',
    font: 'Inter',
    colors: { primary: '#6cace4', bg: '#1e3a5f', surface: '#2d4a6f', text: '#ffffff', muted: '#94a3b8' }
  },
  gamescave: {
    name: 'gamesCave',
    tagline: 'Tu cueva de juegos',
    headline: ['Play.', 'Compete. Fun.'],
    domain: 'games.codecave.ar',
    icon: '🎮',
    iconUrl: 'https://api.iconify.design/lucide/gamepad-2.svg',
    font: 'Inter',
    colors: { primary: '#8b5cf6', bg: '#1e1b4b', surface: '#2e2a5b', text: '#ffffff', muted: '#94a3b8' }
  }
}

const brand = computed(() => configs[brandId.value] || configs.fitter)
const radius = ref(20)

const iconWithColor = (color) => `${brand.value.iconUrl}?color=${encodeURIComponent(color)}`

// Export functions
const downloadSvg = async (url, filename) => {
  const response = await fetch(url)
  const blob = await response.blob()
  const link = document.createElement('a')
  link.href = URL.createObjectURL(blob)
  link.download = filename
  link.click()
}

const exportIcon = (color, name) => {
  const url = iconWithColor(color)
  downloadSvg(url, `${brandId.value}-icon-${name}.svg`)
}

const exportLogoHorizontal = async (variant) => {
  // Create canvas for horizontal logo
  const canvas = document.createElement('canvas')
  canvas.width = 400
  canvas.height = 100
  const ctx = canvas.getContext('2d')
  
  // Background
  if (variant === 'dark') {
    ctx.fillStyle = brand.value.colors.bg
    ctx.fillRect(0, 0, 400, 100)
  } else if (variant === 'light') {
    ctx.fillStyle = '#ffffff'
    ctx.fillRect(0, 0, 400, 100)
  }
  // transparent: no background
  
  // Load icon
  const img = new Image()
  img.crossOrigin = 'anonymous'
  const iconColor = variant === 'light' ? '#000000' : brand.value.colors.primary
  img.src = iconWithColor(iconColor)
  
  await new Promise(resolve => { img.onload = resolve })
  
  // Draw icon
  ctx.drawImage(img, 20, 18, 64, 64)
  
  // Draw text
  ctx.font = 'bold 42px Inter, system-ui, sans-serif'
  ctx.fillStyle = variant === 'light' ? '#000000' : brand.value.colors.text
  ctx.fillText(brand.value.name, 100, 62)
  
  // Download
  const link = document.createElement('a')
  link.download = `${brandId.value}-logo-horizontal-${variant}.png`
  link.href = canvas.toDataURL('image/png')
  link.click()
}

const exportSquareIcon = async (iconColor, bgColor, name) => {
  const canvas = document.createElement('canvas')
  canvas.width = 512
  canvas.height = 512
  const ctx = canvas.getContext('2d')
  
  // Background with border radius
  const r = (radius.value / 100) * 256
  ctx.fillStyle = bgColor
  ctx.beginPath()
  ctx.roundRect(0, 0, 512, 512, r)
  ctx.fill()
  
  // Load and draw icon
  const img = new Image()
  img.crossOrigin = 'anonymous'
  img.src = iconWithColor(iconColor)
  
  await new Promise(resolve => { img.onload = resolve })
  ctx.drawImage(img, 128, 128, 256, 256)
  
  // Download
  const link = document.createElement('a')
  link.download = `${brandId.value}-icon-square-${name}.png`
  link.href = canvas.toDataURL('image/png')
  link.click()
}
</script>

<template>
  <div class="min-h-screen bg-zinc-950 text-zinc-300">
    <!-- Header -->
    <header class="border-b border-zinc-800 p-6">
      <div class="max-w-5xl mx-auto flex items-center justify-between">
        <div class="flex items-center gap-4">
          <router-link to="/" class="text-zinc-500 hover:text-white text-xl">←</router-link>
          <span class="text-2xl">{{ brand.icon }}</span>
          <h1 class="text-2xl font-bold text-white">{{ brand.name }}</h1>
        </div>
        <span class="text-zinc-500 hidden sm:block">{{ brand.tagline }}</span>
      </div>
    </header>

    <main class="max-w-5xl mx-auto p-4 sm:p-8 space-y-12 sm:space-y-16">
      <!-- Colors -->
      <section>
        <h2 class="text-xs font-semibold text-zinc-500 uppercase tracking-wider mb-6">🎨 Colors</h2>
        <div class="flex gap-4 flex-wrap">
          <div v-for="(color, name) in brand.colors" :key="name" class="w-20 sm:w-24">
            <div 
              class="h-14 sm:h-16 rounded-xl mb-2" 
              :style="{ backgroundColor: color, border: color === '#ffffff' ? '1px solid #333' : '' }" 
            />
            <p class="text-sm font-medium capitalize">{{ name }}</p>
            <p class="text-xs text-zinc-600 font-mono">{{ color }}</p>
          </div>
        </div>
      </section>

      <!-- Logo Horizontal -->
      <section>
        <h2 class="text-xs font-semibold text-zinc-500 uppercase tracking-wider mb-6">📐 Logo Horizontal</h2>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
          <!-- Dark bg -->
          <div class="bg-zinc-900 rounded-xl p-6">
            <div 
              class="h-20 rounded-lg flex items-center gap-4 px-6 mb-4"
              :style="{ backgroundColor: brand.colors.bg }"
            >
              <img :src="iconWithColor(brand.colors.primary)" class="w-10 h-10" />
              <span class="text-2xl font-bold" :style="{ color: brand.colors.text }">{{ brand.name }}</span>
            </div>
            <div class="flex justify-between items-center">
              <p class="text-sm text-zinc-500">Dark background</p>
              <button @click="exportLogoHorizontal('dark')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-3 py-1.5 rounded-lg">
                Export PNG
              </button>
            </div>
          </div>
          <!-- Light bg -->
          <div class="bg-zinc-900 rounded-xl p-6">
            <div class="h-20 rounded-lg flex items-center gap-4 px-6 mb-4 bg-white">
              <img :src="iconWithColor('#000000')" class="w-10 h-10" />
              <span class="text-2xl font-bold text-black">{{ brand.name }}</span>
            </div>
            <div class="flex justify-between items-center">
              <p class="text-sm text-zinc-500">Light background</p>
              <button @click="exportLogoHorizontal('light')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-3 py-1.5 rounded-lg">
                Export PNG
              </button>
            </div>
          </div>
          <!-- Transparent -->
          <div class="bg-zinc-900 rounded-xl p-6">
            <div class="h-20 rounded-lg flex items-center gap-4 px-6 mb-4 bg-[repeating-conic-gradient(#262626_0%_25%,#1a1a1a_0%_50%)] bg-[length:16px_16px]">
              <img :src="iconWithColor(brand.colors.primary)" class="w-10 h-10" />
              <span class="text-2xl font-bold text-white">{{ brand.name }}</span>
            </div>
            <div class="flex justify-between items-center">
              <p class="text-sm text-zinc-500">Transparent</p>
              <button @click="exportLogoHorizontal('transparent')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-3 py-1.5 rounded-lg">
                Export PNG
              </button>
            </div>
          </div>
        </div>
      </section>

      <!-- Icon Transparent -->
      <section>
        <h2 class="text-xs font-semibold text-zinc-500 uppercase tracking-wider mb-6">🎯 Icon - Transparent</h2>
        <div class="grid grid-cols-3 gap-4 sm:gap-6">
          <div class="bg-zinc-900 rounded-xl p-4 sm:p-6 text-center">
            <div class="inline-block p-3 sm:p-4 rounded-lg mb-3 bg-[repeating-conic-gradient(#262626_0%_25%,#1a1a1a_0%_50%)] bg-[length:16px_16px]">
              <img :src="iconWithColor(brand.colors.primary)" class="w-12 sm:w-16 h-12 sm:h-16" />
            </div>
            <p class="font-medium text-sm mb-2">Primary</p>
            <button @click="exportIcon(brand.colors.primary, 'primary')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-3 py-1.5 rounded-lg">
              SVG
            </button>
          </div>
          <div class="bg-zinc-900 rounded-xl p-4 sm:p-6 text-center">
            <div class="inline-block p-3 sm:p-4 rounded-lg mb-3 bg-[repeating-conic-gradient(#262626_0%_25%,#1a1a1a_0%_50%)] bg-[length:16px_16px]">
              <img :src="iconWithColor('#ffffff')" class="w-12 sm:w-16 h-12 sm:h-16" />
            </div>
            <p class="font-medium text-sm mb-2">White</p>
            <button @click="exportIcon('#ffffff', 'white')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-3 py-1.5 rounded-lg">
              SVG
            </button>
          </div>
          <div class="bg-zinc-900 rounded-xl p-4 sm:p-6 text-center">
            <div class="inline-block p-3 sm:p-4 rounded-lg mb-3 bg-zinc-100">
              <img :src="iconWithColor('#000000')" class="w-12 sm:w-16 h-12 sm:h-16" />
            </div>
            <p class="font-medium text-sm mb-2">Black</p>
            <button @click="exportIcon('#000000', 'black')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-3 py-1.5 rounded-lg">
              SVG
            </button>
          </div>
        </div>
      </section>

      <!-- Icon Square -->
      <section>
        <h2 class="text-xs font-semibold text-zinc-500 uppercase tracking-wider mb-4">📦 Icon - Square</h2>
        <div class="flex items-center gap-4 mb-6">
          <span class="text-sm text-zinc-500">Border Radius:</span>
          <input type="range" v-model="radius" min="0" max="50" class="w-32 sm:w-40 accent-zinc-500" />
          <span class="text-sm text-zinc-600 font-mono">{{ radius }}%</span>
        </div>
        <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 sm:gap-6">
          <div class="bg-zinc-900 rounded-xl p-4 sm:p-5 text-center">
            <div 
              class="w-16 sm:w-20 h-16 sm:h-20 mx-auto mb-3 flex items-center justify-center" 
              :style="{ backgroundColor: brand.colors.bg, borderRadius: radius + '%' }"
            >
              <img :src="iconWithColor(brand.colors.primary)" class="w-8 sm:w-10 h-8 sm:h-10" />
            </div>
            <p class="text-xs sm:text-sm mb-2">Primary + Dark</p>
            <button @click="exportSquareIcon(brand.colors.primary, brand.colors.bg, 'primary-dark')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-2 py-1 rounded">
              PNG
            </button>
          </div>
          <div class="bg-zinc-900 rounded-xl p-4 sm:p-5 text-center">
            <div 
              class="w-16 sm:w-20 h-16 sm:h-20 mx-auto mb-3 flex items-center justify-center bg-white" 
              :style="{ borderRadius: radius + '%' }"
            >
              <img :src="iconWithColor(brand.colors.primary)" class="w-8 sm:w-10 h-8 sm:h-10" />
            </div>
            <p class="text-xs sm:text-sm mb-2">Primary + Light</p>
            <button @click="exportSquareIcon(brand.colors.primary, '#ffffff', 'primary-light')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-2 py-1 rounded">
              PNG
            </button>
          </div>
          <div class="bg-zinc-900 rounded-xl p-4 sm:p-5 text-center">
            <div 
              class="w-16 sm:w-20 h-16 sm:h-20 mx-auto mb-3 flex items-center justify-center" 
              :style="{ backgroundColor: brand.colors.bg, borderRadius: radius + '%' }"
            >
              <img :src="iconWithColor('#ffffff')" class="w-8 sm:w-10 h-8 sm:h-10" />
            </div>
            <p class="text-xs sm:text-sm mb-2">White + Dark</p>
            <button @click="exportSquareIcon('#ffffff', brand.colors.bg, 'white-dark')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-2 py-1 rounded">
              PNG
            </button>
          </div>
          <div class="bg-zinc-900 rounded-xl p-4 sm:p-5 text-center">
            <div 
              class="w-16 sm:w-20 h-16 sm:h-20 mx-auto mb-3 flex items-center justify-center bg-zinc-100" 
              :style="{ borderRadius: radius + '%' }"
            >
              <img :src="iconWithColor('#000000')" class="w-8 sm:w-10 h-8 sm:h-10" />
            </div>
            <p class="text-xs sm:text-sm mb-2">Black + Light</p>
            <button @click="exportSquareIcon('#000000', '#f4f4f5', 'black-light')" class="text-xs bg-zinc-800 hover:bg-zinc-700 px-2 py-1 rounded">
              PNG
            </button>
          </div>
        </div>
      </section>

      <!-- Browser Tab -->
      <section>
        <h2 class="text-xs font-semibold text-zinc-500 uppercase tracking-wider mb-6">🌐 Browser Tab</h2>
        <div class="bg-zinc-900 rounded-xl overflow-hidden max-w-2xl">
          <div class="bg-zinc-800 px-4 py-3 flex items-center gap-3">
            <div class="flex gap-1.5">
              <div class="w-3 h-3 rounded-full bg-red-500" />
              <div class="w-3 h-3 rounded-full bg-yellow-500" />
              <div class="w-3 h-3 rounded-full bg-green-500" />
            </div>
            <div class="bg-zinc-900 px-4 py-2 rounded-t-lg flex items-center gap-2 text-sm text-zinc-300">
              <img :src="iconWithColor(brand.colors.primary)" class="w-4 h-4" />
              <span class="truncate">{{ brand.name }} - {{ brand.tagline }}</span>
            </div>
          </div>
          <div class="h-32 flex items-center justify-center text-zinc-600" :style="{ backgroundColor: brand.colors.bg }">
            Your site content
          </div>
        </div>
      </section>

      <!-- Mobile -->
      <section>
        <h2 class="text-xs font-semibold text-zinc-500 uppercase tracking-wider mb-6">📱 Mobile</h2>
        <div class="flex gap-8 sm:gap-12 flex-wrap">
          <!-- Phone Home Screen -->
          <div class="bg-zinc-800 rounded-[36px] p-2.5 w-56 sm:w-64 shrink-0">
            <div class="bg-black rounded-[28px] overflow-hidden">
              <div class="px-5 py-2 flex justify-between text-[10px] font-medium text-white">
                <span>9:41</span><span>📶 🔋</span>
              </div>
              <div class="px-3 sm:px-4 py-3">
                <div class="grid grid-cols-4 gap-3 sm:gap-4">
                  <div v-for="(app, i) in [
                    { bg: '#FF2D55', emoji: '🎵', name: 'Music' },
                    { bg: '#5856D6', emoji: '🎙️', name: 'Podcasts' },
                    { bg: brand.colors.bg, emoji: brand.icon, name: brand.name, isApp: true },
                    { bg: '#34C759', emoji: '❤️', name: 'Health' },
                    { bg: '#007AFF', emoji: '🌐', name: 'Safari' },
                    { bg: '#FF9500', emoji: '📝', name: 'Notes' },
                    { bg: '#5AC8FA', emoji: '🌤️', name: 'Weather' },
                    { bg: '#FF3B30', emoji: '📷', name: 'Photos' }
                  ]" :key="i" class="text-center">
                    <div 
                      class="w-10 sm:w-12 h-10 sm:h-12 mx-auto mb-1 flex items-center justify-center text-base sm:text-lg"
                      :style="{ backgroundColor: app.bg, borderRadius: app.isApp ? radius + '%' : '22%' }"
                    >
                      <img v-if="app.isApp" :src="iconWithColor(brand.colors.primary)" class="w-5 sm:w-6 h-5 sm:h-6" />
                      <span v-else>{{ app.emoji }}</span>
                    </div>
                    <span class="text-[8px] sm:text-[9px] text-white">{{ app.name }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- PWA Splash -->
          <div class="shrink-0">
            <p class="text-[10px] text-zinc-600 uppercase mb-2">PWA Splash</p>
            <div 
              class="w-56 sm:w-64 h-80 sm:h-96 rounded-3xl flex flex-col items-center justify-center gap-4" 
              :style="{ backgroundColor: brand.colors.bg }"
            >
              <img :src="iconWithColor(brand.colors.primary)" class="w-10 sm:w-12 h-10 sm:h-12" />
              <span class="text-lg sm:text-xl font-bold" :style="{ color: brand.colors.text }">{{ brand.name }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- OG Image Preview -->
      <section>
        <h2 class="text-xs font-semibold text-zinc-500 uppercase tracking-wider mb-6">🐦 OG Image Preview</h2>
        <div class="bg-zinc-900 rounded-xl overflow-hidden max-w-xl">
          <div class="p-4 border-b border-zinc-800 flex items-center gap-3">
            <div class="w-10 h-10 rounded-full bg-zinc-700" />
            <div>
              <p class="font-medium text-sm text-white">codeCave</p>
              <p class="text-zinc-500 text-xs">@codecavear</p>
            </div>
          </div>
          <p class="px-4 py-3 text-zinc-400 text-sm">Check out {{ brand.name }}! 🚀</p>
          <div class="mx-4 mb-4 border border-zinc-800 rounded-xl overflow-hidden">
            <div 
              class="h-40 sm:h-48 p-4 sm:p-6 flex items-center gap-4 sm:gap-8" 
              :style="{ background: `linear-gradient(135deg, ${brand.colors.bg}, ${brand.colors.surface})` }"
            >
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-2 sm:mb-3">
                  <img :src="iconWithColor(brand.colors.primary)" class="w-6 sm:w-8 h-6 sm:h-8" />
                  <span class="text-lg sm:text-xl font-bold" :style="{ color: brand.colors.text }">{{ brand.name }}</span>
                </div>
                <h3 class="text-xl sm:text-2xl font-bold mb-1" :style="{ color: brand.colors.text }">
                  {{ brand.headline[0] }}<br>
                  <span :style="{ color: brand.colors.primary }">{{ brand.headline[1] }}</span>
                </h3>
                <p class="text-xs sm:text-sm" :style="{ color: brand.colors.muted }">{{ brand.tagline }}</p>
              </div>
            </div>
            <div class="bg-zinc-800/50 p-3">
              <p class="text-zinc-500 text-xs uppercase">{{ brand.domain }}</p>
              <p class="font-medium text-sm text-white">{{ brand.name }} - {{ brand.tagline }}</p>
            </div>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>
