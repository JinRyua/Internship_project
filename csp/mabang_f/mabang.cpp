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
static const int size=3;
static const int number=15;
class mabang : public Gecode::IntMinimizeScript {
protected:
    Gecode::IntVar objective;
    IntVarArray num;
public:
    mabang(const Gecode::Options& opt) : Gecode::IntMinimizeScript(opt), num(*this,size*size,1,size*size) {
        
        IntArgs temp(3);
        temp[0]=1;temp[1]=1;temp[2]=1;
        IntVarArgs x1(size),x2(size),x3(size);
        IntVarArgs y1(size),y2(size),y3(size);
        IntVarArgs r(size),l(size);

        for(int i=0;i<size;i++){
            x1[i]=num[size*i];
            x2[i]=num[size*i+1];
            x3[i]=num[size*i+2];
            y1[i]=num[i];
            y2[i]=num[size+i];
            y3[i]=num[(size*2)+i];
            r[i]=num[(size*i)+i];
            l[i]=num[(size*i)+(size-i-1)];
        }
        distinct(*this,num);
        //rel(*this,x1[0]+x1[1]+x1[2]==15);
        linear(*this,temp,x1,IRT_EQ,number);
        linear(*this,temp,x2,IRT_EQ,number);
        linear(*this,temp,x3,IRT_EQ,number);
        linear(*this,temp,y1,IRT_EQ,number);
        linear(*this,temp,y2,IRT_EQ,number);
        linear(*this,temp,y3,IRT_EQ,number);
        linear(*this,temp,r,IRT_EQ,number);
        linear(*this,temp,l,IRT_EQ,number);
        branch(*this,num,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
    }

    mabang(mabang& v) : Gecode::IntMinimizeScript(v) {
        num.update(*this,v.num);
    }

    virtual Space* copy(void) {
        return new mabang(*this);
    }

    virtual Gecode::IntVar cost(void) const {
        return objective;
    }

    void print(std::ostream& os) const {
        for(int i=0;i<size;i++){
            for(int j=0;j<size;j++){
                os<<num[(i*size)+j]<<" ";
            }
            os<<endl;
        }
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

    Gecode::Script::run<mabang, Gecode::DFS, Gecode::Options>(opt);

    return 0;
}
