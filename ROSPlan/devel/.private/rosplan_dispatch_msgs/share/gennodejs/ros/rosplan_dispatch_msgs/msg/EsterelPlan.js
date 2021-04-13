// Auto-generated. Do not edit!

// (in-package rosplan_dispatch_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let EsterelPlanNode = require('./EsterelPlanNode.js');
let EsterelPlanEdge = require('./EsterelPlanEdge.js');

//-----------------------------------------------------------

class EsterelPlan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.nodes = null;
      this.edges = null;
    }
    else {
      if (initObj.hasOwnProperty('nodes')) {
        this.nodes = initObj.nodes
      }
      else {
        this.nodes = [];
      }
      if (initObj.hasOwnProperty('edges')) {
        this.edges = initObj.edges
      }
      else {
        this.edges = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EsterelPlan
    // Serialize message field [nodes]
    // Serialize the length for message field [nodes]
    bufferOffset = _serializer.uint32(obj.nodes.length, buffer, bufferOffset);
    obj.nodes.forEach((val) => {
      bufferOffset = EsterelPlanNode.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [edges]
    // Serialize the length for message field [edges]
    bufferOffset = _serializer.uint32(obj.edges.length, buffer, bufferOffset);
    obj.edges.forEach((val) => {
      bufferOffset = EsterelPlanEdge.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EsterelPlan
    let len;
    let data = new EsterelPlan(null);
    // Deserialize message field [nodes]
    // Deserialize array length for message field [nodes]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.nodes = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.nodes[i] = EsterelPlanNode.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [edges]
    // Deserialize array length for message field [edges]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.edges = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.edges[i] = EsterelPlanEdge.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.nodes.forEach((val) => {
      length += EsterelPlanNode.getMessageSize(val);
    });
    object.edges.forEach((val) => {
      length += EsterelPlanEdge.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rosplan_dispatch_msgs/EsterelPlan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e505c1d88305f080c9c58693879a1a79';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #EsterelPlan message
    EsterelPlanNode[] nodes
    EsterelPlanEdge[] edges
    
    ================================================================================
    MSG: rosplan_dispatch_msgs/EsterelPlanNode
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
    
    ================================================================================
    MSG: rosplan_dispatch_msgs/EsterelPlanEdge
    #EsterelPlanEdge message
    int32 edge_id
    string edge_name
    int32 signal_type
    int32[] source_ids
    int32[] sink_ids
    float64 duration_lower_bound
    float64 duration_upper_bound
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new EsterelPlan(null);
    if (msg.nodes !== undefined) {
      resolved.nodes = new Array(msg.nodes.length);
      for (let i = 0; i < resolved.nodes.length; ++i) {
        resolved.nodes[i] = EsterelPlanNode.Resolve(msg.nodes[i]);
      }
    }
    else {
      resolved.nodes = []
    }

    if (msg.edges !== undefined) {
      resolved.edges = new Array(msg.edges.length);
      for (let i = 0; i < resolved.edges.length; ++i) {
        resolved.edges[i] = EsterelPlanEdge.Resolve(msg.edges[i]);
      }
    }
    else {
      resolved.edges = []
    }

    return resolved;
    }
};

module.exports = EsterelPlan;
