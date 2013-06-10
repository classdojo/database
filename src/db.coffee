###
Model builder
###
ModelBuilder    = require("model-builder")
MongooseBuilder = require("mongoose-builder")

ModelGraph       = ModelBuilder.Graph
ModelDirector    = ModelBuilder.Director
ModelNodeBuilder = ModelBuilder.NodeBuilder
NodeManager      = ModelBuilder.NodeManager


MongooseB  = MongooseBuilder.Builder


class Db

  ###
    Method: constructor

    Initialize Db with a reference to where relation, schema, and 
    dbSettings files are.
  ###

  constructor: (@__schema, @__dbSettings) ->
    @__files           = {}

  ###
    Method: loadConfigs

    Loads
      -relational
      -schema
      -dbSettings
    configs.  The result should be a JSON object.
  ###

  init: () ->
    @__nodeBuilder = new ModelNodeBuilder(@__schema)
    @__nodeBuilder.init()
    @__nodeManager = new NodeManager(@__nodeBuilder.nodes)
    @__dbBuilder = new MongooseB(@__nodeBuilder, @settings)
    @


  connect: (callback) ->
    director = new ModelDirector @__dbBuilder
    director.build (err) =>
      console.log "Database Initialized..."
      graph = new ModelGraph()
      director.setGraph graph
      ###
        TODO(chris): Make it more intuitive that
        the director should set the nodeManager or
        vice-versa
      ###
      graph.setNodeManager @__nodeManager
      callback null, graph


  ###
    Method: RegisterPlugin

    Defer to the the driver implementation of registerPlugin. In
    this case m
  ###

  registerPlugin: (args...) ->
    @__dbBuilder.registerPlugin.apply @__dbBuilder, args


  ###
    File Getters

    relational - defines the relationships between our mongo models

    schema - defines the schema of each model

    settings - database connection settings.
  ###

  @::__defineGetter__ 'settings', () ->
    @__files.settings || @__files.settings = (() =>
      return if @__dbSettings.init? then @__dbSettings.init(process.env.NODE_ENV) else @__dbSettings
    )()



module.exports = Db
