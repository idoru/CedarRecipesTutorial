#import "RecipesViewController.h"
#import "RecipeDetailViewController.h"

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

        describe(@"when a recipe is selected", ^{
            beforeEach(^{
                [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
                [controller tableView:controller.tableView
              didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            });

            it(@"should push a RecipeDetailViewController onto the navigation stack", ^{
                controller.navigationController.topViewController should be_instance_of([RecipeDetailViewController class]);
            });
        });
    });
});

SPEC_END
