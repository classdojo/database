### Database WIP

A Mongoose specific database layer build on top of model-builder.

```javascript

  var DB = require('database');
  var SomePlugin = require("SomePlugin")
  var db = new DB("/path/to/schemas", "/path/to/database/settings");

  //add plugins
  db.registerPlugin("SomePlugin", SomePlugin);

  db.init(function(err, models) {
    //application code
  });
```

**More to come**
