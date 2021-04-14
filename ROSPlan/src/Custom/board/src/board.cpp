#include "board/board.h"
#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "rosplan_knowledge_msgs/GetAttributeService.h"

#include <iostream>
#include <string>

using namespace std;

namespace Custom{
    Board::Board(ros::NodeHandle &nh)
    {
        node_handle = &nh;

        game_state = 0; //select menu

        selecting_menu = 0; //start button

        life = 3;
        score = 0;

        kb = "/rosplan_knowledge_base/"; // "knowledge_base";
        nh.getParam("knowledge_base", kb);


        //map_row, col get
        std::stringstream ss;
        ss << kb << "state/functions";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient row_client = nh.serviceClient<rosplan_knowledge_msgs::GetAttributeService>(ss.str());
        rosplan_knowledge_msgs::GetAttributeService row_srv;
        row_srv.request.predicate_name = "row";
        vector<rosplan_knowledge_msgs::KnowledgeItem> row_temp;
        if (row_client.call(row_srv)){
            row_temp = row_srv.response.attributes;
            map_row = row_temp[0].function_value;
        }
        else{
        }
        row_srv.request.predicate_name = "col";
        if (row_client.call(row_srv)){
            row_temp = row_srv.response.attributes;
            map_col = row_temp[0].function_value;
        }
        else{
        }

        //make map
        init_map.reserve(map_row);
        map.reserve(map_row);
        for(int i = 0; i < map_row; i++){
            init_map[i].reserve(map_col);
            map[i].reserve(map_col);
        }
            
        //agents count get
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient client = nh.serviceClient<rosplan_knowledge_msgs::GetInstanceService>(ss.str());
        rosplan_knowledge_msgs::GetInstanceService srv;
        srv.request.type_name = "agent";
        if (client.call(srv)){
            agent_names = srv.response.instances;
        }
        else{
        }


        
        for(int i = 0;i < agent_names.size(); i++)
            cout<<agent_names[i]<<endl;
        // KB_name = "/rosplan_knowledge_base/";
        // nh.getParam("KB_name", KB_name);
        // get_KB_types = n.serviceClient<new_Interface::GetDomainTypeService>(KB_name+"domain/types");
        // new_Interface::GetInstanceMatrixService srv;
        // srv.request.instance_name = node_id;
        // if (get_instance_matrix_client.call(srv))
        // {
        //     x = srv.response.point.x;
        //     y = srv.response.point.y;
        // }
        // else
        // {
        //     ROS_ERROR("KCL: (RPActionInterface) could not call Agent_manager_Instance_Service");
        //     return 0;
        // }
    }

    Board::~Board() 
    {

    }

}//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "board");
    ros::NodeHandle nh("~");

    Custom::Board bi(nh);

    //subscriber
    
    

    std::cout<<"ready to run board"<<std::endl;
    // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());


    ros::spin();
    return 0;
}