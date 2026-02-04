<script setup>
const brands = [
  { id: 'fitter', name: 'Fitter', tagline: 'Tu progreso, medido', color: '#a3e635', icon: '🏋️' },
  { id: 'vegy', name: 'Vegy', tagline: 'Productos orgánicos a tu puerta', color: '#22c55e', icon: '🌿' },
  { id: 'habito', name: 'Habito', tagline: 'Gamifica tu productividad', color: '#3b82f6', icon: '✓' },
]
</script>

<template>
  <div class="min-h-screen bg-zinc-950 p-8">
    <div class="max-w-4xl mx-auto">
      <h1 class="text-4xl font-bold text-white mb-2">Brand Preview</h1>
      <p class="text-zinc-500 mb-12">codeCave brand assets</p>
      
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <router-link
          v-for="brand in brands"
          :key="brand.id"
          :to="`/${brand.id}`"
          class="bg-zinc-900 rounded-2xl p-6 hover:bg-zinc-800 transition border border-zinc-800 group"
        >
          <div 
            class="w-14 h-14 rounded-xl flex items-center justify-center mb-4 text-2xl"
            :style="{ backgroundColor: brand.color + '20' }"
          >
            {{ brand.icon }}
          </div>
          <h2 class="text-lg font-semibold text-white group-hover:text-zinc-100">{{ brand.name }}</h2>
          <p class="text-zinc-500 text-sm mt-1">{{ brand.tagline }}</p>
          <p class="text-zinc-600 text-xs mt-3 group-hover:text-zinc-500">View assets →</p>
        </router-link>
      </div>
    </div>
  </div>
</template>
