#import "RecipeDetailViewController.h"
#import "Recipe.h"

@interface RecipeDetailViewController ()
@property (weak, nonatomic, readwrite) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic, readwrite) IBOutlet UITextView *instructionsTextView;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic, readwrite) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic, readwrite) IBOutlet UITextField *recipeNameTextField;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.recipeNameLabel.text = self.recipe.name;
    self.ingredientsTextView.text = self.recipe.ingredients;
    self.instructionsTextView.text = self.recipe.instructions;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.ingredientsTextView.editable = self.instructionsTextView.editable = YES;
    self.recipeNameTextField.hidden = NO;
    self.recipeNameLabel.hidden = YES;
    [self.recipeNameTextField becomeFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Please use initWithRecipe: instead" userInfo:@{}];
}

- (void)keyboardDidShow
{
    self.scrollView.contentInset = self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 216.f, 0);
}

- (void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = self.view.frame.size;
}

- (void)keyboardDidHide
{
    self.scrollView.contentInset = self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Please use initWithRecipe: instead" userInfo:@{}];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

@end
