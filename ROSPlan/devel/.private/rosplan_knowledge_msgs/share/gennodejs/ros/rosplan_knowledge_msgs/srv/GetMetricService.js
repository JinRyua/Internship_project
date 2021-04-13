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

class GetMetricServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetMetricServiceRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetMetricServiceRequest
    let len;
    let data = new GetMetricServiceRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetMetricServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # PDDL problem generation; service(3/3):
    # Get the problem metric.
    # The result is passed as a KnowledgeItem, where the value needs to be parsed by the program.
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetMetricServiceRequest(null);
    return resolved;
    }
};

class GetMetricServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.metric = null;
    }
    else {
      if (initObj.hasOwnProperty('metric')) {
        this.metric = initObj.metric
      }
      else {
        this.metric = new KnowledgeItem();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetMetricServiceResponse
    // Serialize message field [metric]
    bufferOffset = KnowledgeItem.serialize(obj.metric, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetMetricServiceResponse
    let len;
    let data = new GetMetricServiceResponse(null);
    // Deserialize message field [metric]
    data.metric = KnowledgeItem.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += KnowledgeItem.getMessageSize(object.metric);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetMetricServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd8654505c165321f0d5dd974ec4ca392';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    rosplan_knowledge_msgs/KnowledgeItem metric
    
    
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
    const resolved = new GetMetricServiceResponse(null);
    if (msg.metric !== undefined) {
      resolved.metric = KnowledgeItem.Resolve(msg.metric)
    }
    else {
      resolved.metric = new KnowledgeItem()
    }

    return resolved;
    }
};

module.exports = {
  Request: GetMetricServiceRequest,
  Response: GetMetricServiceResponse,
  md5sum() { return 'd8654505c165321f0d5dd974ec4ca392'; },
  datatype() { return 'rosplan_knowledge_msgs/GetMetricService'; }
};
