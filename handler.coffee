Promise = require 'bluebird'
AWS = require 'aws-sdk'
AWS.config.setPromisesDependency Promise
dynamo = new AWS.DynamoDB.DocumentClient()

module.exports.hello = (event, context, callback) =>
  response =
    statusCode: 200
    body: JSON.stringify
      message: "Hello there world"
      input: event

  callback null, response

module.exports.put = (event, context, callback) =>
  dynamo.put
    TableName: "TestTable"
    Item:
      key: "example"
      value: "foobar"
  .promise()
  .then (data) ->
    callback null,
      statusCode: 200
      body: JSON.stringify data
  .catch (err) ->
    callback err,
      statusCode: 500
      body: err.message

module.exports.get = (event, context, callback) =>
  dynamo.get
    TableName: "TestTable"
    Key:
      key: "example"
  .promise()
  .then (data) ->
    callback null,
      statusCode: 200
      body: JSON.stringify data
  .catch (err) ->
    callback err,
      statusCode: 500
      body: err.message
