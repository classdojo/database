(function(m) {
  exports.Database = require("./lib/db");
  exports.BaseSchema = require("model-builder").BaseSchema;
  exports.Permission = require("mongoose-builder").Permission;
})(module);
