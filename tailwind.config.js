/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,ts}",    // todos los componentes Angular
    "./public/index.html"      // si tienes HTML estáticos en public
  ],
  theme: {
    extend: {
      colors: {
        primary: "#1d4ed8",    // azul base
        secondary: "#9333ea",  // púrpura
        accent: "#f59e0b"      // ámbar
      },
      fontFamily: {
        sans: ["Inter", "sans-serif"]
      }
    }
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/aspect-ratio")
  ]
};