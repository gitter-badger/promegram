chai = require 'chai'
should = chai.should()

describe 'chai', ->
	it 'should work', ->

Promegram = require '../src/promegram'
describe 'Promegram', ->
	it 'should export Promegram', ->
		promegram = new Promegram
		promegram.should.be.an 'object'

	it 'should have init method', ->
		promegram = new Promegram
		promegram.should.have.property 'init'
		promegram.init.should.be.a 'function'
