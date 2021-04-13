// Auto-generated. Do not edit!

// (in-package rosplan_dispatch_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class ParsingServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.plan_path = null;
    }
    else {
      if (initObj.hasOwnProperty('plan_path')) {
        this.plan_path = initObj.plan_path
      }
      else {
        this.plan_path = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParsingServiceRequest
    // Serialize message field [plan_path]
    bufferOffset = _serializer.string(obj.plan_path, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParsingServiceRequest
    let len;
    let data = new ParsingServiceRequest(null);
    // Deserialize message field [plan_path]
    data.plan_path = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.plan_path.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_dispatch_msgs/ParsingServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c771004eab052df9a3c0b81e4de4eddd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # parses a plan from a file
    string plan_path
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ParsingServiceRequest(null);
    if (msg.plan_path !== undefined) {
      resolved.plan_path = msg.plan_path;
    }
    else {
      resolved.plan_path = ''
    }

    return resolved;
    }
};

class ParsingServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.plan_parsed = null;
    }
    else {
      if (initObj.hasOwnProperty('plan_parsed')) {
        this.plan_parsed = initObj.plan_parsed
      }
      else {
        this.plan_parsed = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ParsingServiceResponse
    // Serialize message field [plan_parsed]
    bufferOffset = _serializer.bool(obj.plan_parsed, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ParsingServiceResponse
    let len;
    let data = new ParsingServiceResponse(null);
    // Deserialize message field [plan_parsed]
    data.plan_parsed = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_dispatch_msgs/ParsingServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fc50b29602a7f9075e91880aac617351';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool plan_parsed
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ParsingServiceResponse(null);
    if (msg.plan_parsed !== undefined) {
      resolved.plan_parsed = msg.plan_parsed;
    }
    else {
      resolved.plan_parsed = false
    }

    return resolved;
    }
};

module.exports = {
  Request: ParsingServiceRequest,
  Response: ParsingServiceResponse,
  md5sum() { return '30a7fd003c9a74d70dc3c96bf0a9476f'; },
  datatype() { return 'rosplan_dispatch_msgs/ParsingService'; }
};
