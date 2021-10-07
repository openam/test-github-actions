const pkg = require("./package.json");

exports.version = function version() {
  return pkg.version;
};

exports.sum = function sum(a, b) {
  return a + b;
};
