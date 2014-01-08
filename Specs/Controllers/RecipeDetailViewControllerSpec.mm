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
        UIWindow *window = [[UIWindow alloc] init];
        [window addSubview:controller.view];
        [window makeKeyAndVisible];
    });

    it(@"should place the edit button in the navigation item", ^{
        controller.navigationItem.rightBarButtonItem should be_same_instance_as(controller.editButtonItem);
    });

    describe(@"keyboardEditingAccessory", ^{
        it(@"should be a UIToolbar", ^{
            controller.keyboardEditingAccessory should be_instance_of([UIToolbar class]);
        });

        it(@"should have a previous button", ^{
            UIBarButtonItem *previousButton = controller.keyboardEditingAccessory.items.firstObject;
            previousButton.title should equal(@"Previous");
        });

        it(@"should have a next button", ^{
            UIBarButtonItem *nextButton = controller.keyboardEditingAccessory.items.lastObject;
            nextButton.title should equal(@"Next");
        });
    });

    describe(@"when the view is laid out", ^{
        beforeEach(^{
            [controller viewDidLayoutSubviews];
        });

        it(@"should set the contentSize of the scrollview to the size of the scroll view's frame", ^{
            controller.scrollView.contentSize should equal(controller.scrollView.frame.size);
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

            context(@"when the recipe name is focused", ^{
                beforeEach(^{
                    [controller.recipeNameTextField becomeFirstResponder];
                });

                describe(@"tapping the next button", ^{
                    beforeEach(^{
                        controller.recipeNameTextField.isFirstResponder should be_truthy;
                        UIBarButtonItem *nextButton = controller.keyboardEditingAccessory.items.lastObject;
                        [nextButton.target performSelector:nextButton.action withObject:nextButton];
                    });

                    it(@"should make the ingredients field become first responder", ^{
                        controller.ingredientsTextView.isFirstResponder should be_truthy;
                    });
                });

                describe(@"tapping the previous button", ^{
                    beforeEach(^{
                        controller.recipeNameTextField.isFirstResponder should be_truthy;
                        UIBarButtonItem *previousButton = controller.keyboardEditingAccessory.items.firstObject;
                        [previousButton.target performSelector:previousButton.action withObject:previousButton];
                    });

                    it(@"should make the ingredients field become first responder", ^{
                        controller.instructionsTextView.isFirstResponder should be_truthy;
                    });
                });
            });

            context(@"when the ingredients field is focused", ^{
                beforeEach(^{
                    [controller.ingredientsTextView becomeFirstResponder];
                });

                describe(@"tapping the next button", ^{
                    beforeEach(^{
                        controller.ingredientsTextView.isFirstResponder should be_truthy;
                        UIBarButtonItem *nextButton = controller.keyboardEditingAccessory.items.lastObject;
                        [nextButton.target performSelector:nextButton.action withObject:nextButton];
                    });

                    it(@"should make the instructions field become first responder", ^{
                        controller.instructionsTextView.isFirstResponder should be_truthy;
                    });
                });

                describe(@"tapping the previous button", ^{
                    beforeEach(^{
                        controller.ingredientsTextView.isFirstResponder should be_truthy;
                        UIBarButtonItem *previousButton = controller.keyboardEditingAccessory.items.firstObject;
                        [previousButton.target performSelector:previousButton.action withObject:previousButton];
                    });

                    it(@"should make the recipe name field become first responder", ^{
                        controller.recipeNameTextField.isFirstResponder should be_truthy;
                    });
                });
            });

            context(@"when the instructions field is focused", ^{
                beforeEach(^{
                    [controller.instructionsTextView becomeFirstResponder];
                });

                describe(@"tapping the next button", ^{
                    beforeEach(^{
                        controller.instructionsTextView.isFirstResponder should be_truthy;
                        UIBarButtonItem *nextButton = controller.keyboardEditingAccessory.items.lastObject;
                        [nextButton.target performSelector:nextButton.action withObject:nextButton];
                    });

                    it(@"should make the recipe name field become first responder", ^{
                        controller.recipeNameTextField.isFirstResponder should be_truthy;
                    });
                });

                describe(@"tapping the previous button", ^{
                    beforeEach(^{
                        controller.instructionsTextView.isFirstResponder should be_truthy;
                        UIBarButtonItem *previousButton = controller.keyboardEditingAccessory.items.firstObject;
                        [previousButton.target performSelector:previousButton.action withObject:previousButton];
                    });

                    it(@"should make the ingredients field become first responder", ^{
                        controller.ingredientsTextView.isFirstResponder should be_truthy;
                    });
                });
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

        it(@"should adjust the content inset of the scroll view to accomodate the keyboard and navigation bar", ^{
            controller.scrollView.contentInset should equal(UIEdgeInsetsMake(64.0f, 0, 260.f, 0));
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

        it(@"should use the keyboardEditingAccessory on all text fields", ^{
            controller.ingredientsTextView.inputAccessoryView should be_same_instance_as(controller.keyboardEditingAccessory);
            controller.instructionsTextView.inputAccessoryView should be_same_instance_as(controller.keyboardEditingAccessory);
            controller.recipeNameTextField.inputAccessoryView should be_same_instance_as(controller.keyboardEditingAccessory);
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
