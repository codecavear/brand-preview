<script setup>
const brands = [
  { 
    id: 'fitter', 
    name: 'Fitter', 
    tagline: 'Tu progreso, medido', 
    color: '#a3e635',
    bg: '#111827',
    iconUrl: 'https://api.iconify.design/lucide/dumbbell.svg'
  },
  { 
    id: 'vegy', 
    name: 'Vegy', 
    tagline: 'Productos orgánicos a tu puerta', 
    color: '#22c55e',
    bg: '#14532d',
    iconUrl: 'https://api.iconify.design/lucide/leaf.svg'
  },
  { 
    id: 'habito', 
    name: 'Habito', 
    tagline: 'Gamifica tu productividad', 
    color: '#3b82f6',
    bg: '#0f172a',
    iconUrl: 'https://api.iconify.design/lucide/check-square.svg'
  },
  { 
    id: 'quests', 
    name: 'Quests', 
    tagline: 'Organize Epic Game Nights', 
    color: '#d4a574',
    bg: '#111827',
    iconUrl: 'https://api.iconify.design/lucide/scroll.svg'
  },
  { 
    id: 'asistente', 
    name: 'Asistente', 
    tagline: 'Tu asistente AI 24/7', 
    color: '#8b5cf6',
    bg: '#0f172a',
    iconUrl: 'https://api.iconify.design/lucide/bot.svg'
  },
  { 
    id: 'reportar', 
    name: 'Reportar', 
    tagline: 'Tu voz cuenta', 
    color: '#f59e0b',
    bg: '#111827',
    iconUrl: 'https://api.iconify.design/lucide/alert-triangle.svg'
  },
  { 
    id: 'truco', 
    name: 'Truco', 
    tagline: 'Contador de truco argentino', 
    color: '#ef4444',
    bg: '#111827',
    iconUrl: 'https://api.iconify.design/lucide/spade.svg'
  },
  { 
    id: 'turnosmed', 
    name: 'TurnosMed', 
    tagline: 'Gestión de turnos médicos', 
    color: '#4caf50',
    bg: '#111827',
    iconUrl: 'https://api.iconify.design/lucide/stethoscope.svg'
  },
]

const iconWithColor = (url, color) => `${url}?color=${encodeURIComponent(color)}`
</script>

<template>
  <div class="min-h-screen bg-zinc-950 p-6 sm:p-8">
    <div class="max-w-4xl mx-auto">
      <h1 class="text-3xl sm:text-4xl font-bold text-white mb-2">Brand Preview</h1>
      <p class="text-zinc-500 mb-8 sm:mb-12">codeCave brand assets</p>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <router-link
          v-for="brand in brands"
          :key="brand.id"
          :to="`/${brand.id}`"
          class="bg-zinc-900 rounded-2xl overflow-hidden hover:bg-zinc-800 transition border border-zinc-800 group"
        >
          <!-- Logo horizontal preview -->
          <div 
            class="h-24 flex items-center gap-4 px-6"
            :style="{ backgroundColor: brand.bg }"
          >
            <img :src="iconWithColor(brand.iconUrl, brand.color)" class="w-10 h-10" />
            <span class="text-2xl font-bold text-white">{{ brand.name }}</span>
          </div>
          
          <!-- Card content -->
          <div class="p-5">
            <p class="text-zinc-400 text-sm">{{ brand.tagline }}</p>
            <p class="text-zinc-600 text-xs mt-3 group-hover:text-zinc-500">View assets →</p>
          </div>
        </router-link>
      </div>
    </div>
  </div>
</template>
