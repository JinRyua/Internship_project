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

class ActionFeedback {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.action_id = null;
      this.status = null;
      this.information = null;
    }
    else {
      if (initObj.hasOwnProperty('action_id')) {
        this.action_id = initObj.action_id
      }
      else {
        this.action_id = 0;
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = '';
      }
      if (initObj.hasOwnProperty('information')) {
        this.information = initObj.information
      }
      else {
        this.information = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ActionFeedback
    // Serialize message field [action_id]
    bufferOffset = _serializer.int32(obj.action_id, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.string(obj.status, buffer, bufferOffset);
    // Serialize message field [information]
    // Serialize the length for message field [information]
    bufferOffset = _serializer.uint32(obj.information.length, buffer, bufferOffset);
    obj.information.forEach((val) => {
      bufferOffset = diagnostic_msgs.msg.KeyValue.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ActionFeedback
    let len;
    let data = new ActionFeedback(null);
    // Deserialize message field [action_id]
    data.action_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [information]
    // Deserialize array length for message field [information]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.information = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.information[i] = diagnostic_msgs.msg.KeyValue.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.status.length;
    object.information.forEach((val) => {
      length += diagnostic_msgs.msg.KeyValue.getMessageSize(val);
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_dispatch_msgs/ActionFeedback';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e28991799802dd700e1390bf56614b89';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #actionFeedback message
    int32 action_id
    string status
    diagnostic_msgs/KeyValue[] information
    
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
    const resolved = new ActionFeedback(null);
    if (msg.action_id !== undefined) {
      resolved.action_id = msg.action_id;
    }
    else {
      resolved.action_id = 0
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = ''
    }

    if (msg.information !== undefined) {
      resolved.information = new Array(msg.information.length);
      for (let i = 0; i < resolved.information.length; ++i) {
        resolved.information[i] = diagnostic_msgs.msg.KeyValue.Resolve(msg.information[i]);
      }
    }
    else {
      resolved.information = []
    }

    return resolved;
    }
};

module.exports = ActionFeedback;
