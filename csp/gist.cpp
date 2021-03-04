#include <gecode/int.hh>    //use integer vari
#include <gecode/search.hh> //access search engine
#include<gecode//gist.hh>

using namespace Gecode;

class SendMoreMoney : public Space{
    protected:
        IntVarArray l;
    public:
        SendMoreMoney(void): l(*this, 8,0,9){
            IntVar s(l[0]),e(l[1]),n(l[2]),d(l[3]),
                    m(l[4]),o(l[5]),r(l[6]),y(l[7]);
            rel(*this,s,IRT_NQ,0);  //constraint?
            rel(*this,m,IRT_NQ,0);  //no leading zeros
            
            distinct(*this,l);  //all letters distinct, constraint

            IntArgs c(4+4+5);//value
            IntVarArgs x(4+4+5);//variable
            //linear equation constraint
            c[0]=1000;  c[1]=100;   c[2]=10;    c[3]=1;
            x[0]=s;     x[1]=e;     x[2]=n;     x[3]=d;
            c[4]=1000;  c[5]=100;   c[6]=10;    c[7]=1;
            x[4]=m;     x[5]=o;     x[6]=r;     x[7]=e;
            c[8]=-10000;  c[9]=-1000;   c[10]=-100;    c[11]=-10;   c[12]=-1;
            x[8]=m;     x[9]=o;     x[10]=n;     x[11]=e;   x[12]=y;
            linear(*this,c,x,IRT_EQ,0);

            //post branching
            branch(*this,l,INT_VAR_SIZE_MIN(),INT_VAL_MIN());
        }

        //search support update
        SendMoreMoney(SendMoreMoney& s) : Space(s){
            l.update(*this,s.l);
        }
        virtual Space* copy(void){
            return new SendMoreMoney(*this);
        }
        //printing solution
        void print(std::ostream& os) const{
            os<<l<<std::endl;
        }
};

int main(int argc, char* argv[]){
    //create model and search engine
        SendMoreMoney* m =new SendMoreMoney;
        Gist::Print<SendMoreMoney> p("Print solution");
        Gist::Options o;
        o.inspect.click(&p);
        Gist::dfs(m,o);
        delete m;
   
    return 0;
}