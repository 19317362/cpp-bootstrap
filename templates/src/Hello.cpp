#include <iostream>
#include <boost/lexical_cast.hpp>

int main()
{
    std::cout << "Hello world with Boost" << boost::lexical_cast<int>("51") << '\n';
}
