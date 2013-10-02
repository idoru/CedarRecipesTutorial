#import "RecipesViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RecipesViewControllerSpec)

describe(@"RecipesViewController", ^{
    __block RecipesViewController *controller;

    beforeEach(^{
        controller = [[[RecipesViewController alloc] init] autorelease];
    });

    describe(@"UITableViewDataSource implementation", ^{
        describe(@"tableView:numberOfRowsInSection:", ^{
            it(@"should be 3", ^{
                [controller tableView:controller.tableView
                numberOfRowsInSection:0] should equal(3);
            });
        });

        describe(@"tableView:cellForRowAtIndexPath:", ^{
            it(@"should return cells with the appropriate recipe name", ^{
                [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].textLabel.text should equal(@"Tacos");
            });
        });
    });
});

SPEC_END
