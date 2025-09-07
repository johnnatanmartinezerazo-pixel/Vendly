/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "class", // ✅ modo oscuro activado con clase
  content: [
    "./apps/frontend/index.html",
    "./apps/frontend/src/**/*.{js,ts,jsx,tsx}",
    "./apps/frontend/public/**/*.{html,js}"
  ],
  theme: {
    extend: {
      colors: {
        primary: "#1d4ed8",   // azul base
        secondary: "#9333ea", // púrpura
        accent: "#f59e0b",    // ámbar
        neutral: "#64748b",   // gris azulado neutro (útil para fondos/bordes)
        background: "#f9fafb" // fondo claro por defecto
      },
      fontFamily: {
        sans: ["Roboto Flex", "system-ui", "sans-serif"] // ✅ fuente moderna multiplataforma
      }
    }
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/container-queries"), // ✅ queries basadas en contenedores
    require("tailwindcss-animate")             // ✅ animaciones básicas
  ]
};
