#import "RecipesViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RecipesViewControllerSpec)

describe(@"RecipesViewController", ^{
    __block RecipesViewController *controller;

    beforeEach(^{
        controller = [[[RecipesViewController alloc] init] autorelease];
        [controller viewWillAppear:NO];
        [controller viewDidAppear:NO];
    });

    describe(@"tableView", ^{
        it(@"should display the recipes", ^{
            [controller.tableView.visibleCells count] should equal(3);

            [controller.tableView.visibleCells valueForKeyPath:@"textLabel.text"] should equal(@[ @"Guacamole", @"Tacos", @"Steak" ]);
        });
    });
});

SPEC_END
