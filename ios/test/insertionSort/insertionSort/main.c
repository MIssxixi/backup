//
//  main.c
//  insertionSort
//
//  Created by yongjie_zou on 2017/1/18.
//  Copyright © 2017年 yongjie_zou. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>


//Definition for singly-linked list.
struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* insertionSortList(struct ListNode* head) {
    if (head == NULL) {
        return head;
    }
    struct ListNode *prePreNode = NULL;
    struct ListNode *preNode = head;
    struct ListNode *preNextNode = head;
    struct ListNode *nextNode = head->next;
    while (nextNode) {
        preNode = head;
        while (nextNode != NULL && nextNode->val >= preNode->val && nextNode != preNode) {
            prePreNode = preNode;
            preNode = preNode->next;
        }
        
        if (nextNode == preNode) {
            preNextNode = nextNode;
            nextNode = nextNode->next;
            continue;
        }
        
        if (preNode == head) {
            head = nextNode;
            preNextNode->next = nextNode->next;
            nextNode->next = preNode;
        } else {
            preNextNode->next = nextNode->next;
            nextNode->next = preNode;
            prePreNode->next = nextNode;
        }
        preNextNode = nextNode;
        nextNode = nextNode->next;
    }
    
    return head;
}
struct ListNode* testinsertionSortList(struct ListNode* head) {
    struct ListNode *dummy = (struct ListNode *)malloc(sizeof(struct ListNode));
    // 这个dummy的作用是，把head开头的链表一个个的插入到dummy开头的链表里
    // 所以这里不需要dummy->next = head;
    
    while (head != NULL) {
        struct ListNode *temp = dummy;
        struct ListNode *next = head->next;
        while (temp->next != NULL && temp->next->val < head->val) {
            temp = temp->next;
        }
        head->next = temp->next;
        temp->next = head;
        head = next;
    }
    
    return dummy->next;
}

int main(int argc, const char * argv[]) {
    int array[] = {1,2,3,4};
    
    struct ListNode *head = NULL;
    struct ListNode *tempNode = NULL;
    int n = sizeof(array) / sizeof(int);
    int i = 0;
    for (; i < n; i++) {
        struct ListNode *node = (struct ListNode *)malloc(sizeof(struct ListNode));
        node->val = array[i];
        node->next = NULL;
        if (head == NULL) {
            head = node;
            tempNode = node;
        }
        else {
            tempNode->next = node;
            tempNode = node;
        }
    }
    
    struct ListNode *p = testinsertionSortList(head);
    while (p) {
        printf("%d\n", p->val);
        p = p->next;
    }
    
    return 0;
}
