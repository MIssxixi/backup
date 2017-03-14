//
//  main.cpp
//  ArithmeticCPPTest
//
//  Created by yongjie_zou on 2017/2/28.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#include <iostream>
#include <vector>

using namespace std;

int Fibonacci(int n) {
    if (n == 0) {
        return 0;
    }
    if (n < 2) {
        return 1;
    }
    
    int result = 0;
    int n_1 = 0;
    int n_2 = 1;
    for (int i = 2; <#condition#>; <#increment#>) {
        <#statements#>
    }
    
    return Fibonacci(n - 1) + Fibonacci(n - 2);
}

int main(int argc, const char * argv[]) {
    // insert code here...
    int array[] = {3, 4, 1, 2};
    vector<int> rotateArray(array, array + 4);
    int minimum;
    
    if (rotateArray.empty()) {
        minimum = 0;
    } else if (rotateArray.size() == 1) {
        minimum = rotateArray[0];
    } else {
        minimum = rotateArray.back();
        int i = 1;
        while (i < rotateArray.size()) {
            if (rotateArray[i - 1] > rotateArray[i]) {
                i++;
                break;
            }
            i++;
        }
        if (minimum > rotateArray[i - 1]) {
            minimum = rotateArray[i - 1];
        }
    }
    
//    std::cout << minimum;
    cout << Fibonacci(2);
    return 0;
}
