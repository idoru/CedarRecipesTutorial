#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (strong, nonatomic) NSString *name, *ingredients, *instructions;


+ (Recipe *)recipeWithName:(NSString *)recipeName;
@end
