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

let DomainFormula = require('../msg/DomainFormula.js');

//-----------------------------------------------------------

class GetDomainOperatorServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainOperatorServiceRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainOperatorServiceRequest
    let len;
    let data = new GetDomainOperatorServiceRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainOperatorServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Fetching the Domain (2/3):
    # Get all operators in the domain.
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainOperatorServiceRequest(null);
    return resolved;
    }
};

class GetDomainOperatorServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.operators = null;
    }
    else {
      if (initObj.hasOwnProperty('operators')) {
        this.operators = initObj.operators
      }
      else {
        this.operators = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainOperatorServiceResponse
    // Serialize message field [operators]
    // Serialize the length for message field [operators]
    bufferOffset = _serializer.uint32(obj.operators.length, buffer, bufferOffset);
    obj.operators.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainOperatorServiceResponse
    let len;
    let data = new GetDomainOperatorServiceResponse(null);
    // Deserialize message field [operators]
    // Deserialize array length for message field [operators]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.operators = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.operators[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.operators.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainOperatorServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '01315931b687093b9f4ca53107f02d57';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    rosplan_knowledge_msgs/DomainFormula[] operators
    
    
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
    const resolved = new GetDomainOperatorServiceResponse(null);
    if (msg.operators !== undefined) {
      resolved.operators = new Array(msg.operators.length);
      for (let i = 0; i < resolved.operators.length; ++i) {
        resolved.operators[i] = DomainFormula.Resolve(msg.operators[i]);
      }
    }
    else {
      resolved.operators = []
    }

    return resolved;
    }
};

module.exports = {
  Request: GetDomainOperatorServiceRequest,
  Response: GetDomainOperatorServiceResponse,
  md5sum() { return '01315931b687093b9f4ca53107f02d57'; },
  datatype() { return 'rosplan_knowledge_msgs/GetDomainOperatorService'; }
};
