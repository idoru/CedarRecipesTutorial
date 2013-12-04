#import "RecipeDetailViewController.h"
#import "Recipe.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(RecipeDetailViewControllerSpec)

describe(@"RecipeDetailViewController", ^{
    __block RecipeDetailViewController *controller;
    __block Recipe *recipe;

    beforeEach(^{
        recipe = [[[Recipe alloc] init] autorelease];
        recipe.name = @"Lasagne";
        recipe.ingredients = @"Cheese, Pasta, Mincemeat, Tomato Paste";
        recipe.instructions = @"Mix stuff and put in between pasta.  Heat until yummy.";
        controller = [[[RecipeDetailViewController alloc] initWithRecipe:recipe] autorelease];

        controller.view should_not be_nil;
    });

    it(@"should place the edit button in the navigation item", ^{
        controller.navigationItem.rightBarButtonItem should be_same_instance_as(controller.editButtonItem);
    });

    describe(@"when the view is laid out", ^{
        beforeEach(^{
            controller.view.frame = CGRectMake(0, 0, 320.f, 480.f);
            [controller viewDidLayoutSubviews];
        });

        it(@"should set the contentSize of the scrollview to the view's size", ^{
            controller.scrollView.contentSize should equal(controller.view.frame.size);
        });
    });

    describe(@"-setEditing:animated:", ^{
        context(@"when editing is YES", ^{
            beforeEach(^{
                spy_on(controller.recipeNameTextField);
                [controller setEditing:YES animated:NO];
            });

            it(@"should make the text fields editable", ^{
                controller.ingredientsTextView.editable should be_truthy;
                controller.instructionsTextView.editable should be_truthy;
            });

            it(@"should hide the recipe name label and show the text field", ^{
                controller.recipeNameLabel.hidden should be_truthy;
                controller.recipeNameTextField.hidden should_not be_truthy;
            });

            it(@"should try to make the recipe name text field the first responder", ^{
                controller.recipeNameTextField should have_received(@selector(becomeFirstResponder));
            });
        });

        context(@"when editing is NO", ^{
            beforeEach(^{
                [controller setEditing:NO animated:NO];
            });
        });
    });

    describe(@"-keyboardDidShow", ^{
        beforeEach(^{
            [controller keyboardDidShow];
        });

        it(@"should adjust the content inset of the scroll view to accomodate the keyboard", ^{
            controller.scrollView.contentInset should equal(UIEdgeInsetsMake(0, 0, 216.f, 0));
        });

        it(@"should adjust the scroll indicator inset of the scroll view to accomodate the keyboard", ^{
            controller.scrollView.scrollIndicatorInsets should equal(UIEdgeInsetsMake(0, 0, 216.f, 0.f));
        });
    });

    describe(@"-keyboardDidHide", ^{
        beforeEach(^{
            [controller keyboardDidShow];
            [controller keyboardDidHide];
        });

        it(@"should reset the content insets of the scrollview", ^{
            controller.scrollView.contentInset should equal(UIEdgeInsetsZero);
        });

        it(@"should reset the scroll indicator insets of the scrollview", ^{
            controller.scrollView.scrollIndicatorInsets should equal(UIEdgeInsetsZero);
        });
    });

    describe(@"when the view is about to appear", ^{
        beforeEach(^{
            [controller viewWillAppear:NO];
        });

        it(@"should set the name of the recipe on the recipeNameLabel", ^{
            controller.recipeNameLabel.text should equal(recipe.name);
        });

        it(@"should set the ingredients list on the ingredientsTextView", ^{
            controller.ingredientsTextView.text should equal(recipe.ingredients);
        });

        it(@"should set the instructions on the instructionsTextView", ^{
            controller.instructionsTextView.text should equal(recipe.instructions);
        });
    });

    describe(@"when the view appears", ^{
        __block NSNotificationCenter *notificationCenter;
        beforeEach(^{
            notificationCenter = [NSNotificationCenter defaultCenter];
            spy_on(notificationCenter);
            [controller viewWillAppear:NO];
            [controller viewDidAppear:NO];
        });

        it(@"should register for keyboard events", ^{
            notificationCenter should have_received(@selector(addObserver:selector:name:object:)).with(controller, @selector(keyboardDidShow), UIKeyboardDidShowNotification, nil);
            notificationCenter should have_received(@selector(addObserver:selector:name:object:)).with(controller, @selector(keyboardDidHide), UIKeyboardDidHideNotification, nil);
        });
    });

    describe(@"when the view disappers", ^{
        __block NSNotificationCenter *notificationCenter;

        beforeEach(^{
            notificationCenter = [NSNotificationCenter defaultCenter];
            spy_on(notificationCenter);
            [controller viewWillDisappear:NO];
            [controller viewDidDisappear:NO];
        });

        it(@"should de-register for keyboard events", ^{
            notificationCenter should have_received(@selector(removeObserver:name:object:)).with(controller, UIKeyboardDidShowNotification, nil);
            notificationCenter should have_received(@selector(removeObserver:name:object:)).with(controller, UIKeyboardDidHideNotification, nil);
        });
    });
});

SPEC_END
