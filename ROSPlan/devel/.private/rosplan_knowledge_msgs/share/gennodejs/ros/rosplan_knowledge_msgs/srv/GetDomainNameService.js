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

class GetDomainNameServiceRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainNameServiceRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainNameServiceRequest
    let len;
    let data = new GetDomainNameServiceRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainNameServiceRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Fetching the Domain (0/3):
    # Get the domain name.
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainNameServiceRequest(null);
    return resolved;
    }
};

class GetDomainNameServiceResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.domain_name = null;
    }
    else {
      if (initObj.hasOwnProperty('domain_name')) {
        this.domain_name = initObj.domain_name
      }
      else {
        this.domain_name = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetDomainNameServiceResponse
    // Serialize message field [domain_name]
    bufferOffset = _serializer.string(obj.domain_name, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetDomainNameServiceResponse
    let len;
    let data = new GetDomainNameServiceResponse(null);
    // Deserialize message field [domain_name]
    data.domain_name = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.domain_name.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'rosplan_knowledge_msgs/GetDomainNameServiceResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '60174b39a7780212f0384c8d050df5a0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string domain_name
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetDomainNameServiceResponse(null);
    if (msg.domain_name !== undefined) {
      resolved.domain_name = msg.domain_name;
    }
    else {
      resolved.domain_name = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: GetDomainNameServiceRequest,
  Response: GetDomainNameServiceResponse,
  md5sum() { return '60174b39a7780212f0384c8d050df5a0'; },
  datatype() { return 'rosplan_knowledge_msgs/GetDomainNameService'; }
};
