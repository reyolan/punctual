module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/frontend/entrypoints/*.ts",
    "./app/views/**/*",
  ],
  theme: {
    extend: {
      gridTemplateColumns: {
        "auto-fill-64": "repeat(auto-fit, minmax(0, 280px))",
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
