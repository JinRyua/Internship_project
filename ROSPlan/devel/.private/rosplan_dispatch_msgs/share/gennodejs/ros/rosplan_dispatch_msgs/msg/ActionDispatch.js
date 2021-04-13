// Auto-generated. Do not edit!

// (in-package rosplan_dispatch_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let diagnostic_msgs = _finder('diagnostic_msgs');

//-----------------------------------------------------------

class ActionDispatch {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.action_id = null;
      this.name = null;
      this.parameters = null;
      this.duration = null;
      this.dispatch_time = null;
    }
    else {
      if (initObj.hasOwnProperty('action_id')) {
        this.action_id = initObj.action_id
      }
      else {
        this.action_id = 0;
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('parameters')) {
        this.parameters = initObj.parameters
      }
      else {
        this.parameters = [];
      }
      if (initObj.hasOwnProperty('duration')) {
        this.duration = initObj.duration
      }
      else {
        this.duration = 0.0;
      }
      if (initObj.hasOwnProperty('dispatch_time')) {
        this.dispatch_time = initObj.dispatch_time
      }
      else {
        this.dispatch_time = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ActionDispatch
    // Serialize message field [action_id]
    bufferOffset = _serializer.int32(obj.action_id, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [parameters]
    // Serialize the length for message field [parameters]
    bufferOffset = _serializer.uint32(obj.parameters.length, buffer, bufferOffset);
    obj.parameters.forEach((val) => {
      bufferOffset = diagnostic_msgs.msg.KeyValue.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [duration]
    bufferOffset = _serializer.float32(obj.duration, buffer, bufferOffset);
    // Serialize message field [dispatch_time]
    bufferOffset = _serializer.float32(obj.dispatch_time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ActionDispatch
    let len;
    let data = new ActionDispatch(null);
    // Deserialize message field [action_id]
    data.action_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [parameters]
    // Deserialize array length for message field [parameters]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.parameters = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.parameters[i] = diagnostic_msgs.msg.KeyValue.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [duration]
    data.duration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dispatch_time]
    data.dispatch_time = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    object.parameters.forEach((val) => {
      length += diagnostic_msgs.msg.KeyValue.getMessageSize(val);
    });
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_dispatch_msgs/ActionDispatch';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '80f1ebdf8c68451c7e598f98e7f12dba';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #actionDispatch message
    int32 action_id
    string name
    diagnostic_msgs/KeyValue[] parameters
    float32 duration
    float32 dispatch_time
    
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
    const resolved = new ActionDispatch(null);
    if (msg.action_id !== undefined) {
      resolved.action_id = msg.action_id;
    }
    else {
      resolved.action_id = 0
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.parameters !== undefined) {
      resolved.parameters = new Array(msg.parameters.length);
      for (let i = 0; i < resolved.parameters.length; ++i) {
        resolved.parameters[i] = diagnostic_msgs.msg.KeyValue.Resolve(msg.parameters[i]);
      }
    }
    else {
      resolved.parameters = []
    }

    if (msg.duration !== undefined) {
      resolved.duration = msg.duration;
    }
    else {
      resolved.duration = 0.0
    }

    if (msg.dispatch_time !== undefined) {
      resolved.dispatch_time = msg.dispatch_time;
    }
    else {
      resolved.dispatch_time = 0.0
    }

    return resolved;
    }
};

module.exports = ActionDispatch;
