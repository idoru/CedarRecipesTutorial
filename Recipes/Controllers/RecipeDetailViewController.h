#import <UIKit/UIKit.h>

@class Recipe;

@interface RecipeDetailViewController : UIViewController
@property (weak, nonatomic, readonly) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic, readonly) IBOutlet UITextView *instructionsTextView;
@property (weak, nonatomic, readonly) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic, readonly) IBOutlet UITextField *recipeNameTextField;

- (instancetype)initWithRecipe:(Recipe *)recipe;

@end
