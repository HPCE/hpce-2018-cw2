#include "tbb/parallel_for.hpp"

int main()
{
    int n=1000000;
    std::vector<double> parts(n);

    tbb::parallel_for(0, n,
        [&](int i){
            parts[i]=sin(i);
        }
    );

    double res=std::accumulate(parts.begin(), parts.end(), 0.0);

    fprintf(stdout, "sum( sin(i), i=0..%d ) = %f\n", n-1, res);

    return 0;
}
