// Auto-generated. Do not edit!

// (in-package rosplan_knowledge_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let KnowledgeItem = require('../msg/KnowledgeItem.js');

//-----------------------------------------------------------

class GetAttributeServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.predicate_name = null;
    }
    else {
      if (initObj.hasOwnProperty('predicate_name')) {
        this.predicate_name = initObj.predicate_name
      }
      else {
        this.predicate_name = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetAttributeServiceRequest
    // Serialize message field [predicate_name]
    bufferOffset = _serializer.string(obj.predicate_name, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetAttributeServiceRequest
    let len;
    let data = new GetAttributeServiceRequest(null);
    // Deserialize message field [predicate_name]
    data.predicate_name = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.predicate_name.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetAttributeServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '130dad30028f4055312b63b35c17d1c3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # PDDL problem generation; service(2/3):
    # Get all facts (or functions) by predicate name (or function name).
    # The results are passed as an array of KnowledgeItems
    # The array of initial_time is used for TILs and TIFs not yet active
    string predicate_name
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetAttributeServiceRequest(null);
    if (msg.predicate_name !== undefined) {
      resolved.predicate_name = msg.predicate_name;
    }
    else {
      resolved.predicate_name = ''
    }

    return resolved;
    }
};

class GetAttributeServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.attributes = null;
    }
    else {
      if (initObj.hasOwnProperty('attributes')) {
        this.attributes = initObj.attributes
      }
      else {
        this.attributes = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetAttributeServiceResponse
    // Serialize message field [attributes]
    // Serialize the length for message field [attributes]
    bufferOffset = _serializer.uint32(obj.attributes.length, buffer, bufferOffset);
    obj.attributes.forEach((val) => {
      bufferOffset = KnowledgeItem.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetAttributeServiceResponse
    let len;
    let data = new GetAttributeServiceResponse(null);
    // Deserialize message field [attributes]
    // Deserialize array length for message field [attributes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.attributes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.attributes[i] = KnowledgeItem.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.attributes.forEach((val) => {
      length += KnowledgeItem.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetAttributeServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd5f45c7802684d6586911ea5e4ae1c93';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    rosplan_knowledge_msgs/KnowledgeItem[] attributes
    
    
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
    const resolved = new GetAttributeServiceResponse(null);
    if (msg.attributes !== undefined) {
      resolved.attributes = new Array(msg.attributes.length);
      for (let i = 0; i < resolved.attributes.length; ++i) {
        resolved.attributes[i] = KnowledgeItem.Resolve(msg.attributes[i]);
      }
    }
    else {
      resolved.attributes = []
    }

    return resolved;
    }
};

module.exports = {
  Request: GetAttributeServiceRequest,
  Response: GetAttributeServiceResponse,
  md5sum() { return 'fe78089058f9089ebe2902711c474ad4'; },
  datatype() { return 'rosplan_knowledge_msgs/GetAttributeService'; }
};
