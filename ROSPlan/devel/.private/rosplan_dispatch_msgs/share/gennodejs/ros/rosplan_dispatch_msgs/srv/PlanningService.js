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

class PlanningServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.domain_path = null;
      this.problem_path = null;
      this.data_path = null;
      this.planner_command = null;
      this.use_problem_topic = null;
    }
    else {
      if (initObj.hasOwnProperty('domain_path')) {
        this.domain_path = initObj.domain_path
      }
      else {
        this.domain_path = '';
      }
      if (initObj.hasOwnProperty('problem_path')) {
        this.problem_path = initObj.problem_path
      }
      else {
        this.problem_path = '';
      }
      if (initObj.hasOwnProperty('data_path')) {
        this.data_path = initObj.data_path
      }
      else {
        this.data_path = '';
      }
      if (initObj.hasOwnProperty('planner_command')) {
        this.planner_command = initObj.planner_command
      }
      else {
        this.planner_command = '';
      }
      if (initObj.hasOwnProperty('use_problem_topic')) {
        this.use_problem_topic = initObj.use_problem_topic
      }
      else {
        this.use_problem_topic = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PlanningServiceRequest
    // Serialize message field [domain_path]
    bufferOffset = _serializer.string(obj.domain_path, buffer, bufferOffset);
    // Serialize message field [problem_path]
    bufferOffset = _serializer.string(obj.problem_path, buffer, bufferOffset);
    // Serialize message field [data_path]
    bufferOffset = _serializer.string(obj.data_path, buffer, bufferOffset);
    // Serialize message field [planner_command]
    bufferOffset = _serializer.string(obj.planner_command, buffer, bufferOffset);
    // Serialize message field [use_problem_topic]
    bufferOffset = _serializer.bool(obj.use_problem_topic, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PlanningServiceRequest
    let len;
    let data = new PlanningServiceRequest(null);
    // Deserialize message field [domain_path]
    data.domain_path = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [problem_path]
    data.problem_path = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [data_path]
    data.data_path = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [planner_command]
    data.planner_command = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [use_problem_topic]
    data.use_problem_topic = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.domain_path.length;
    length += object.problem_path.length;
    length += object.data_path.length;
    length += object.planner_command.length;
    return length + 17;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_dispatch_msgs/PlanningServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '210fd848e2bbec583085545632e9c418';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # starts the planning and dispatch
    string domain_path
    string problem_path
    string data_path
    string planner_command
    bool use_problem_topic
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PlanningServiceRequest(null);
    if (msg.domain_path !== undefined) {
      resolved.domain_path = msg.domain_path;
    }
    else {
      resolved.domain_path = ''
    }

    if (msg.problem_path !== undefined) {
      resolved.problem_path = msg.problem_path;
    }
    else {
      resolved.problem_path = ''
    }

    if (msg.data_path !== undefined) {
      resolved.data_path = msg.data_path;
    }
    else {
      resolved.data_path = ''
    }

    if (msg.planner_command !== undefined) {
      resolved.planner_command = msg.planner_command;
    }
    else {
      resolved.planner_command = ''
    }

    if (msg.use_problem_topic !== undefined) {
      resolved.use_problem_topic = msg.use_problem_topic;
    }
    else {
      resolved.use_problem_topic = false
    }

    return resolved;
    }
};

class PlanningServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.plan_found = null;
    }
    else {
      if (initObj.hasOwnProperty('plan_found')) {
        this.plan_found = initObj.plan_found
      }
      else {
        this.plan_found = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PlanningServiceResponse
    // Serialize message field [plan_found]
    bufferOffset = _serializer.bool(obj.plan_found, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PlanningServiceResponse
    let len;
    let data = new PlanningServiceResponse(null);
    // Deserialize message field [plan_found]
    data.plan_found = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_dispatch_msgs/PlanningServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6541069453c664f560eb34e369510c16';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool plan_found
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PlanningServiceResponse(null);
    if (msg.plan_found !== undefined) {
      resolved.plan_found = msg.plan_found;
    }
    else {
      resolved.plan_found = false
    }

    return resolved;
    }
};

module.exports = {
  Request: PlanningServiceRequest,
  Response: PlanningServiceResponse,
  md5sum() { return 'b620a1e7a07d465aa5a10fe0ee615756'; },
  datatype() { return 'rosplan_dispatch_msgs/PlanningService'; }
};
