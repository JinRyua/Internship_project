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
using namespace std;
static const int size=8;
class queens : public Gecode::IntMinimizeScript {
protected:
    Gecode::IntVar objective;
    IntVarArray row;
    IntVarArray col;
public:
    queens(const Gecode::Options& opt) : Gecode::IntMinimizeScript(opt), row(*this,size,1,8),col(*this,size,1,8) {
        IntVarArray x(*this,size,0,8);
        IntVarArray y(*this,size,0,8);
         for(int i=0;i<size;i++){
             x[i]=expr(*this,col[i]-row[i]);        //대각선
             y[i]=expr(*this,row[i]-(size-col[i]));
         }
        //     
        // }
        distinct(*this,x);
        distinct(*this,y);
        distinct(*this,row);
        distinct(*this,col);

        branch(*this,row,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        branch(*this,col,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
    }

    queens(queens& v) : Gecode::IntMinimizeScript(v) {
        row.update(*this,v.row);
        col.update(*this,v.col);
    }

    virtual Space* copy(void) {
        return new queens(*this);
    }

    virtual Gecode::IntVar cost(void) const {
        return objective;
    }

    void print(std::ostream& os) const {
        os<<row<<endl<<col<<endl;
    }
};

int main(int argc, char* argv[]) {
    Gecode::Options opt("");
    opt.time(-1);
    opt.solutions(0);
    opt.threads(5);
    opt.interrupt(false);
    opt.parse(argc, argv);
    opt.mode(Gecode::SM_GIST);

    Gecode::Script::run<queens, Gecode::DFS, Gecode::Options>(opt);

    return 0;
}
