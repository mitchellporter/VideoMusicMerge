//
//  App_config_file.h
//  Font_app
//
//  Created by Gurpreet Singh on 23/07/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#ifndef Font_app_App_config_file_h
#define Font_app_App_config_file_h

//# To check ios versions

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//# Some macros to use in font manager

#define k_character_is [[str substringWithRange:NSMakeRange(i, 1)] isEqualToString:k_default_font[j]]
    // match character

#define k_newstr [newstr stringByAppendingString:selected_font[j]]
    //adding character with selected font

#define k_newstr_default [newstr stringByAppendingString:[str substringWithRange:NSMakeRange(i, 1)]]
    // adding characte with default font


//# Other defaults

#define k_Email_Subject @"FontAPP Sharing"


#endif
