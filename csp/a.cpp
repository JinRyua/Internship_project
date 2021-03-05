#include <gecode/int.hh>
#include <gecode/minimodel.hh>
#include <gecode/search.hh>
#include <gecode/gist.hh>
#include <gecode/driver.hh>
#include <algorithm>
#include <vector>
#include <map>
#include <string>
#include <fstream>
#include <sstream>

using namespace Gecode;

static const int size=8;
class queens: public Space{
    protected:
        IntVarArray l;
    public:
        queens(void): l(*this, size*2,1,20){
            IntVarArgs row(size);
        IntVarArgs col(size);
        //IntVarArray x(*this,size,0,1);
        for(int i=0;i<=size;i++){
            row[i]=l[i];
            col[i]=l[size+i];
            //x[i]=expr(*this,row[i]-col[i]);
        }
        //distinct(*this,x);
        distinct(*this,row);
        distinct(*this,col);

        branch(*this,l,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        }

        //search support update
        queens(queens& s) : Space(s){
            l.update(*this,s.l);
        }
        virtual Space* copy(void){
            return new queens(*this);
        }
        //printing solution
        void print(std::ostream& os) const{
            os<<l<<std::endl;
        }
};

int main(int argc, char* argv[]){
    //create model and search engine
        queens* m =new queens;
        Gist::Print<queens> p("Print solution");
        Gist::Options o;
        o.inspect.click(&p);
        Gist::dfs(m,o);
        delete m;
   
    return 0;
}