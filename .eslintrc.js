module.exports = {
  env: {
    commonjs: true,
    es6: true,
    node: true,
    jest: true,
    'cypress/globals': true
  },
  extends: [
    'eslint:recommended',
    'plugin:jest/recommended',
    'plugin:prettier/recommended'
  ],
  globals: {
    Atomics: 'readonly',
    SharedArrayBuffer: 'readonly',
    'jest/globals': true,
    document: true
  },
  parserOptions: {
    ecmaVersion: 2020
  },
  plugins: ['prettier', 'jest', 'cypress'],
  rules: {
    'prettier/prettier': ['error'],
    'require-atomic-updates': 'off',
    'no-unused-vars': ['error', { args: 'after-used' }]
  },
  ignorePatterns: [
    '*.spec.js',
    '*.min.js'
  ]
}
