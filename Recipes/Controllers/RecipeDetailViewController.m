#import "RecipeDetailViewController.h"
#import "Recipe.h"

@interface RecipeDetailViewController ()
@property (weak, nonatomic, readwrite) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic, readwrite) IBOutlet UITextView *instructionsTextView;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *recipeNameLabel;
@property (strong, nonatomic) Recipe *recipe;
@end

@implementation RecipeDetailViewController
- (instancetype)initWithRecipe:(Recipe *)recipe
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.recipe = recipe;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.recipeNameLabel.text = self.recipe.name;
    self.ingredientsTextView.text = self.recipe.ingredients;
    self.instructionsTextView.text = self.recipe.instructions;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Please use initWithRecipe: instead" userInfo:@{}];
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Please use initWithRecipe: instead" userInfo:@{}];
}

@end
