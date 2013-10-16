#import "AppDelegate.h"
#import "RecipesViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *delegate;

    beforeEach(^{
        delegate = [[[AppDelegate alloc] init] autorelease];
    });

    describe(@"when the application has launched", ^{
        beforeEach(^{
            [delegate application:nil didFinishLaunchingWithOptions:nil];
        });

        it(@"should set up a window with a UINavigationController at the root", ^{
            delegate.window.rootViewController should be_instance_of([UINavigationController class]);
        });

        it(@"should put a RecipesViewController on the top of the navigation stack", ^{
            [(UINavigationController *)delegate.window.rootViewController topViewController] should be_instance_of([RecipesViewController class]);
        });
    });
});

SPEC_END
