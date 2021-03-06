//
//  ISInfoModifier.m
//  IPASigner
//
//  Created by 冷秋 on 2019/10/18.
//  Copyright © 2019 Magic-Unique. All rights reserved.
//

#import "ISInfoModifier.h"
#import "MUPath+IPA.h"

@implementation ISInfoModifier

+ (void)setBundle:(MUPath *)bundle bundleID:(NSString *)bundleID {
	NSString *newMainBundleID = bundleID;
	NSString *oldMainBundleID = bundle.CFBundleIdentifier;
	
	CLInfo(@"%@ = %@", bundle.lastPathComponent, newMainBundleID);
	bundle.CFBundleIdentifier = newMainBundleID;
	
	if (bundle.isApp) {
		[bundle.allPlugInApps enumerateObjectsUsingBlock:^(MUPath * _Nonnull appex, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString *oldAppexBundleID = appex.CFBundleIdentifier;
			NSString *newAppexBundleID = [oldAppexBundleID stringByReplacingOccurrencesOfString:oldMainBundleID withString:newMainBundleID];
			[self setBundle:appex bundleID:newAppexBundleID];
		}];
		[bundle.allWatchApps enumerateObjectsUsingBlock:^(MUPath * _Nonnull watch, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString *oldWatchBundleID = watch.CFBundleIdentifier;
			NSString *newWatchBundleID = [oldWatchBundleID stringByReplacingOccurrencesOfString:oldMainBundleID withString:newMainBundleID];
			[self setBundle:watch bundleID:newWatchBundleID];
		}];
	}
}

+ (void)setBundle:(MUPath *)bundle iTunesFileSharingEnable:(BOOL)enable {
	if (enable) {
		CLInfo(@"Enable iTunes file sharing.");
		bundle.UIFileSharingEnabled = YES;
	} else {
		CLInfo(@"Disable iTunes file sharing.");
		bundle.UIFileSharingEnabled = NO;
	}
}

+ (void)setBundle:(MUPath *)bundle bundleShortVersionString:(NSString *)version {
	CLInfo(@"%@ = %@ ", bundle.lastPathComponent, version);
	bundle.CFBundleShortVersionString = version;
	
	if (bundle.isApp) {
		[bundle.allPlugInApps enumerateObjectsUsingBlock:^(MUPath * _Nonnull appex, NSUInteger idx, BOOL * _Nonnull stop) {
			[self setBundle:appex bundleShortVersionString:version];
		}];
		[bundle.allWatchApps enumerateObjectsUsingBlock:^(MUPath * _Nonnull watch, NSUInteger idx, BOOL * _Nonnull stop) {
			[self setBundle:watch bundleShortVersionString:version];
		}];
	}
}

+ (void)setBundle:(MUPath *)bundle bundleVersion:(NSString *)version {
	CLInfo(@"%@ = %@ ", bundle.lastPathComponent, version);
	bundle.CFBundleVersion = version;
	
	if (bundle.isApp) {
		[bundle.allPlugInApps enumerateObjectsUsingBlock:^(MUPath * _Nonnull appex, NSUInteger idx, BOOL * _Nonnull stop) {
			[self setBundle:appex bundleVersion:version];
		}];
		[bundle.allWatchApps enumerateObjectsUsingBlock:^(MUPath * _Nonnull watch, NSUInteger idx, BOOL * _Nonnull stop) {
			[self setBundle:watch bundleVersion:version];
		}];
	}
}

+ (void)addBundle:(MUPath *)bundle supportDevices:(NSArray *)devices {
	[bundle addSupportDevices:devices];
}

@end
