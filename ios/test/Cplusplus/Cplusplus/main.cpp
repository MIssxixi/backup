//
//  main.cpp
//  Cplusplus
//
//  Created by yongjie_zou on 2017/2/24.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#include <iostream>

class Solution {
public:
    void replaceSpace(char *str,int length) {
        char s[3] = "fa";
        str = s;
    }
};

int main(int argc, const char * argv[]) {
    // insert code here...
    char *s = "ab";
    Solution a;
    a.replaceSpace(s, 3);
    std::cout << s;
    return 0;
}
