//
//  ABAddressViewModel.m
//  rapp
//
//  Created by qiang.c.fu on 2020/7/20.
//  Copyright © 2020 付强. All rights reserved.
//

#import "ABAddressViewModel.h"
#import <AddressBook/AddressBook.h>
#import <UIKit/UIKit.h>
#import "ABAddress.h"

@implementation ABAddressViewModel
- (NSArray *)getPersonData{
    if (self.dataArray == nil) {
        self.dataArray = [NSMutableArray array];
}
 ABAddressBookRef adressBook = ABAddressBookCreateWithOptions(NULL, NULL);
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        CFErrorRef error = NULL;
        adressBook = ABAddressBookCreateWithOptions(NULL, &error);
        //创建一个初始信号量为0的信号
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        //申请访问权限
          ABAddressBookRequestAccessWithCompletion(adressBook, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        adressBook = ABAddressBookCreate();
    }
    //获取所有联系人的数组
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(adressBook);
    //遍历所有的联系人
    CFIndex peopleCount = CFArrayGetCount(allPeople);
    //如果没有联系人
    if (!peopleCount) {
        NSLog(@"没有任何联系人");
        return @[];
    }

    NSMutableArray *contactsListArrayM = [NSMutableArray array];

    for (NSInteger index=0; index < peopleCount; index++) {
        ABAddress *personModel = [[ABAddress alloc]init];
        NSMutableArray *phoneArrayM = [NSMutableArray array];

        //姓名
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, index);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);

        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;

        if ((__bridge id)abFullName !=nil) {
            nameString = (__bridge NSString *)abFullName;
        }else{
            if ((__bridge id)abLastName != nil) {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        personModel.name = nameString;

        ABRecordID  recordIDs = ABRecordGetRecordID(person);
        //获取联系人电话(一个联系人可能存在多个电话)
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);

        for (NSInteger index = 0; index < phoneCount; index++) {
            NSString *phoneValue = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, index));
            [phoneArrayM addObject:phoneValue];
        }
        NSArray *phonesNumber = [NSArray arrayWithArray:phoneArrayM];
        personModel.phoneNumbers = phonesNumber;

        personModel.imgStr = (__bridge NSData*)ABPersonCopyImageData(person);
//        personModel.recordID = recordIDs;

        [contactsListArrayM addObject:personModel];
        CFRelease(phones);
    }
    CFRelease(adressBook);
    CFRelease(allPeople);
    //C语言部分需要手动释放内存

    self.dataArray = [NSMutableArray arrayWithArray:contactsListArrayM];

    for (ABAddress *model  in self.dataArray) {
        NSLog(@"name:%@ ---%@",model.name, model.phoneNumbers[0]);
    }
    return _dataArray;
}
@end
