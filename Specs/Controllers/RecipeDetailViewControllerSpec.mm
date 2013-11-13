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
});

SPEC_END
