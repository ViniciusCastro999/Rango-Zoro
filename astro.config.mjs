import { defineConfig } from 'astro/config';

// Servido pelo GitHub Pages em https://viniciuscastro999.github.io/Rango-Zoro/
export default defineConfig({
  site: 'https://viniciuscastro999.github.io',
  base: '/Rango-Zoro',
  trailingSlash: 'ignore',
  build: { format: 'directory' },
});
