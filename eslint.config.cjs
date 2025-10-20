const js = require('@eslint/js');
const tsParser = require('@typescript-eslint/parser');
const tsPlugin = require('@typescript-eslint/eslint-plugin');
const reactHooks = require('eslint-plugin-react-hooks');
const reactRefresh = require('eslint-plugin-react-refresh');
const prettier = require('eslint-config-prettier');
const globals = require('globals');

const tsLanguageOptions = (options = {}) => ({
  parser: tsParser,
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
    ...options.parserOptions
  },
  globals: options.globals
});

module.exports = [
  {
    ignores: ['dist', 'build', 'out']
  },
  js.configs.recommended,
  {
    files: ['src/main/**/*.{ts,cts}', 'src/preload/**/*.{ts,cts}', 'vite.config.ts'],
    languageOptions: tsLanguageOptions({ globals: globals.node }),
    plugins: {
      '@typescript-eslint': tsPlugin
    },
    rules: {
      ...tsPlugin.configs.recommended.rules,
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }]
    }
  },
  {
    files: ['src/renderer/**/*.{ts,tsx}'],
    languageOptions: tsLanguageOptions({
      parserOptions: {
        ecmaFeatures: {
          jsx: true
        }
      },
      globals: { ...globals.browser, window: 'readonly', document: 'readonly' }
    }),
    plugins: {
      '@typescript-eslint': tsPlugin,
      'react-hooks': reactHooks,
      'react-refresh': reactRefresh
    },
    rules: {
      ...tsPlugin.configs.recommended.rules,
      ...reactHooks.configs.recommended.rules,
      ...reactRefresh.configs.recommended.rules,
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }]
    }
  },
  prettier
];
