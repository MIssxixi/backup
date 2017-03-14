//
//  main.c
//  ArithmeticTest
//
//  Created by yongjie_zou on 2017/2/24.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#include <stdio.h>

void fun(char *str, int length) {
    int i = 0,j = 0;
    char temp[length*3 + 1];
    while (i < length) {
        if (str[i] == ' '){
            temp[j++] = '%';
            temp[j++] = '2';
            temp[j++] = '0';
        } else {
            temp[j++] = str[i];
        }
        i++;
    }
    temp[j] = '\0';
    
    i = 0;
    while (temp[i] != '\0') {
        str[i] = temp[i];
    }
    str[i] = '\0';
}

int main(int argc, const char * argv[]) {
    // insert code here...
    char *str = "hello world";
    int length = 11;
    fun(str, length);
    printf("%s", str);
    return 0;
}
