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
