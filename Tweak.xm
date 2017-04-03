#import <UIKit/UIKit.h>
#import "MediaRemote.h"
#import <libactivator/libactivator.h>


@interface QuickNowPlayingActivatorListener : NSObject <LAListener>
@end

@implementation QuickNowPlayingActivatorListener

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event 
{
	MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
		NSDictionary *dict = (__bridge NSDictionary *)(information);
		if ([dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle] == nil && [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist] == nil) {
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"No title" preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				}];
			[alert addAction:ok];
			[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
			event.handled = YES;
		} else if ([dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle] != nil && [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist] != nil) {
			NSString *artistTitle = [[NSString alloc] initWithString:[dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist]];
			NSString *songTitle = [[NSString alloc] initWithString:[dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle]];
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:artistTitle message:songTitle preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
				}];
			[alert addAction:ok];
			[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
			event.handled = YES;
		}
	});
}

+ (void)load 
{
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.cabralcole.quicknowplaying"];
}

@end