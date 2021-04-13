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

class GetDomainPredicateDetailsServiceRequest {
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
    // Serializes a message object of type GetDomainPredicateDetailsServiceRequest
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainPredicateDetailsServiceRequest
    let len;
    let data = new GetDomainPredicateDetailsServiceRequest(null);
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
    return 'rosplan_knowledge_msgs/GetDomainPredicateDetailsServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c1f3d28f1b044c871e6eff2e9fc3c667';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Fetching the Domain (1.5/3):
    # Get all details of a specific predicate in the domain.
    string name
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainPredicateDetailsServiceRequest(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    return resolved;
    }
};

class GetDomainPredicateDetailsServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.predicate = null;
    }
    else {
      if (initObj.hasOwnProperty('predicate')) {
        this.predicate = initObj.predicate
      }
      else {
        this.predicate = new DomainFormula();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainPredicateDetailsServiceResponse
    // Serialize message field [predicate]
    bufferOffset = DomainFormula.serialize(obj.predicate, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainPredicateDetailsServiceResponse
    let len;
    let data = new GetDomainPredicateDetailsServiceResponse(null);
    // Deserialize message field [predicate]
    data.predicate = DomainFormula.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += DomainFormula.getMessageSize(object.predicate);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainPredicateDetailsServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b5738f6a32f5daabd19d758e1a2070d2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    rosplan_knowledge_msgs/DomainFormula predicate
    
    
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
    const resolved = new GetDomainPredicateDetailsServiceResponse(null);
    if (msg.predicate !== undefined) {
      resolved.predicate = DomainFormula.Resolve(msg.predicate)
    }
    else {
      resolved.predicate = new DomainFormula()
    }

    return resolved;
    }
};

module.exports = {
  Request: GetDomainPredicateDetailsServiceRequest,
  Response: GetDomainPredicateDetailsServiceResponse,
  md5sum() { return 'a2d0df3018ceb22168c64e3d02f01b80'; },
  datatype() { return 'rosplan_knowledge_msgs/GetDomainPredicateDetailsService'; }
};
