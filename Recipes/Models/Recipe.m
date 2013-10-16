#import "Recipe.h"

@implementation Recipe

+ (Recipe *)recipeWithName:(NSString *)recipeName
{
    Recipe *recipe = [[Recipe alloc] init];
    recipe.name = recipeName;
    return recipe;
}

@end
