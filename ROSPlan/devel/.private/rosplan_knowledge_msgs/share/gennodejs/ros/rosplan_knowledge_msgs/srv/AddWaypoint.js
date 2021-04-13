// Auto-generated. Do not edit!

// (in-package rosplan_knowledge_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class AddWaypointRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.waypoint = null;
      this.connecting_distance = null;
      this.occupancy_threshold = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = '';
      }
      if (initObj.hasOwnProperty('waypoint')) {
        this.waypoint = initObj.waypoint
      }
      else {
        this.waypoint = new geometry_msgs.msg.PoseStamped();
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
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AddWaypointRequest
    // Serialize message field [id]
    bufferOffset = _serializer.string(obj.id, buffer, bufferOffset);
    // Serialize message field [waypoint]
    bufferOffset = geometry_msgs.msg.PoseStamped.serialize(obj.waypoint, buffer, bufferOffset);
    // Serialize message field [connecting_distance]
    bufferOffset = _serializer.float32(obj.connecting_distance, buffer, bufferOffset);
    // Serialize message field [occupancy_threshold]
    bufferOffset = _serializer.int8(obj.occupancy_threshold, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AddWaypointRequest
    let len;
    let data = new AddWaypointRequest(null);
    // Deserialize message field [id]
    data.id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [waypoint]
    data.waypoint = geometry_msgs.msg.PoseStamped.deserialize(buffer, bufferOffset);
    // Deserialize message field [connecting_distance]
    data.connecting_distance = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [occupancy_threshold]
    data.occupancy_threshold = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.id.length;
    length += geometry_msgs.msg.PoseStamped.getMessageSize(object.waypoint);
    return length + 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/AddWaypointRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fbea0e8b407ac37bdef7686a7516a2fd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string id
    geometry_msgs/PoseStamped waypoint
    float32 connecting_distance
    int8 occupancy_threshold
    
    ================================================================================
    MSG: geometry_msgs/PoseStamped
    # A Pose with reference coordinate frame and timestamp
    Header header
    Pose pose
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AddWaypointRequest(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = ''
    }

    if (msg.waypoint !== undefined) {
      resolved.waypoint = geometry_msgs.msg.PoseStamped.Resolve(msg.waypoint)
    }
    else {
      resolved.waypoint = new geometry_msgs.msg.PoseStamped()
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

    return resolved;
    }
};

class AddWaypointResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AddWaypointResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AddWaypointResponse
    let len;
    let data = new AddWaypointResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/AddWaypointResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AddWaypointResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: AddWaypointRequest,
  Response: AddWaypointResponse,
  md5sum() { return 'fbea0e8b407ac37bdef7686a7516a2fd'; },
  datatype() { return 'rosplan_knowledge_msgs/AddWaypoint'; }
};
