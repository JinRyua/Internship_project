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

class GetDomainTypeServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainTypeServiceRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainTypeServiceRequest
    let len;
    let data = new GetDomainTypeServiceRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainTypeServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Fetching the Domain (1/3):
    # Get all types in the domain.
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainTypeServiceRequest(null);
    return resolved;
    }
};

class GetDomainTypeServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.types = null;
      this.super_types = null;
    }
    else {
      if (initObj.hasOwnProperty('types')) {
        this.types = initObj.types
      }
      else {
        this.types = [];
      }
      if (initObj.hasOwnProperty('super_types')) {
        this.super_types = initObj.super_types
      }
      else {
        this.super_types = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainTypeServiceResponse
    // Serialize message field [types]
    bufferOffset = _arraySerializer.string(obj.types, buffer, bufferOffset, null);
    // Serialize message field [super_types]
    bufferOffset = _arraySerializer.string(obj.super_types, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainTypeServiceResponse
    let len;
    let data = new GetDomainTypeServiceResponse(null);
    // Deserialize message field [types]
    data.types = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [super_types]
    data.super_types = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.types.forEach((val) => {
      length += 4 + val.length;
    });
    object.super_types.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainTypeServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8cb6e21c43cdf2ec143646b3aeb9fd3d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] types
    string[] super_types
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainTypeServiceResponse(null);
    if (msg.types !== undefined) {
      resolved.types = msg.types;
    }
    else {
      resolved.types = []
    }

    if (msg.super_types !== undefined) {
      resolved.super_types = msg.super_types;
    }
    else {
      resolved.super_types = []
    }

    return resolved;
    }
};

module.exports = {
  Request: GetDomainTypeServiceRequest,
  Response: GetDomainTypeServiceResponse,
  md5sum() { return '8cb6e21c43cdf2ec143646b3aeb9fd3d'; },
  datatype() { return 'rosplan_knowledge_msgs/GetDomainTypeService'; }
};
