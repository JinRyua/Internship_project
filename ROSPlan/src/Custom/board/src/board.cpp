#include "board/board.h"
#include "rosplan_knowledge_msgs/GetInstanceService.h"
#include "rosplan_knowledge_msgs/GetAttributeService.h"
#include "board/display_info.h"


#include <iostream>
#include <string>
#include <chrono>

using namespace std;

namespace Custom{
    Board::Board(ros::NodeHandle &nh)
    {
        node_handle = &nh;

        game_state = IN_GAME; //select menu

        selecting_menu = MENU_START; //start button

        life = 3;
        score = 0;
        
        //set publisher
        std::string display_topic = "/display/display";
        nh.getParam("display_name", display_topic);
        display_pub = nh.advertise<board::display_info>(display_topic, 1000);

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

        //make map space
        init_map.resize(map_row);
        menu.resize(map_row);
    
        for (int i = 0; i < map_row; i++)
        {   for (int j = 0; j < map_col + 1; j++)
            {
                init_map[i].push_back(" ");
                menu[i].push_back(" ");
            }
            init_map[i][map_col] = "\n";
            menu[i][map_col] = "\n";
        }
        map = init_map;

        //agents count get
        ss.str("");
        ss << kb << "state/instances";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        ros::ServiceClient client = nh.serviceClient<rosplan_knowledge_msgs::GetInstanceService>(ss.str());
        rosplan_knowledge_msgs::GetInstanceService srv;
        srv.request.type_name = "agent";
        if (client.call(srv)){
            agent_names = srv.response.instances;
        }
        else{
        }

        ss.str("");
        ss << kb << "state/propositions";
        ros::service::waitForService(ss.str(), ros::Duration(20));
        row_client = nh.serviceClient<rosplan_knowledge_msgs::GetAttributeService>(ss.str());
        row_srv.request.predicate_name = "in-block";
        vector<rosplan_knowledge_msgs::KnowledgeItem> play_agent_temp;
        if (row_client.call(row_srv)){
            play_agent_temp = row_srv.response.attributes;
        }
        else{
        }

        for(int i = 0; i < play_agent_temp.size(); i++){
            string name;
            custom_msgs::axis ax;
            for(int j = 0; j < play_agent_temp[i].values.size(); j++){
                if(play_agent_temp[i].values[j].key == "c"){
                    name = play_agent_temp[i].values[j].value;
                }
                else if(play_agent_temp[i].values[j].key == "p"){
                    string temp_str = play_agent_temp[i].values[j].value;
                    int temp_point = temp_str.find("_");
                    ax.row = stoi(temp_str.substr(5, temp_point - 5));
                    ax.col = stoi(temp_str.substr(temp_point + 1));
                    ax.direction = 1;
                }
            }
            if(name == "player"){
                init_player.push_back(ax);
                player = init_player;
            }else{
                init_agents.push_back(pair<custom_msgs::axis, bool>(ax, false));
                agents = init_agents;
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));
        row_srv.request.predicate_name = "is-menu";
        vector<rosplan_knowledge_msgs::KnowledgeItem> menu_temp;
        if (row_client.call(row_srv)){
            menu_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < menu_temp.size(); i++){
            string name;
            custom_msgs::axis ax;
            if (menu_temp[i].values[0].key == "p"){
                string temp_str = menu_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                menu[ax.row - 1][ax.col - 1] = "■";
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));
        row_srv.request.predicate_name = "is-wall";
        vector<rosplan_knowledge_msgs::KnowledgeItem> map_temp;
        map_temp.clear();
        if (row_client.call(row_srv)){
            map_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < map_temp.size(); i++){
            string name;
            custom_msgs::axis ax;
            if (map_temp[i].values[0].key == "p"){
                string temp_str = map_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                init_map[ax.row - 1][ax.col - 1] = "■";
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));
        row_srv.request.predicate_name = "is-scookie";
        map_temp.clear();
        if (row_client.call(row_srv)){
            map_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < map_temp.size(); i++){
            string name;
            custom_msgs::axis ax;
            if (map_temp[i].values[0].key == "p"){
                string temp_str = map_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                init_map[ax.row - 1][ax.col - 1] = "·";
            }
        }

        ros::service::waitForService(ss.str(), ros::Duration(20));
        row_srv.request.predicate_name = "is-lcookie";
        map_temp.clear();
        if (row_client.call(row_srv)){
            map_temp = row_srv.response.attributes;
        }
        else{
            cout<<"error"<<endl;
        }

        for(int i = 0; i < map_temp.size(); i++){
            string name;
            custom_msgs::axis ax;
            if (map_temp[i].values[0].key == "p"){
                string temp_str = map_temp[i].values[0].value;
                int temp_point = temp_str.find("_");
                ax.row = stoi(temp_str.substr(5, temp_point - 5));
                ax.col = stoi(temp_str.substr(temp_point + 1));
                init_map[ax.row - 1][ax.col - 1] = "●";
            }
        }

        map = init_map;
    }

    Board::~Board() 
    {

    }

    void Board::run_board(){
        board::display_info display_temp;
        vector<custom_msgs::map> map_temp2;
        custom_msgs::map map_temp;
        if(game_state == IN_GAME){
            if(timer > 0){  //timer check

            }
            //display map
            for(int i = 0; i < map.size(); i++){
                map_temp.value = map[i];
                map_temp2.push_back(map_temp);
            }
            display_temp.map = map_temp2;
            //display player
            display_temp.player_axis = player;
            //display agent
            std::vector<custom_msgs::axis> agent_temp;
            std::vector<int> ghost_temp;
            for(int i = 0; i < agents.size(); i++){
                agent_temp.push_back(agents[i].first);
                ghost_temp.push_back(agents[i].second);
            }
            display_temp.agents_axis = agent_temp;
            display_temp.ghost = ghost_temp;

            //display score
            display_temp.score = score;
            //display life
            display_temp.life = life;       
        }
        else if(game_state == IN_MENU){
            //display map
            for(int i = 0; i < map.size(); i++){
                map_temp.value = menu[i];
                map_temp2.push_back(map_temp);
            }
            display_temp.map = map_temp2;
            display_temp.selecting_menu = selecting_menu;
        }
        //publish to display
        display_pub.publish(display_temp);
    }

    bool Board::ask_map_size_callback(board::ask_map_size::Request& req, board::ask_map_size::Response& res){
        res.row = map_row;
        res.col = map_col;
    }
}//close namespace

int main(int argc, char **argv)
{
    ros::init(argc, argv, "board");
    ros::NodeHandle nh("~");

    Custom::Board bi(nh);

    //service
    ros::ServiceServer ask_map_size = nh.advertiseService("/board/ask_map_size", &Custom::Board::ask_map_size_callback,
                                            dynamic_cast<Custom::Board *>(&bi));
    //subscriber
    
    

    std::cout<<"ready to run board"<<std::endl;
    // ROS_INFO("Custom: (%s) Ready to receive", ros::this_node::getName().c_str());
    double act_time = 0.04;
    while (1)
    {
        sleep(0);
        double start_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        ros::spinOnce();

        bi.run_board();

        double finish_time = std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
        double rate = (double)(act_time * 1000000000 - (finish_time - start_time)) / 1000000000;
        if (rate > 0){
            ros::Rate wait = 1 / rate;
            wait.sleep();
        }
    }

    ros::spin();
    return 0;
}