// Auto-generated. Do not edit!

// (in-package rosplan_knowledge_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let KnowledgeItem = require('../msg/KnowledgeItem.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class KnowledgeQueryServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.knowledge = null;
    }
    else {
      if (initObj.hasOwnProperty('knowledge')) {
        this.knowledge = initObj.knowledge
      }
      else {
        this.knowledge = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type KnowledgeQueryServiceRequest
    // Serialize message field [knowledge]
    // Serialize the length for message field [knowledge]
    bufferOffset = _serializer.uint32(obj.knowledge.length, buffer, bufferOffset);
    obj.knowledge.forEach((val) => {
      bufferOffset = KnowledgeItem.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type KnowledgeQueryServiceRequest
    let len;
    let data = new KnowledgeQueryServiceRequest(null);
    // Deserialize message field [knowledge]
    // Deserialize array length for message field [knowledge]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.knowledge = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.knowledge[i] = KnowledgeItem.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.knowledge.forEach((val) => {
      length += KnowledgeItem.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/KnowledgeQueryServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '35f34b6a9859a67dd0f299bf065fb1c7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    rosplan_knowledge_msgs/KnowledgeItem[] knowledge
    
    ================================================================================
    MSG: rosplan_knowledge_msgs/KnowledgeItem
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
    const resolved = new KnowledgeQueryServiceRequest(null);
    if (msg.knowledge !== undefined) {
      resolved.knowledge = new Array(msg.knowledge.length);
      for (let i = 0; i < resolved.knowledge.length; ++i) {
        resolved.knowledge[i] = KnowledgeItem.Resolve(msg.knowledge[i]);
      }
    }
    else {
      resolved.knowledge = []
    }

    return resolved;
    }
};

class KnowledgeQueryServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.all_true = null;
      this.results = null;
      this.false_knowledge = null;
    }
    else {
      if (initObj.hasOwnProperty('all_true')) {
        this.all_true = initObj.all_true
      }
      else {
        this.all_true = false;
      }
      if (initObj.hasOwnProperty('results')) {
        this.results = initObj.results
      }
      else {
        this.results = [];
      }
      if (initObj.hasOwnProperty('false_knowledge')) {
        this.false_knowledge = initObj.false_knowledge
      }
      else {
        this.false_knowledge = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type KnowledgeQueryServiceResponse
    // Serialize message field [all_true]
    bufferOffset = _serializer.bool(obj.all_true, buffer, bufferOffset);
    // Serialize message field [results]
    bufferOffset = _arraySerializer.bool(obj.results, buffer, bufferOffset, null);
    // Serialize message field [false_knowledge]
    // Serialize the length for message field [false_knowledge]
    bufferOffset = _serializer.uint32(obj.false_knowledge.length, buffer, bufferOffset);
    obj.false_knowledge.forEach((val) => {
      bufferOffset = KnowledgeItem.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type KnowledgeQueryServiceResponse
    let len;
    let data = new KnowledgeQueryServiceResponse(null);
    // Deserialize message field [all_true]
    data.all_true = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [results]
    data.results = _arrayDeserializer.bool(buffer, bufferOffset, null)
    // Deserialize message field [false_knowledge]
    // Deserialize array length for message field [false_knowledge]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.false_knowledge = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.false_knowledge[i] = KnowledgeItem.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.results.length;
    object.false_knowledge.forEach((val) => {
      length += KnowledgeItem.getMessageSize(val);
    });
    return length + 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/KnowledgeQueryServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3a9313841904d965dc44153815f77b0d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool all_true
    bool[] results
    rosplan_knowledge_msgs/KnowledgeItem[] false_knowledge
    
    
    ================================================================================
    MSG: rosplan_knowledge_msgs/KnowledgeItem
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
    const resolved = new KnowledgeQueryServiceResponse(null);
    if (msg.all_true !== undefined) {
      resolved.all_true = msg.all_true;
    }
    else {
      resolved.all_true = false
    }

    if (msg.results !== undefined) {
      resolved.results = msg.results;
    }
    else {
      resolved.results = []
    }

    if (msg.false_knowledge !== undefined) {
      resolved.false_knowledge = new Array(msg.false_knowledge.length);
      for (let i = 0; i < resolved.false_knowledge.length; ++i) {
        resolved.false_knowledge[i] = KnowledgeItem.Resolve(msg.false_knowledge[i]);
      }
    }
    else {
      resolved.false_knowledge = []
    }

    return resolved;
    }
};

module.exports = {
  Request: KnowledgeQueryServiceRequest,
  Response: KnowledgeQueryServiceResponse,
  md5sum() { return 'e5cd9298f5a545040e7835836f3210cb'; },
  datatype() { return 'rosplan_knowledge_msgs/KnowledgeQueryService'; }
};
