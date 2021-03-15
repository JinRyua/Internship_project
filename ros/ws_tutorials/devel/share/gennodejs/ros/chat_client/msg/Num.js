// Auto-generated. Do not edit!

// (in-package chat_client.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Num {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pub = null;
      this.str = null;
    }
    else {
      if (initObj.hasOwnProperty('pub')) {
        this.pub = initObj.pub
      }
      else {
        this.pub = '';
      }
      if (initObj.hasOwnProperty('str')) {
        this.str = initObj.str
      }
      else {
        this.str = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Num
    // Serialize message field [pub]
    bufferOffset = _serializer.string(obj.pub, buffer, bufferOffset);
    // Serialize message field [str]
    bufferOffset = _serializer.string(obj.str, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Num
    let len;
    let data = new Num(null);
    // Deserialize message field [pub]
    data.pub = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [str]
    data.str = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.pub);
    length += _getByteLength(object.str);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'chat_client/Num';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eaf759e25d19bdc5a284d26603fbb1c8';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string pub
    string str
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Num(null);
    if (msg.pub !== undefined) {
      resolved.pub = msg.pub;
    }
    else {
      resolved.pub = ''
    }

    if (msg.str !== undefined) {
      resolved.str = msg.str;
    }
    else {
      resolved.str = ''
    }

    return resolved;
    }
};

module.exports = Num;
