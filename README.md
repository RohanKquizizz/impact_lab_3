# Impact Kits

Vue 3 components: Heat Map, Impact Story, ROI Calculator, Teacher Workflows, Wayground for Leaders.

## Run locally

```bash
npm install
npm run dev
```

Then open **http://localhost:5173** in your browser. Use the top nav to switch between kits.

## Build

```bash
npm run build
```

## Notes

- **Wayground for Leaders** uses placeholder images (Coach / IT Head / Principal). Replace with real assets in `src/components/WaygroundForLeaders.vue` if needed.
- **Teacher Workflows** uses a local stub for the dropdown (replacing `quizizz-ui`). Swap back to `quizizz-ui` if you have that package.
