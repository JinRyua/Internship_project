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

class GetDomainAttributeServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainAttributeServiceRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainAttributeServiceRequest
    let len;
    let data = new GetDomainAttributeServiceRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainAttributeServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Fetching the Domain (3/3):
    # Get all predicates or functions in the domain.
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainAttributeServiceRequest(null);
    return resolved;
    }
};

class GetDomainAttributeServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.items = null;
    }
    else {
      if (initObj.hasOwnProperty('items')) {
        this.items = initObj.items
      }
      else {
        this.items = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainAttributeServiceResponse
    // Serialize message field [items]
    // Serialize the length for message field [items]
    bufferOffset = _serializer.uint32(obj.items.length, buffer, bufferOffset);
    obj.items.forEach((val) => {
      bufferOffset = DomainFormula.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainAttributeServiceResponse
    let len;
    let data = new GetDomainAttributeServiceResponse(null);
    // Deserialize message field [items]
    // Deserialize array length for message field [items]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.items = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.items[i] = DomainFormula.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.items.forEach((val) => {
      length += DomainFormula.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainAttributeServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '900aa034059a0ceeaa146f6ab4b7e066';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    rosplan_knowledge_msgs/DomainFormula[] items
    
    
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
    const resolved = new GetDomainAttributeServiceResponse(null);
    if (msg.items !== undefined) {
      resolved.items = new Array(msg.items.length);
      for (let i = 0; i < resolved.items.length; ++i) {
        resolved.items[i] = DomainFormula.Resolve(msg.items[i]);
      }
    }
    else {
      resolved.items = []
    }

    return resolved;
    }
};

module.exports = {
  Request: GetDomainAttributeServiceRequest,
  Response: GetDomainAttributeServiceResponse,
  md5sum() { return '900aa034059a0ceeaa146f6ab4b7e066'; },
  datatype() { return 'rosplan_knowledge_msgs/GetDomainAttributeService'; }
};
