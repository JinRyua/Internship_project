// Auto-generated. Do not edit!

// (in-package rosplan_knowledge_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ExprComposite = require('./ExprComposite.js');

//-----------------------------------------------------------

class DomainInequality {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.comparison_type = null;
      this.LHS = null;
      this.RHS = null;
      this.grounded = null;
    }
    else {
      if (initObj.hasOwnProperty('comparison_type')) {
        this.comparison_type = initObj.comparison_type
      }
      else {
        this.comparison_type = 0;
      }
      if (initObj.hasOwnProperty('LHS')) {
        this.LHS = initObj.LHS
      }
      else {
        this.LHS = new ExprComposite();
      }
      if (initObj.hasOwnProperty('RHS')) {
        this.RHS = initObj.RHS
      }
      else {
        this.RHS = new ExprComposite();
      }
      if (initObj.hasOwnProperty('grounded')) {
        this.grounded = initObj.grounded
      }
      else {
        this.grounded = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DomainInequality
    // Serialize message field [comparison_type]
    bufferOffset = _serializer.uint8(obj.comparison_type, buffer, bufferOffset);
    // Serialize message field [LHS]
    bufferOffset = ExprComposite.serialize(obj.LHS, buffer, bufferOffset);
    // Serialize message field [RHS]
    bufferOffset = ExprComposite.serialize(obj.RHS, buffer, bufferOffset);
    // Serialize message field [grounded]
    bufferOffset = _serializer.bool(obj.grounded, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DomainInequality
    let len;
    let data = new DomainInequality(null);
    // Deserialize message field [comparison_type]
    data.comparison_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [LHS]
    data.LHS = ExprComposite.deserialize(buffer, bufferOffset);
    // Deserialize message field [RHS]
    data.RHS = ExprComposite.deserialize(buffer, bufferOffset);
    // Deserialize message field [grounded]
    data.grounded = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += ExprComposite.getMessageSize(object.LHS);
    length += ExprComposite.getMessageSize(object.RHS);
    return length + 2;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_knowledge_msgs/DomainInequality';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f37701458d82c14a53dcc25df39cacaa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # A message used to store the numeric effects of an action
    # Can be grounded or ungrounded
    
    uint8 GREATER   = 0
    uint8 GREATEREQ = 1
    uint8 LESS      = 2
    uint8 LESSEQ    = 3
    uint8 EQUALS    = 4
    
    uint8 comparison_type
    
    rosplan_knowledge_msgs/ExprComposite LHS
    rosplan_knowledge_msgs/ExprComposite RHS
    
    bool grounded
    
    ================================================================================
    MSG: rosplan_knowledge_msgs/ExprComposite
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
    const resolved = new DomainInequality(null);
    if (msg.comparison_type !== undefined) {
      resolved.comparison_type = msg.comparison_type;
    }
    else {
      resolved.comparison_type = 0
    }

    if (msg.LHS !== undefined) {
      resolved.LHS = ExprComposite.Resolve(msg.LHS)
    }
    else {
      resolved.LHS = new ExprComposite()
    }

    if (msg.RHS !== undefined) {
      resolved.RHS = ExprComposite.Resolve(msg.RHS)
    }
    else {
      resolved.RHS = new ExprComposite()
    }

    if (msg.grounded !== undefined) {
      resolved.grounded = msg.grounded;
    }
    else {
      resolved.grounded = false
    }

    return resolved;
    }
};

// Constants for message
DomainInequality.Constants = {
  GREATER: 0,
  GREATEREQ: 1,
  LESS: 2,
  LESSEQ: 3,
  EQUALS: 4,
}

module.exports = DomainInequality;
