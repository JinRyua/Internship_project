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

class CreatePRMRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.nr_waypoints = null;
      this.min_distance = null;
      this.casting_distance = null;
      this.connecting_distance = null;
      this.occupancy_threshold = null;
      this.total_attempts = null;
    }
    else {
      if (initObj.hasOwnProperty('nr_waypoints')) {
        this.nr_waypoints = initObj.nr_waypoints
      }
      else {
        this.nr_waypoints = 0;
      }
      if (initObj.hasOwnProperty('min_distance')) {
        this.min_distance = initObj.min_distance
      }
      else {
        this.min_distance = 0.0;
      }
      if (initObj.hasOwnProperty('casting_distance')) {
        this.casting_distance = initObj.casting_distance
      }
      else {
        this.casting_distance = 0.0;
      }
      if (initObj.hasOwnProperty('connecting_distance')) {
        this.connecting_distance = initObj.connecting_distance
      }
      else {
        this.connecting_distance = 0.0;
      }
      if (initObj.hasOwnProperty('occupancy_threshold')) {
        this.occupancy_threshold = initObj.occupancy_threshold
      }
      else {
        this.occupancy_threshold = 0;
      }
      if (initObj.hasOwnProperty('total_attempts')) {
        this.total_attempts = initObj.total_attempts
      }
      else {
        this.total_attempts = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CreatePRMRequest
    // Serialize message field [nr_waypoints]
    bufferOffset = _serializer.int32(obj.nr_waypoints, buffer, bufferOffset);
    // Serialize message field [min_distance]
    bufferOffset = _serializer.float32(obj.min_distance, buffer, bufferOffset);
    // Serialize message field [casting_distance]
    bufferOffset = _serializer.float32(obj.casting_distance, buffer, bufferOffset);
    // Serialize message field [connecting_distance]
    bufferOffset = _serializer.float32(obj.connecting_distance, buffer, bufferOffset);
    // Serialize message field [occupancy_threshold]
    bufferOffset = _serializer.int8(obj.occupancy_threshold, buffer, bufferOffset);
    // Serialize message field [total_attempts]
    bufferOffset = _serializer.int32(obj.total_attempts, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CreatePRMRequest
    let len;
    let data = new CreatePRMRequest(null);
    // Deserialize message field [nr_waypoints]
    data.nr_waypoints = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [min_distance]
    data.min_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [casting_distance]
    data.casting_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [connecting_distance]
    data.connecting_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [occupancy_threshold]
    data.occupancy_threshold = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [total_attempts]
    data.total_attempts = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 21;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/CreatePRMRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5f7c217e90f8fff8f615b66b6e7c4601';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 nr_waypoints
    float32 min_distance
    float32 casting_distance
    float32 connecting_distance
    int8 occupancy_threshold
    int32 total_attempts
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CreatePRMRequest(null);
    if (msg.nr_waypoints !== undefined) {
      resolved.nr_waypoints = msg.nr_waypoints;
    }
    else {
      resolved.nr_waypoints = 0
    }

    if (msg.min_distance !== undefined) {
      resolved.min_distance = msg.min_distance;
    }
    else {
      resolved.min_distance = 0.0
    }

    if (msg.casting_distance !== undefined) {
      resolved.casting_distance = msg.casting_distance;
    }
    else {
      resolved.casting_distance = 0.0
    }

    if (msg.connecting_distance !== undefined) {
      resolved.connecting_distance = msg.connecting_distance;
    }
    else {
      resolved.connecting_distance = 0.0
    }

    if (msg.occupancy_threshold !== undefined) {
      resolved.occupancy_threshold = msg.occupancy_threshold;
    }
    else {
      resolved.occupancy_threshold = 0
    }

    if (msg.total_attempts !== undefined) {
      resolved.total_attempts = msg.total_attempts;
    }
    else {
      resolved.total_attempts = 0
    }

    return resolved;
    }
};

class CreatePRMResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.waypoints = null;
    }
    else {
      if (initObj.hasOwnProperty('waypoints')) {
        this.waypoints = initObj.waypoints
      }
      else {
        this.waypoints = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CreatePRMResponse
    // Serialize message field [waypoints]
    bufferOffset = _arraySerializer.string(obj.waypoints, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CreatePRMResponse
    let len;
    let data = new CreatePRMResponse(null);
    // Deserialize message field [waypoints]
    data.waypoints = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.waypoints.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/CreatePRMResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '49708eee94ad052e2e6e0398654eb86a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] waypoints
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CreatePRMResponse(null);
    if (msg.waypoints !== undefined) {
      resolved.waypoints = msg.waypoints;
    }
    else {
      resolved.waypoints = []
    }

    return resolved;
    }
};

module.exports = {
  Request: CreatePRMRequest,
  Response: CreatePRMResponse,
  md5sum() { return 'e2d990767484410646d05d82e9a4545b'; },
  datatype() { return 'rosplan_knowledge_msgs/CreatePRM'; }
};
