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
let DomainInequality = require('./DomainInequality.js');
let diagnostic_msgs = _finder('diagnostic_msgs');

//-----------------------------------------------------------

class KnowledgeItem {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.knowledge_type = null;
      this.initial_time = null;
      this.is_negative = null;
      this.instance_type = null;
      this.instance_name = null;
      this.attribute_name = null;
      this.values = null;
      this.function_value = null;
      this.optimization = null;
      this.expr = null;
      this.ineq = null;
    }
    else {
      if (initObj.hasOwnProperty('knowledge_type')) {
        this.knowledge_type = initObj.knowledge_type
      }
      else {
        this.knowledge_type = 0;
      }
      if (initObj.hasOwnProperty('initial_time')) {
        this.initial_time = initObj.initial_time
      }
      else {
        this.initial_time = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('is_negative')) {
        this.is_negative = initObj.is_negative
      }
      else {
        this.is_negative = false;
      }
      if (initObj.hasOwnProperty('instance_type')) {
        this.instance_type = initObj.instance_type
      }
      else {
        this.instance_type = '';
      }
      if (initObj.hasOwnProperty('instance_name')) {
        this.instance_name = initObj.instance_name
      }
      else {
        this.instance_name = '';
      }
      if (initObj.hasOwnProperty('attribute_name')) {
        this.attribute_name = initObj.attribute_name
      }
      else {
        this.attribute_name = '';
      }
      if (initObj.hasOwnProperty('values')) {
        this.values = initObj.values
      }
      else {
        this.values = [];
      }
      if (initObj.hasOwnProperty('function_value')) {
        this.function_value = initObj.function_value
      }
      else {
        this.function_value = 0.0;
      }
      if (initObj.hasOwnProperty('optimization')) {
        this.optimization = initObj.optimization
      }
      else {
        this.optimization = '';
      }
      if (initObj.hasOwnProperty('expr')) {
        this.expr = initObj.expr
      }
      else {
        this.expr = new ExprComposite();
      }
      if (initObj.hasOwnProperty('ineq')) {
        this.ineq = initObj.ineq
      }
      else {
        this.ineq = new DomainInequality();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type KnowledgeItem
    // Serialize message field [knowledge_type]
    bufferOffset = _serializer.uint8(obj.knowledge_type, buffer, bufferOffset);
    // Serialize message field [initial_time]
    bufferOffset = _serializer.time(obj.initial_time, buffer, bufferOffset);
    // Serialize message field [is_negative]
    bufferOffset = _serializer.bool(obj.is_negative, buffer, bufferOffset);
    // Serialize message field [instance_type]
    bufferOffset = _serializer.string(obj.instance_type, buffer, bufferOffset);
    // Serialize message field [instance_name]
    bufferOffset = _serializer.string(obj.instance_name, buffer, bufferOffset);
    // Serialize message field [attribute_name]
    bufferOffset = _serializer.string(obj.attribute_name, buffer, bufferOffset);
    // Serialize message field [values]
    // Serialize the length for message field [values]
    bufferOffset = _serializer.uint32(obj.values.length, buffer, bufferOffset);
    obj.values.forEach((val) => {
      bufferOffset = diagnostic_msgs.msg.KeyValue.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [function_value]
    bufferOffset = _serializer.float64(obj.function_value, buffer, bufferOffset);
    // Serialize message field [optimization]
    bufferOffset = _serializer.string(obj.optimization, buffer, bufferOffset);
    // Serialize message field [expr]
    bufferOffset = ExprComposite.serialize(obj.expr, buffer, bufferOffset);
    // Serialize message field [ineq]
    bufferOffset = DomainInequality.serialize(obj.ineq, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type KnowledgeItem
    let len;
    let data = new KnowledgeItem(null);
    // Deserialize message field [knowledge_type]
    data.knowledge_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [initial_time]
    data.initial_time = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [is_negative]
    data.is_negative = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [instance_type]
    data.instance_type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [instance_name]
    data.instance_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [attribute_name]
    data.attribute_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [values]
    // Deserialize array length for message field [values]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.values = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.values[i] = diagnostic_msgs.msg.KeyValue.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [function_value]
    data.function_value = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [optimization]
    data.optimization = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [expr]
    data.expr = ExprComposite.deserialize(buffer, bufferOffset);
    // Deserialize message field [ineq]
    data.ineq = DomainInequality.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.instance_type.length;
    length += object.instance_name.length;
    length += object.attribute_name.length;
    object.values.forEach((val) => {
      length += diagnostic_msgs.msg.KeyValue.getMessageSize(val);
    });
    length += object.optimization.length;
    length += ExprComposite.getMessageSize(object.expr);
    length += DomainInequality.getMessageSize(object.ineq);
    return length + 38;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_knowledge_msgs/KnowledgeItem';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2339db6aaf05241f945b3ba17ef04eb1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # A knowledge item used to represent a piece of the state in ROSPlan
    
    uint8 INSTANCE = 0
    uint8 FACT = 1
    uint8 FUNCTION = 2
    uint8 EXPRESSION = 3
    uint8 INEQUALITY = 4
    
    uint8 knowledge_type
    
    # time at which this knowledge becomes true
    time initial_time
    
    # knowledge is explicitly false
    bool is_negative
    
    #---------
    # INSTANCE
    #---------
    
    # instance knowledge_type
    string instance_type
    string instance_name
    
    #----------------------
    # PREDICATE OR FUNCTION
    #----------------------
    
    # attribute knowledge_type
    string attribute_name
    diagnostic_msgs/KeyValue[] values
    
    #---------
    # FUNCTION
    #---------
    
    # function value
    float64 function_value
    
    #-----------
    # EXPRESSION
    #-----------
    
    string optimization
    rosplan_knowledge_msgs/ExprComposite expr
    
    #-----------
    # INEQUALITY
    #-----------
    
    rosplan_knowledge_msgs/DomainInequality ineq
    
    ================================================================================
    MSG: diagnostic_msgs/KeyValue
    string key # what to label this value when viewing
    string value # a value to track over time
    
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
    MSG: rosplan_knowledge_msgs/DomainInequality
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new KnowledgeItem(null);
    if (msg.knowledge_type !== undefined) {
      resolved.knowledge_type = msg.knowledge_type;
    }
    else {
      resolved.knowledge_type = 0
    }

    if (msg.initial_time !== undefined) {
      resolved.initial_time = msg.initial_time;
    }
    else {
      resolved.initial_time = {secs: 0, nsecs: 0}
    }

    if (msg.is_negative !== undefined) {
      resolved.is_negative = msg.is_negative;
    }
    else {
      resolved.is_negative = false
    }

    if (msg.instance_type !== undefined) {
      resolved.instance_type = msg.instance_type;
    }
    else {
      resolved.instance_type = ''
    }

    if (msg.instance_name !== undefined) {
      resolved.instance_name = msg.instance_name;
    }
    else {
      resolved.instance_name = ''
    }

    if (msg.attribute_name !== undefined) {
      resolved.attribute_name = msg.attribute_name;
    }
    else {
      resolved.attribute_name = ''
    }

    if (msg.values !== undefined) {
      resolved.values = new Array(msg.values.length);
      for (let i = 0; i < resolved.values.length; ++i) {
        resolved.values[i] = diagnostic_msgs.msg.KeyValue.Resolve(msg.values[i]);
      }
    }
    else {
      resolved.values = []
    }

    if (msg.function_value !== undefined) {
      resolved.function_value = msg.function_value;
    }
    else {
      resolved.function_value = 0.0
    }

    if (msg.optimization !== undefined) {
      resolved.optimization = msg.optimization;
    }
    else {
      resolved.optimization = ''
    }

    if (msg.expr !== undefined) {
      resolved.expr = ExprComposite.Resolve(msg.expr)
    }
    else {
      resolved.expr = new ExprComposite()
    }

    if (msg.ineq !== undefined) {
      resolved.ineq = DomainInequality.Resolve(msg.ineq)
    }
    else {
      resolved.ineq = new DomainInequality()
    }

    return resolved;
    }
};

// Constants for message
KnowledgeItem.Constants = {
  INSTANCE: 0,
  FACT: 1,
  FUNCTION: 2,
  EXPRESSION: 3,
  INEQUALITY: 4,
}

module.exports = KnowledgeItem;
