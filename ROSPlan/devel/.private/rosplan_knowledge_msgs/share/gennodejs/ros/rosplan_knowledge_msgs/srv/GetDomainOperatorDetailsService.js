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

let DomainOperator = require('../msg/DomainOperator.js');

//-----------------------------------------------------------

class GetDomainOperatorDetailsServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainOperatorDetailsServiceRequest
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainOperatorDetailsServiceRequest
    let len;
    let data = new GetDomainOperatorDetailsServiceRequest(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c1f3d28f1b044c871e6eff2e9fc3c667';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Fetching the Domain (2.5/3):
    # Get all details of a specific operator in the domain.
    string name
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainOperatorDetailsServiceRequest(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    return resolved;
    }
};

class GetDomainOperatorDetailsServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.op = null;
    }
    else {
      if (initObj.hasOwnProperty('op')) {
        this.op = initObj.op
      }
      else {
        this.op = new DomainOperator();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainOperatorDetailsServiceResponse
    // Serialize message field [op]
    bufferOffset = DomainOperator.serialize(obj.op, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainOperatorDetailsServiceResponse
    let len;
    let data = new GetDomainOperatorDetailsServiceResponse(null);
    // Deserialize message field [op]
    data.op = DomainOperator.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += DomainOperator.getMessageSize(object.op);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainOperatorDetailsServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '30a802a0fa1a95db266007a7485dd34a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    rosplan_knowledge_msgs/DomainOperator op
    
    
    ================================================================================
    MSG: rosplan_knowledge_msgs/DomainOperator
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
    const resolved = new GetDomainOperatorDetailsServiceResponse(null);
    if (msg.op !== undefined) {
      resolved.op = DomainOperator.Resolve(msg.op)
    }
    else {
      resolved.op = new DomainOperator()
    }

    return resolved;
    }
};

module.exports = {
  Request: GetDomainOperatorDetailsServiceRequest,
  Response: GetDomainOperatorDetailsServiceResponse,
  md5sum() { return 'd1ca18637f3dfc6b50d99a8c3a27f01d'; },
  datatype() { return 'rosplan_knowledge_msgs/GetDomainOperatorDetailsService'; }
};
