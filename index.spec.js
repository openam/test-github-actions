const main = require('./index')
const pkg = require('./package.json')

describe('main', () => {
  it('returns current version number', () => {
    const version = main.version()
    expect(version).toBe(pkg.version)
    expect(version).toBeTruthy();
  })

  test.each([
    [1, 1, 2],
    [1, 2, 3],
    [2, 1, 3],
  ])('.add(%i, %i)', (a, b, expected) => {
    expect(a + b).toBe(expected);
  });
})
