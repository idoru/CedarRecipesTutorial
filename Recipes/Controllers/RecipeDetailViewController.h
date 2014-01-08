#import <UIKit/UIKit.h>

@class Recipe;

@interface RecipeDetailViewController : UIViewController
@property (weak, nonatomic, readonly) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic, readonly) IBOutlet UITextView *instructionsTextView;
@property (weak, nonatomic, readonly) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic, readonly) IBOutlet UITextField *recipeNameTextField;
@property (weak, nonatomic, readonly) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic, readonly) IBOutlet UIToolbar *keyboardEditingAccessory;

- (instancetype)initWithRecipe:(Recipe *)recipe;
- (void)keyboardDidShow;
- (void)keyboardDidHide;

- (IBAction)nextButtonWasTapped:(UIBarButtonItem *)nextButton;
- (IBAction)previousButtonWasTapped:(UIBarButtonItem *)previousButton;

@end
