module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'header-max-length': [2, 'always', 80],
    'body-leading-blank': [2, 'always'],
    'footer-leading-blank': [2, 'always']
  },
  helpUrl: 'https://www.notion.so/atomicfi/Git-Conventional-Commits-7360a691dfa9445f94b88bd485c431d4'
}
