{
  "project_name": "XConvert - Smart Currency & Unit Converter",
  "description": "A responsive Flutter mobile app that converts currencies, lengths, weights, and temperatures, with real-time data, conversion formulas, and historical currency charts. Designed with best coding practices, a sleek UI, reusable components, and minimal code duplication.",
  "features": [
    "Convert currencies using a live exchange rate API",
    "Convert length, weight, and temperature with instant results",
    "Show conversion formulas or equations for learning purposes",
    "Display historical exchange rate charts for selected currencies",
    "Beautiful and responsive UI on all mobile screen sizes",
    "Interactive, card-based layout for conversions"
  ],
  "design": {
    "font_family": "Montserrat",
    "icon_pack": "Lucide (outlined)",
    "theme": "Custom app theme with consistent spacing, padding, and adaptive colors",
    "font_sizes": {
      "body": [12, 13],
      "heading": [14, 15, 16, 18]
    },
    "ui_components": [
      "Clean card widgets for each converter section",
      "Dropdowns, input fields, and toggles styled uniformly",
      "Beautiful icons for each unit type (currency, temperature, etc.)",
      "Consistent use of padding, shadows, and rounded corners (e.g., 2xl)"
    ]
  },
  "technical": {
    "framework": "Flutter",
    "state_management": "Provider or Riverpod",
    "architecture": "Modular folder structure with emphasis on reusability",
    "reusability": true,
    "code_style": {
      "minimize_code_repetition": true,
      "component_based": true,
      "organized": true
    },
    "responsive_design": true
  },
  "data_sources": {
    "currency_api": "ExchangeRate-API, exchangerate.host, or Open Exchange Rates",
    "unit_conversion": "Local conversion logic with hardcoded formulas or JSON maps",
    "historic_data_api": "Optional: exchangerate.host or any API that supports historical rates"
  },
  "screens": [
    {
      "name": "HomeScreen",
      "description": "Overview of all converter types (currency, length, weight, temperature)"
    },
    {
      "name": "ConverterScreen",
      "description": "Dynamic UI that adapts based on selected converter type, with input, dropdowns, and result display"
    },
    {
      "name": "FormulaDetailScreen",
      "description": "Popup or modal showing formula used in the conversion"
    },
    {
      "name": "HistoryChartScreen",
      "description": "Displays past currency trends in a line/bar chart format"
    },
    {
      "name": "SettingsScreen",
      "description": "Theme toggle, font size preferences, and app info"
    }
  ],
  "extra_notes": "Focus on clean design, efficient code, and high reusability. Avoid clutter. Ensure text sizing, padding, and layout adapt across devices using MediaQuery or LayoutBuilder."
}
