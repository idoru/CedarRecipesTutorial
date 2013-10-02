#import "RecipesViewController.h"

static NSString * const kRecipeCellIdentifier = @"recipeCell";

@interface RecipesViewController ()
@property (nonatomic, strong) NSArray *recipes;
@end

@implementation RecipesViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.recipes = @[ @"Guacamole", @"Tacos", @"Steak" ];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recipes count];
}

- (void)viewDidLoad
{
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kRecipeCellIdentifier];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecipeCellIdentifier];
    cell.textLabel.text = self.recipes[indexPath.row];
    return cell;
}

@end
