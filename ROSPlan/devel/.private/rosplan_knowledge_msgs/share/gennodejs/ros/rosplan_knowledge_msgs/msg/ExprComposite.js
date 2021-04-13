// Auto-generated. Do not edit!

// (in-package rosplan_knowledge_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ExprBase = require('./ExprBase.js');

//-----------------------------------------------------------

class ExprComposite {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.tokens = null;
    }
    else {
      if (initObj.hasOwnProperty('tokens')) {
        this.tokens = initObj.tokens
      }
      else {
        this.tokens = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExprComposite
    // Serialize message field [tokens]
    // Serialize the length for message field [tokens]
    bufferOffset = _serializer.uint32(obj.tokens.length, buffer, bufferOffset);
    obj.tokens.forEach((val) => {
      bufferOffset = ExprBase.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExprComposite
    let len;
    let data = new ExprComposite(null);
    // Deserialize message field [tokens]
    // Deserialize array length for message field [tokens]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.tokens = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.tokens[i] = ExprBase.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.tokens.forEach((val) => {
      length += ExprBase.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_knowledge_msgs/ExprComposite';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9633231342c31ed233d306d6bf5cb1d3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # A message used to represent a numerical expression; composite type (2/2)
    # stores an array of ExprBase as prefix notation
    
    # components
    ExprBase[] tokens
    
    ================================================================================
    MSG: rosplan_knowledge_msgs/ExprBase
    # A message used to represent a numerical expression; base types (1/2)
    
    # expression types
    uint8 CONSTANT = 0
    uint8 FUNCTION = 1
    uint8 OPERATOR = 2
    uint8 SPECIAL  = 3
    
    # operators
    uint8 ADD    = 0
    uint8 SUB    = 1
    uint8 MUL    = 2
    uint8 DIV    = 3
    uint8 UMINUS = 4
    
    # special types
    uint8 HASHT      = 0
    uint8 TOTAL_TIME = 1
    uint8 DURATION   = 2
    
    # expression base type
    uint8 expr_type
    
    # constant value
    float64 constant
    
    # function
    rosplan_knowledge_msgs/DomainFormula function
    
    # operator
    uint8 op
    
    # special
    uint8 special_type
    
    ================================================================================
    MSG: rosplan_knowledge_msgs/DomainFormula
    # A message used to represent an atomic formula from the domain.
    # typed_parameters matches label -> type
    string name
    diagnostic_msgs/KeyValue[] typed_parameters
    
    ================================================================================
    MSG: diagnostic_msgs/KeyValue
    string key # what to label this value when viewing
    string value # a value to track over time
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ExprComposite(null);
    if (msg.tokens !== undefined) {
      resolved.tokens = new Array(msg.tokens.length);
      for (let i = 0; i < resolved.tokens.length; ++i) {
        resolved.tokens[i] = ExprBase.Resolve(msg.tokens[i]);
      }
    }
    else {
      resolved.tokens = []
    }

    return resolved;
    }
};

module.exports = ExprComposite;
