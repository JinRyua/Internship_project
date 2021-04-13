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
let DomainAssignment = require('./DomainAssignment.js');

//-----------------------------------------------------------

class DomainOperator {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.formula = null;
      this.at_start_add_effects = null;
      this.at_start_del_effects = null;
      this.at_end_add_effects = null;
      this.at_end_del_effects = null;
      this.at_start_assign_effects = null;
      this.at_end_assign_effects = null;
      this.at_start_simple_condition = null;
      this.over_all_simple_condition = null;
      this.at_end_simple_condition = null;
      this.at_start_neg_condition = null;
      this.over_all_neg_condition = null;
      this.at_end_neg_condition = null;
    }
    else {
      if (initObj.hasOwnProperty('formula')) {
        this.formula = initObj.formula
      }
      else {
        this.formula = new DomainFormula();
      }
      if (initObj.hasOwnProperty('at_start_add_effects')) {
        this.at_start_add_effects = initObj.at_start_add_effects
      }
      else {
        this.at_start_add_effects = [];
      }
      if (initObj.hasOwnProperty('at_start_del_effects')) {
        this.at_start_del_effects = initObj.at_start_del_effects
      }
      else {
        this.at_start_del_effects = [];
      }
      if (initObj.hasOwnProperty('at_end_add_effects')) {
        this.at_end_add_effects = initObj.at_end_add_effects
      }
      else {
        this.at_end_add_effects = [];
      }
      if (initObj.hasOwnProperty('at_end_del_effects')) {
        this.at_end_del_effects = initObj.at_end_del_effects
      }
      else {
        this.at_end_del_effects = [];
      }
      if (initObj.hasOwnProperty('at_start_assign_effects')) {
        this.at_start_assign_effects = initObj.at_start_assign_effects
      }
      else {
        this.at_start_assign_effects = [];
      }
      if (initObj.hasOwnProperty('at_end_assign_effects')) {
        this.at_end_assign_effects = initObj.at_end_assign_effects
      }
      else {
        this.at_end_assign_effects = [];
      }
      if (initObj.hasOwnProperty('at_start_simple_condition')) {
        this.at_start_simple_condition = initObj.at_start_simple_condition
      }
      else {
        this.at_start_simple_condition = [];
      }
      if (initObj.hasOwnProperty('over_all_simple_condition')) {
        this.over_all_simple_condition = initObj.over_all_simple_condition
      }
      else {
        this.over_all_simple_condition = [];
      }
      if (initObj.hasOwnProperty('at_end_simple_condition')) {
        this.at_end_simple_condition = initObj.at_end_simple_condition
      }
      else {
        this.at_end_simple_condition = [];
      }
      if (initObj.hasOwnProperty('at_start_neg_condition')) {
        this.at_start_neg_condition = initObj.at_start_neg_condition
      }
      else {
        this.at_start_neg_condition = [];
      }
      if (initObj.hasOwnProperty('over_all_neg_condition')) {
        this.over_all_neg_condition = initObj.over_all_neg_condition
      }
      else {
        this.over_all_neg_condition = [];
      }
      if (initObj.hasOwnProperty('at_end_neg_condition')) {
        this.at_end_neg_condition = initObj.at_end_neg_condition
      }
      else {
        this.at_end_neg_condition = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DomainOperator
    // Serialize message field [formula]
    bufferOffset = DomainFormula.serialize(obj.formula, buffer, bufferOffset);
    // Serialize message field [at_start_add_effects]
    // Serialize the length for message field [at_start_add_effects]
    bufferOffset = _serializer.uint32(obj.at_start_add_effects.length, buffer, bufferOffset);
    obj.at_start_add_effects.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_start_del_effects]
    // Serialize the length for message field [at_start_del_effects]
    bufferOffset = _serializer.uint32(obj.at_start_del_effects.length, buffer, bufferOffset);
    obj.at_start_del_effects.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_end_add_effects]
    // Serialize the length for message field [at_end_add_effects]
    bufferOffset = _serializer.uint32(obj.at_end_add_effects.length, buffer, bufferOffset);
    obj.at_end_add_effects.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_end_del_effects]
    // Serialize the length for message field [at_end_del_effects]
    bufferOffset = _serializer.uint32(obj.at_end_del_effects.length, buffer, bufferOffset);
    obj.at_end_del_effects.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_start_assign_effects]
    // Serialize the length for message field [at_start_assign_effects]
    bufferOffset = _serializer.uint32(obj.at_start_assign_effects.length, buffer, bufferOffset);
    obj.at_start_assign_effects.forEach((val) => {
      bufferOffset = DomainAssignment.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_end_assign_effects]
    // Serialize the length for message field [at_end_assign_effects]
    bufferOffset = _serializer.uint32(obj.at_end_assign_effects.length, buffer, bufferOffset);
    obj.at_end_assign_effects.forEach((val) => {
      bufferOffset = DomainAssignment.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_start_simple_condition]
    // Serialize the length for message field [at_start_simple_condition]
    bufferOffset = _serializer.uint32(obj.at_start_simple_condition.length, buffer, bufferOffset);
    obj.at_start_simple_condition.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [over_all_simple_condition]
    // Serialize the length for message field [over_all_simple_condition]
    bufferOffset = _serializer.uint32(obj.over_all_simple_condition.length, buffer, bufferOffset);
    obj.over_all_simple_condition.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_end_simple_condition]
    // Serialize the length for message field [at_end_simple_condition]
    bufferOffset = _serializer.uint32(obj.at_end_simple_condition.length, buffer, bufferOffset);
    obj.at_end_simple_condition.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_start_neg_condition]
    // Serialize the length for message field [at_start_neg_condition]
    bufferOffset = _serializer.uint32(obj.at_start_neg_condition.length, buffer, bufferOffset);
    obj.at_start_neg_condition.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [over_all_neg_condition]
    // Serialize the length for message field [over_all_neg_condition]
    bufferOffset = _serializer.uint32(obj.over_all_neg_condition.length, buffer, bufferOffset);
    obj.over_all_neg_condition.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [at_end_neg_condition]
    // Serialize the length for message field [at_end_neg_condition]
    bufferOffset = _serializer.uint32(obj.at_end_neg_condition.length, buffer, bufferOffset);
    obj.at_end_neg_condition.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DomainOperator
    let len;
    let data = new DomainOperator(null);
    // Deserialize message field [formula]
    data.formula = DomainFormula.deserialize(buffer, bufferOffset);
    // Deserialize message field [at_start_add_effects]
    // Deserialize array length for message field [at_start_add_effects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_start_add_effects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_start_add_effects[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_start_del_effects]
    // Deserialize array length for message field [at_start_del_effects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_start_del_effects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_start_del_effects[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_end_add_effects]
    // Deserialize array length for message field [at_end_add_effects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_end_add_effects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_end_add_effects[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_end_del_effects]
    // Deserialize array length for message field [at_end_del_effects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_end_del_effects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_end_del_effects[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_start_assign_effects]
    // Deserialize array length for message field [at_start_assign_effects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_start_assign_effects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_start_assign_effects[i] = DomainAssignment.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_end_assign_effects]
    // Deserialize array length for message field [at_end_assign_effects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_end_assign_effects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_end_assign_effects[i] = DomainAssignment.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_start_simple_condition]
    // Deserialize array length for message field [at_start_simple_condition]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_start_simple_condition = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_start_simple_condition[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [over_all_simple_condition]
    // Deserialize array length for message field [over_all_simple_condition]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.over_all_simple_condition = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.over_all_simple_condition[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_end_simple_condition]
    // Deserialize array length for message field [at_end_simple_condition]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_end_simple_condition = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_end_simple_condition[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_start_neg_condition]
    // Deserialize array length for message field [at_start_neg_condition]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_start_neg_condition = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_start_neg_condition[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [over_all_neg_condition]
    // Deserialize array length for message field [over_all_neg_condition]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.over_all_neg_condition = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.over_all_neg_condition[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [at_end_neg_condition]
    // Deserialize array length for message field [at_end_neg_condition]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.at_end_neg_condition = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.at_end_neg_condition[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += DomainFormula.getMessageSize(object.formula);
    object.at_start_add_effects.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.at_start_del_effects.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.at_end_add_effects.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.at_end_del_effects.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.at_start_assign_effects.forEach((val) => {
      length += DomainAssignment.getMessageSize(val);
    });
    object.at_end_assign_effects.forEach((val) => {
      length += DomainAssignment.getMessageSize(val);
    });
    object.at_start_simple_condition.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.over_all_simple_condition.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.at_end_simple_condition.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.at_start_neg_condition.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.over_all_neg_condition.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    object.at_end_neg_condition.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    return length + 48;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_knowledge_msgs/DomainOperator';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f41e4eca186d347375561fa0ba1d4ab7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # A message used to represent an ungrounded operator in the domain.
    
    # (1) name and parameters
    rosplan_knowledge_msgs/DomainFormula formula
    
    # (2) duration constraint
    
    
    # (3) effect lists
    rosplan_knowledge_msgs/DomainFormula[] at_start_add_effects
    rosplan_knowledge_msgs/DomainFormula[] at_start_del_effects
    rosplan_knowledge_msgs/DomainFormula[] at_end_add_effects
    rosplan_knowledge_msgs/DomainFormula[] at_end_del_effects
    rosplan_knowledge_msgs/DomainAssignment[] at_start_assign_effects
    rosplan_knowledge_msgs/DomainAssignment[] at_end_assign_effects
    
    # (4) conditions
    rosplan_knowledge_msgs/DomainFormula[] at_start_simple_condition
    rosplan_knowledge_msgs/DomainFormula[] over_all_simple_condition
    rosplan_knowledge_msgs/DomainFormula[] at_end_simple_condition
    rosplan_knowledge_msgs/DomainFormula[] at_start_neg_condition
    rosplan_knowledge_msgs/DomainFormula[] over_all_neg_condition
    rosplan_knowledge_msgs/DomainFormula[] at_end_neg_condition
    
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
    
    ================================================================================
    MSG: rosplan_knowledge_msgs/DomainAssignment
    # A message used to store the numeric effects of an action
    # Can be grounded or ungrounded
    
    uint8 ASSIGN   = 0
    uint8 INCREASE  = 1
    uint8 DECREASE = 2
    uint8 SCALE_UP = 3
    uint8 SCALE_DOWN = 4
    uint8 ASSIGN_CTS = 5
    
    uint8 assign_type
    
    rosplan_knowledge_msgs/DomainFormula LHS
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DomainOperator(null);
    if (msg.formula !== undefined) {
      resolved.formula = DomainFormula.Resolve(msg.formula)
    }
    else {
      resolved.formula = new DomainFormula()
    }

    if (msg.at_start_add_effects !== undefined) {
      resolved.at_start_add_effects = new Array(msg.at_start_add_effects.length);
      for (let i = 0; i < resolved.at_start_add_effects.length; ++i) {
        resolved.at_start_add_effects[i] = DomainFormula.Resolve(msg.at_start_add_effects[i]);
      }
    }
    else {
      resolved.at_start_add_effects = []
    }

    if (msg.at_start_del_effects !== undefined) {
      resolved.at_start_del_effects = new Array(msg.at_start_del_effects.length);
      for (let i = 0; i < resolved.at_start_del_effects.length; ++i) {
        resolved.at_start_del_effects[i] = DomainFormula.Resolve(msg.at_start_del_effects[i]);
      }
    }
    else {
      resolved.at_start_del_effects = []
    }

    if (msg.at_end_add_effects !== undefined) {
      resolved.at_end_add_effects = new Array(msg.at_end_add_effects.length);
      for (let i = 0; i < resolved.at_end_add_effects.length; ++i) {
        resolved.at_end_add_effects[i] = DomainFormula.Resolve(msg.at_end_add_effects[i]);
      }
    }
    else {
      resolved.at_end_add_effects = []
    }

    if (msg.at_end_del_effects !== undefined) {
      resolved.at_end_del_effects = new Array(msg.at_end_del_effects.length);
      for (let i = 0; i < resolved.at_end_del_effects.length; ++i) {
        resolved.at_end_del_effects[i] = DomainFormula.Resolve(msg.at_end_del_effects[i]);
      }
    }
    else {
      resolved.at_end_del_effects = []
    }

    if (msg.at_start_assign_effects !== undefined) {
      resolved.at_start_assign_effects = new Array(msg.at_start_assign_effects.length);
      for (let i = 0; i < resolved.at_start_assign_effects.length; ++i) {
        resolved.at_start_assign_effects[i] = DomainAssignment.Resolve(msg.at_start_assign_effects[i]);
      }
    }
    else {
      resolved.at_start_assign_effects = []
    }

    if (msg.at_end_assign_effects !== undefined) {
      resolved.at_end_assign_effects = new Array(msg.at_end_assign_effects.length);
      for (let i = 0; i < resolved.at_end_assign_effects.length; ++i) {
        resolved.at_end_assign_effects[i] = DomainAssignment.Resolve(msg.at_end_assign_effects[i]);
      }
    }
    else {
      resolved.at_end_assign_effects = []
    }

    if (msg.at_start_simple_condition !== undefined) {
      resolved.at_start_simple_condition = new Array(msg.at_start_simple_condition.length);
      for (let i = 0; i < resolved.at_start_simple_condition.length; ++i) {
        resolved.at_start_simple_condition[i] = DomainFormula.Resolve(msg.at_start_simple_condition[i]);
      }
    }
    else {
      resolved.at_start_simple_condition = []
    }

    if (msg.over_all_simple_condition !== undefined) {
      resolved.over_all_simple_condition = new Array(msg.over_all_simple_condition.length);
      for (let i = 0; i < resolved.over_all_simple_condition.length; ++i) {
        resolved.over_all_simple_condition[i] = DomainFormula.Resolve(msg.over_all_simple_condition[i]);
      }
    }
    else {
      resolved.over_all_simple_condition = []
    }

    if (msg.at_end_simple_condition !== undefined) {
      resolved.at_end_simple_condition = new Array(msg.at_end_simple_condition.length);
      for (let i = 0; i < resolved.at_end_simple_condition.length; ++i) {
        resolved.at_end_simple_condition[i] = DomainFormula.Resolve(msg.at_end_simple_condition[i]);
      }
    }
    else {
      resolved.at_end_simple_condition = []
    }

    if (msg.at_start_neg_condition !== undefined) {
      resolved.at_start_neg_condition = new Array(msg.at_start_neg_condition.length);
      for (let i = 0; i < resolved.at_start_neg_condition.length; ++i) {
        resolved.at_start_neg_condition[i] = DomainFormula.Resolve(msg.at_start_neg_condition[i]);
      }
    }
    else {
      resolved.at_start_neg_condition = []
    }

    if (msg.over_all_neg_condition !== undefined) {
      resolved.over_all_neg_condition = new Array(msg.over_all_neg_condition.length);
      for (let i = 0; i < resolved.over_all_neg_condition.length; ++i) {
        resolved.over_all_neg_condition[i] = DomainFormula.Resolve(msg.over_all_neg_condition[i]);
      }
    }
    else {
      resolved.over_all_neg_condition = []
    }

    if (msg.at_end_neg_condition !== undefined) {
      resolved.at_end_neg_condition = new Array(msg.at_end_neg_condition.length);
      for (let i = 0; i < resolved.at_end_neg_condition.length; ++i) {
        resolved.at_end_neg_condition[i] = DomainFormula.Resolve(msg.at_end_neg_condition[i]);
      }
    }
    else {
      resolved.at_end_neg_condition = []
    }

    return resolved;
    }
};

module.exports = DomainOperator;
