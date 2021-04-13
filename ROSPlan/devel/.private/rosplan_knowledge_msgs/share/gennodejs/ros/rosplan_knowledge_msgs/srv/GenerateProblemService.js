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


//-----------------------------------------------------------

class GenerateProblemServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.problem_path = null;
      this.contingent = null;
    }
    else {
      if (initObj.hasOwnProperty('problem_path')) {
        this.problem_path = initObj.problem_path
      }
      else {
        this.problem_path = '';
      }
      if (initObj.hasOwnProperty('contingent')) {
        this.contingent = initObj.contingent
      }
      else {
        this.contingent = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GenerateProblemServiceRequest
    // Serialize message field [problem_path]
    bufferOffset = _serializer.string(obj.problem_path, buffer, bufferOffset);
    // Serialize message field [contingent]
    bufferOffset = _serializer.bool(obj.contingent, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GenerateProblemServiceRequest
    let len;
    let data = new GenerateProblemServiceRequest(null);
    // Deserialize message field [problem_path]
    data.problem_path = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [contingent]
    data.contingent = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.problem_path.length;
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GenerateProblemServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'dae78a0248c75ae0669c86950a3f99cf';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # simple service for generating a PDDL problem with goals from the KMS
    string problem_path
    bool contingent
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GenerateProblemServiceRequest(null);
    if (msg.problem_path !== undefined) {
      resolved.problem_path = msg.problem_path;
    }
    else {
      resolved.problem_path = ''
    }

    if (msg.contingent !== undefined) {
      resolved.contingent = msg.contingent;
    }
    else {
      resolved.contingent = false
    }

    return resolved;
    }
};

class GenerateProblemServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.message = null;
    }
    else {
      if (initObj.hasOwnProperty('message')) {
        this.message = initObj.message
      }
      else {
        this.message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GenerateProblemServiceResponse
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GenerateProblemServiceResponse
    let len;
    let data = new GenerateProblemServiceResponse(null);
    // Deserialize message field [message]
    data.message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.message.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GenerateProblemServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5f003d6bcc824cbd51361d66d8e4f76c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string message
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GenerateProblemServiceResponse(null);
    if (msg.message !== undefined) {
      resolved.message = msg.message;
    }
    else {
      resolved.message = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: GenerateProblemServiceRequest,
  Response: GenerateProblemServiceResponse,
  md5sum() { return '691992df67730037ceca53e2831f2e82'; },
  datatype() { return 'rosplan_knowledge_msgs/GenerateProblemService'; }
};
