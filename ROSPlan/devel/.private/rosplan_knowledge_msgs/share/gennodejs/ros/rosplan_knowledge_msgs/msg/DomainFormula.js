// Auto-generated. Do not edit!

// (in-package rosplan_knowledge_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let diagnostic_msgs = _finder('diagnostic_msgs');

//-----------------------------------------------------------

class DomainFormula {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.typed_parameters = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('typed_parameters')) {
        this.typed_parameters = initObj.typed_parameters
      }
      else {
        this.typed_parameters = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DomainFormula
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [typed_parameters]
    // Serialize the length for message field [typed_parameters]
    bufferOffset = _serializer.uint32(obj.typed_parameters.length, buffer, bufferOffset);
    obj.typed_parameters.forEach((val) => {
      bufferOffset = diagnostic_msgs.msg.KeyValue.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DomainFormula
    let len;
    let data = new DomainFormula(null);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [typed_parameters]
    // Deserialize array length for message field [typed_parameters]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.typed_parameters = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.typed_parameters[i] = diagnostic_msgs.msg.KeyValue.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    object.typed_parameters.forEach((val) => {
      length += diagnostic_msgs.msg.KeyValue.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_knowledge_msgs/DomainFormula';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b9c7cfc3aa64764d3a82f96d3671bab1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new DomainFormula(null);
    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.typed_parameters !== undefined) {
      resolved.typed_parameters = new Array(msg.typed_parameters.length);
      for (let i = 0; i < resolved.typed_parameters.length; ++i) {
        resolved.typed_parameters[i] = diagnostic_msgs.msg.KeyValue.Resolve(msg.typed_parameters[i]);
      }
    }
    else {
      resolved.typed_parameters = []
    }

    return resolved;
    }
};

module.exports = DomainFormula;
