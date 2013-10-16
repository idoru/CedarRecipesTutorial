#import "RecipesViewController.h"
#import "Recipe.h"
#import "RecipeDetailViewController.h"

static NSString * const kRecipeCellIdentifier = @"recipeCell";

@interface RecipesViewController ()
@property (nonatomic, strong) NSArray *recipes;
@end

@implementation RecipesViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.recipes = @[
                         [Recipe recipeWithName:@"Guacamole"],
                         [Recipe recipeWithName:@"Tacos"],
                         [Recipe recipeWithName:@"Steak"]
                         ];
    }
    return self;
}

- (void)viewDidLoad
{
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kRecipeCellIdentifier];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeDetailViewController *detailController = [[RecipeDetailViewController alloc] init];
    [self.navigationController pushViewController:detailController
                                         animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecipeCellIdentifier];
    cell.textLabel.text = [self.recipes[indexPath.row] name];
    return cell;
}

@end
