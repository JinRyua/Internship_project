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

class ClassName : public Gecode::IntMinimizeScript {
protected:
    Gecode::IntVar objective;

public:
    ClassName(const Gecode::Options& opt) : Gecode::IntMinimizeScript(opt) {

    }

    ClassName(ClassName& v) : Gecode::IntMinimizeScript(v) {

    }

    virtual Space* copy(void) {
        return new ClassName(*this);
    }

    virtual Gecode::IntVar cost(void) const {
        return objective;
    }

    void print(std::ostream& os) const {

    }
};

int main(int argc, char* argv[]) {
    Gecode::Options opt("");
    opt.time(-1);
    opt.solutions(0);
    opt.threads(8);
    opt.interrupt(false);
    opt.parse(argc, argv);
    opt.mode(Gecode::SM_GIST);

    Gecode::Script::run<ClassName, Gecode::DFS, Gecode::Options>(opt);

    return 0;
}
