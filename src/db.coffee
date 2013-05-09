###
Model builder
###
ModelBuilder    = require("model-builder")
MongooseBuilder = require("mongoose-builder")

ModelGraph       = ModelBuilder.Graph
ModelDirector    = ModelBuilder.Director
ModelNodeBuilder = ModelBuilder.NodeBuilder

MongooseB  = MongooseBuilder.Builder

class Db

  ###
    Method: constructor

    Initialize Db with a reference to where relation, schema, and 
    dbSettings files are.
  ###

  constructor: (schemaPath, dbSettingsPath) ->
    @_schemaPath      = schemaPath
    @_dbSettingsPath  = dbSettingsPath
    @_files           = {}

  ###
    Method: loadConfigs

    Loads
      -relational
      -schema
      -dbSettings
    configs.  The result should be a JSON object.
  ###

  init: () ->
    @_nodeBuilder = new ModelNodeBuilder(@_schemaPath)
    @_nodeBuilder.init()
    @_dbBuilder = new MongooseB(@_nodeBuilder, @settings)


  connect: (callback) ->
    director = new ModelDirector @_dbBuilder
    director.build (err) =>
      console.log "Database Initialized..."
      graph = new ModelGraph()
      director.setGraph graph
      callback null, graph


  ###
    Method: RegisterPlugin

    Defer to the the driver implementation of registerPlugin. In
    this case m
  ###

  registerPlugin: (args...) ->
    @_dbBuilder.registerPlugin.apply @_dbBuilder, args


  ###
    File Getters

    relational - defines the relationships between our mongo models

    schema - defines the schema of each model

    settings - database connection settings.
  ###

  @::__defineGetter__ 'settings', () ->
    @_files.settings || @_files.settings = (() =>
      return require(@_dbSettingsPath).init(process.env.NODE_ENV)
    )()



module.exports = Db
