// Auto-generated. Do not edit!

// (in-package rosplan_dispatch_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ActionDispatch = require('./ActionDispatch.js');

//-----------------------------------------------------------

class CompletePlan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.plan = null;
    }
    else {
      if (initObj.hasOwnProperty('plan')) {
        this.plan = initObj.plan
      }
      else {
        this.plan = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CompletePlan
    // Serialize message field [plan]
    // Serialize the length for message field [plan]
    bufferOffset = _serializer.uint32(obj.plan.length, buffer, bufferOffset);
    obj.plan.forEach((val) => {
      bufferOffset = ActionDispatch.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CompletePlan
    let len;
    let data = new CompletePlan(null);
    // Deserialize message field [plan]
    // Deserialize array length for message field [plan]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.plan = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.plan[i] = ActionDispatch.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.plan.forEach((val) => {
      length += ActionDispatch.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_dispatch_msgs/CompletePlan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7e1d10b4d2f9481e13d9d30c7a8045ff';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #completePlan message
    ActionDispatch[] plan
    
    ================================================================================
    MSG: rosplan_dispatch_msgs/ActionDispatch
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
    const resolved = new CompletePlan(null);
    if (msg.plan !== undefined) {
      resolved.plan = new Array(msg.plan.length);
      for (let i = 0; i < resolved.plan.length; ++i) {
        resolved.plan[i] = ActionDispatch.Resolve(msg.plan[i]);
      }
    }
    else {
      resolved.plan = []
    }

    return resolved;
    }
};

module.exports = CompletePlan;
