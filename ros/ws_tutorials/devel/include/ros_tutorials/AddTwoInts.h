// Generated by gencpp from file ros_tutorials/AddTwoInts.msg
// DO NOT EDIT!


#ifndef ROS_TUTORIALS_MESSAGE_ADDTWOINTS_H
#define ROS_TUTORIALS_MESSAGE_ADDTWOINTS_H

#include <ros/service_traits.h>


#include <ros_tutorials/AddTwoIntsRequest.h>
#include <ros_tutorials/AddTwoIntsResponse.h>


namespace ros_tutorials
{

struct AddTwoInts
{

typedef AddTwoIntsRequest Request;
typedef AddTwoIntsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct AddTwoInts
} // namespace ros_tutorials


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::ros_tutorials::AddTwoInts > {
  static const char* value()
  {
    return "6a2e34150c00229791cc89ff309fff21";
  }

  static const char* value(const ::ros_tutorials::AddTwoInts&) { return value(); }
};

template<>
struct DataType< ::ros_tutorials::AddTwoInts > {
  static const char* value()
  {
    return "ros_tutorials/AddTwoInts";
  }

  static const char* value(const ::ros_tutorials::AddTwoInts&) { return value(); }
};


// service_traits::MD5Sum< ::ros_tutorials::AddTwoIntsRequest> should match
// service_traits::MD5Sum< ::ros_tutorials::AddTwoInts >
template<>
struct MD5Sum< ::ros_tutorials::AddTwoIntsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::ros_tutorials::AddTwoInts >::value();
  }
  static const char* value(const ::ros_tutorials::AddTwoIntsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::ros_tutorials::AddTwoIntsRequest> should match
// service_traits::DataType< ::ros_tutorials::AddTwoInts >
template<>
struct DataType< ::ros_tutorials::AddTwoIntsRequest>
{
  static const char* value()
  {
    return DataType< ::ros_tutorials::AddTwoInts >::value();
  }
  static const char* value(const ::ros_tutorials::AddTwoIntsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::ros_tutorials::AddTwoIntsResponse> should match
// service_traits::MD5Sum< ::ros_tutorials::AddTwoInts >
template<>
struct MD5Sum< ::ros_tutorials::AddTwoIntsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::ros_tutorials::AddTwoInts >::value();
  }
  static const char* value(const ::ros_tutorials::AddTwoIntsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::ros_tutorials::AddTwoIntsResponse> should match
// service_traits::DataType< ::ros_tutorials::AddTwoInts >
template<>
struct DataType< ::ros_tutorials::AddTwoIntsResponse>
{
  static const char* value()
  {
    return DataType< ::ros_tutorials::AddTwoInts >::value();
  }
  static const char* value(const ::ros_tutorials::AddTwoIntsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ROS_TUTORIALS_MESSAGE_ADDTWOINTS_H
