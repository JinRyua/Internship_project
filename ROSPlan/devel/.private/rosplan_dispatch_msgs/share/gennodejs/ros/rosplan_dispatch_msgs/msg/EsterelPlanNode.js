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

class EsterelPlanNode {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.node_type = null;
      this.node_id = null;
      this.name = null;
      this.action = null;
      this.edges_out = null;
      this.edges_in = null;
    }
    else {
      if (initObj.hasOwnProperty('node_type')) {
        this.node_type = initObj.node_type
      }
      else {
        this.node_type = 0;
      }
      if (initObj.hasOwnProperty('node_id')) {
        this.node_id = initObj.node_id
      }
      else {
        this.node_id = 0;
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = new ActionDispatch();
      }
      if (initObj.hasOwnProperty('edges_out')) {
        this.edges_out = initObj.edges_out
      }
      else {
        this.edges_out = [];
      }
      if (initObj.hasOwnProperty('edges_in')) {
        this.edges_in = initObj.edges_in
      }
      else {
        this.edges_in = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EsterelPlanNode
    // Serialize message field [node_type]
    bufferOffset = _serializer.byte(obj.node_type, buffer, bufferOffset);
    // Serialize message field [node_id]
    bufferOffset = _serializer.int32(obj.node_id, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [action]
    bufferOffset = ActionDispatch.serialize(obj.action, buffer, bufferOffset);
    // Serialize message field [edges_out]
    bufferOffset = _arraySerializer.int32(obj.edges_out, buffer, bufferOffset, null);
    // Serialize message field [edges_in]
    bufferOffset = _arraySerializer.int32(obj.edges_in, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EsterelPlanNode
    let len;
    let data = new EsterelPlanNode(null);
    // Deserialize message field [node_type]
    data.node_type = _deserializer.byte(buffer, bufferOffset);
    // Deserialize message field [node_id]
    data.node_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [action]
    data.action = ActionDispatch.deserialize(buffer, bufferOffset);
    // Deserialize message field [edges_out]
    data.edges_out = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [edges_in]
    data.edges_in = _arrayDeserializer.int32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.name.length;
    length += ActionDispatch.getMessageSize(object.action);
    length += 4 * object.edges_out.length;
    length += 4 * object.edges_in.length;
    return length + 17;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_dispatch_msgs/EsterelPlanNode';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'da4ec1de4a3a375abc1d2472c95de8b7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #EsterelPlanNode message
    
    byte ACTION_START = 0
    byte ACTION_END   = 1
    byte PLAN_START   = 2
    
    byte node_type
    int32 node_id
    string name
    rosplan_dispatch_msgs/ActionDispatch action
    
    int32[] edges_out
    int32[] edges_in
    
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
    const resolved = new EsterelPlanNode(null);
    if (msg.node_type !== undefined) {
      resolved.node_type = msg.node_type;
    }
    else {
      resolved.node_type = 0
    }

    if (msg.node_id !== undefined) {
      resolved.node_id = msg.node_id;
    }
    else {
      resolved.node_id = 0
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.action !== undefined) {
      resolved.action = ActionDispatch.Resolve(msg.action)
    }
    else {
      resolved.action = new ActionDispatch()
    }

    if (msg.edges_out !== undefined) {
      resolved.edges_out = msg.edges_out;
    }
    else {
      resolved.edges_out = []
    }

    if (msg.edges_in !== undefined) {
      resolved.edges_in = msg.edges_in;
    }
    else {
      resolved.edges_in = []
    }

    return resolved;
    }
};

// Constants for message
EsterelPlanNode.Constants = {
  ACTION_START: 0,
  ACTION_END: 1,
  PLAN_START: 2,
}

module.exports = EsterelPlanNode;
