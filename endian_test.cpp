

#include <iostream>

using namespace std;

int main(){


    int n = 1;
    // little endian if true
    if(*(char *)&n == 1) {

        cout << "System is little endian";

    } else {

        cout << "System is big endian";

    }


    return 0;

}
