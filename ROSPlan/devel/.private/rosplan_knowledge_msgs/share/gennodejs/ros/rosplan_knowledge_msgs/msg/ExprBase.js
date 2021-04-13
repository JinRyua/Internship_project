// Auto-generated. Do not edit!

// (in-package rosplan_knowledge_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let DomainFormula = require('./DomainFormula.js');

//-----------------------------------------------------------

class ExprBase {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.expr_type = null;
      this.constant = null;
      this.function = null;
      this.op = null;
      this.special_type = null;
    }
    else {
      if (initObj.hasOwnProperty('expr_type')) {
        this.expr_type = initObj.expr_type
      }
      else {
        this.expr_type = 0;
      }
      if (initObj.hasOwnProperty('constant')) {
        this.constant = initObj.constant
      }
      else {
        this.constant = 0.0;
      }
      if (initObj.hasOwnProperty('function')) {
        this.function = initObj.function
      }
      else {
        this.function = new DomainFormula();
      }
      if (initObj.hasOwnProperty('op')) {
        this.op = initObj.op
      }
      else {
        this.op = 0;
      }
      if (initObj.hasOwnProperty('special_type')) {
        this.special_type = initObj.special_type
      }
      else {
        this.special_type = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExprBase
    // Serialize message field [expr_type]
    bufferOffset = _serializer.uint8(obj.expr_type, buffer, bufferOffset);
    // Serialize message field [constant]
    bufferOffset = _serializer.float64(obj.constant, buffer, bufferOffset);
    // Serialize message field [function]
    bufferOffset = DomainFormula.serialize(obj.function, buffer, bufferOffset);
    // Serialize message field [op]
    bufferOffset = _serializer.uint8(obj.op, buffer, bufferOffset);
    // Serialize message field [special_type]
    bufferOffset = _serializer.uint8(obj.special_type, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExprBase
    let len;
    let data = new ExprBase(null);
    // Deserialize message field [expr_type]
    data.expr_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [constant]
    data.constant = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [function]
    data.function = DomainFormula.deserialize(buffer, bufferOffset);
    // Deserialize message field [op]
    data.op = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [special_type]
    data.special_type = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += DomainFormula.getMessageSize(object.function);
    return length + 11;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_knowledge_msgs/ExprBase';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5d33d1b51272864ef936be512369146f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new ExprBase(null);
    if (msg.expr_type !== undefined) {
      resolved.expr_type = msg.expr_type;
    }
    else {
      resolved.expr_type = 0
    }

    if (msg.constant !== undefined) {
      resolved.constant = msg.constant;
    }
    else {
      resolved.constant = 0.0
    }

    if (msg.function !== undefined) {
      resolved.function = DomainFormula.Resolve(msg.function)
    }
    else {
      resolved.function = new DomainFormula()
    }

    if (msg.op !== undefined) {
      resolved.op = msg.op;
    }
    else {
      resolved.op = 0
    }

    if (msg.special_type !== undefined) {
      resolved.special_type = msg.special_type;
    }
    else {
      resolved.special_type = 0
    }

    return resolved;
    }
};

// Constants for message
ExprBase.Constants = {
  CONSTANT: 0,
  FUNCTION: 1,
  OPERATOR: 2,
  SPECIAL: 3,
  ADD: 0,
  SUB: 1,
  MUL: 2,
  DIV: 3,
  UMINUS: 4,
  HASHT: 0,
  TOTAL_TIME: 1,
  DURATION: 2,
}

module.exports = ExprBase;
