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
        recipe.instructions = @"Mix stuff and put in between pasta. Heat until yummy.";
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

    describe(@"-setEditing:animated:", ^{
        context(@"when editing is YES", ^{
            beforeEach(^{
                spy_on(controller.recipeNameTextField);
                spy_on(controller.view);
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

            it(@"should not tell the view editing has ended", ^{
                controller.view should_not have_received(@selector(endEditing:));
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
                spy_on(controller.view);
                spy_on(controller.recipeNameTextField);
                [controller setEditing:NO animated:NO];
            });

            it(@"should tell the view that editing has ended", ^{
                controller.view should have_received(@selector(endEditing:)).with(NO);
            });

            it(@"should not tell the recipe text field to become first responder", ^{
                controller.recipeNameTextField should_not have_received(@selector(becomeFirstResponder));
            });
        });
    });

    describe(@"updating the recipe's properties", ^{
        beforeEach(^{
            [controller setEditing:YES];
            controller.recipeNameTextField.text = @"Lasagna - correct";
            [controller setEditing:NO];
        });

        it(@"should hide the recipe's name text edit field", ^{
            controller.recipeNameTextField.isHidden should be_truthy;
        });

        it(@"should unhide the recipe's name label", ^{
            controller.recipeNameLabel.isHidden should_not be_truthy;
        });

        it(@"should update the recipe's name with the new recipe name", ^{
            controller.recipeNameLabel.text should equal(@"Lasagna - correct");
        });

        it(@"should update the recipe's name on the model", ^{
            recipe.name should equal(@"Lasagna - correct");
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
            controller.scrollView.contentInset should equal(UIEdgeInsetsMake(64.0f, 0, 0, 0));
        });

        it(@"should reset the scroll indicator insets of the scrollview", ^{
            controller.scrollView.scrollIndicatorInsets should equal(UIEdgeInsetsMake(64.0f, 0, 0, 0));
        });
    });

    describe(@"when the view is about to appear", ^{
        beforeEach(^{
            [controller viewWillAppear:NO];
        });

        it(@"should set the name of the recipe name on the recipeNameLabel", ^{
            controller.recipeNameLabel.text should equal(recipe.name);
        });

        it(@"should set the name of the recipe name on the recipeTextField", ^{
            controller.recipeNameTextField.text should equal(recipe.name);
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
