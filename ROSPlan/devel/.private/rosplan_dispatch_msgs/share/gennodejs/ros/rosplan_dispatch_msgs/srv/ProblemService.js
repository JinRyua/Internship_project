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

class ProblemServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.problem_path = null;
      this.problem_string_response = null;
    }
    else {
      if (initObj.hasOwnProperty('problem_path')) {
        this.problem_path = initObj.problem_path
      }
      else {
        this.problem_path = '';
      }
      if (initObj.hasOwnProperty('problem_string_response')) {
        this.problem_string_response = initObj.problem_string_response
      }
      else {
        this.problem_string_response = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ProblemServiceRequest
    // Serialize message field [problem_path]
    bufferOffset = _serializer.string(obj.problem_path, buffer, bufferOffset);
    // Serialize message field [problem_string_response]
    bufferOffset = _serializer.bool(obj.problem_string_response, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ProblemServiceRequest
    let len;
    let data = new ProblemServiceRequest(null);
    // Deserialize message field [problem_path]
    data.problem_path = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [problem_string_response]
    data.problem_string_response = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.problem_path.length;
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_dispatch_msgs/ProblemServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '82859894b2713514bb229e9171a8b163';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # request a problem to be generated in the problem_path
    string problem_path
    bool problem_string_response
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ProblemServiceRequest(null);
    if (msg.problem_path !== undefined) {
      resolved.problem_path = msg.problem_path;
    }
    else {
      resolved.problem_path = ''
    }

    if (msg.problem_string_response !== undefined) {
      resolved.problem_string_response = msg.problem_string_response;
    }
    else {
      resolved.problem_string_response = false
    }

    return resolved;
    }
};

class ProblemServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.problem_generated = null;
      this.problem_string = null;
    }
    else {
      if (initObj.hasOwnProperty('problem_generated')) {
        this.problem_generated = initObj.problem_generated
      }
      else {
        this.problem_generated = false;
      }
      if (initObj.hasOwnProperty('problem_string')) {
        this.problem_string = initObj.problem_string
      }
      else {
        this.problem_string = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ProblemServiceResponse
    // Serialize message field [problem_generated]
    bufferOffset = _serializer.bool(obj.problem_generated, buffer, bufferOffset);
    // Serialize message field [problem_string]
    bufferOffset = _serializer.string(obj.problem_string, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ProblemServiceResponse
    let len;
    let data = new ProblemServiceResponse(null);
    // Deserialize message field [problem_generated]
    data.problem_generated = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [problem_string]
    data.problem_string = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.problem_string.length;
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_dispatch_msgs/ProblemServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ff9516f549c6dca75ba5761c1ee6ae43';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool problem_generated
    string problem_string
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ProblemServiceResponse(null);
    if (msg.problem_generated !== undefined) {
      resolved.problem_generated = msg.problem_generated;
    }
    else {
      resolved.problem_generated = false
    }

    if (msg.problem_string !== undefined) {
      resolved.problem_string = msg.problem_string;
    }
    else {
      resolved.problem_string = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: ProblemServiceRequest,
  Response: ProblemServiceResponse,
  md5sum() { return '61fb3e0dd88c35b2c75cf0b688f40ee8'; },
  datatype() { return 'rosplan_dispatch_msgs/ProblemService'; }
};
