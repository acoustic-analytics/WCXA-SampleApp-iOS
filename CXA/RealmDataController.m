//
//  RealmDataController.m
//  CXA
//
//  Created by Chanikya on 11/1/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "RealmDataController.h"
#import "Realm/RLMRealm.h"
#import "Item.h"
#import "Category.h"
#import "AppManager.h"

@implementation RealmDataController

+ (instancetype)sharedInstance
{
    static RealmDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RealmDataController alloc] init];
    });
    return sharedInstance;
}

- (void) addDataToRealm
{
    [self addItemWithitemId:1 title:@"Reading Tablet" owner:@"ABC" rating:3 ratingCount:123 shortDescription:@"This lightweight tablet is perfect for sitting at home, at school, or on the bus and enjoying your favorite books and novels. Store as many books as you want; just remember to read them all!" price:375.00 stock:@"In Stock" image:@"readingTablet" thumbnail:@"readingTablet_thumbnail" categoryId:1];
    [self addItemWithitemId:2 title:@"Home Tablet" owner:@"BCA" rating:3.5 ratingCount:12 shortDescription:@"This tablet computer is perfect for using everyday, whether it be for checking e-mails, or browsing the Internet. Use this tablet to view all your personal documents, and share photos with your family" price:540.00 stock:@"In Stock" image:@"homeTablet" thumbnail:@"homeTablet_thumbnail" categoryId:1];
    [self addItemWithitemId:3 title:@"Multimedia Tablet" owner:@"ABC" rating:4 ratingCount:1002 shortDescription:@"This multimedia tablet is perfect entertainment device. Whether you are watching videos, music, or pictures, there are no limits. Keep yourself entertained in style, no matter where you are!" price:630.00 stock:@"In Stock" image:@"multimediaTablet" thumbnail:@"multimediaTablet_thumbnail" categoryId:1];
    
    [self addItemWithitemId:4 title:@"Kitchen Tablet" owner:@"ABC" rating:4.5 ratingCount:1200 shortDescription:@"This fun tablet is ideal for keeping around the kitchen, so that you have all your favorite recipes and dinner ideas at your fingertips. The bright screen makes it easy to read in even the sunniest kitchens!" price:390.00 stock:@"In Stock" image:@"kitchenTablet" thumbnail:@"kitchenTablet_thumbnail" categoryId:1];
    [self addItemWithitemId:5 title:@"Portable Tablet" owner:@"ABC" rating:2 ratingCount:10 shortDescription:@"This portable tablet is ideal for everyday needs, such as checking your e-mail and browsing the Web. The excellent battery life ensures that you won't be looking for power sources when you're out and about." price:475.00 stock:@"In Stock" image:@"portableTablet" thumbnail:@"portableTablet_thumbnail" categoryId:1];
    [self addItemWithitemId:6 title:@"Budget Tablet" owner:@"ABC" rating:5 ratingCount:1500 shortDescription:@"This average tablet will get you from point A to point B, without having to worry about spending a fortune to get things done. This is the perfect tablet to perform lighweight tasks like checking e-mail and browsing the Web." price:300.00 stock:@"In Stock" image:@"budgetTablet" thumbnail:@"budgetTablet_thumbnail" categoryId:1];
    
    [self addItemWithitemId:7 title:@"StyleHome UltraCozy Large Sofa" owner:@"ABC" rating:4.5 ratingCount:2005 shortDescription:@"The sofa has a short back rest but a long width to get lazy while sitting lazy. With a matte fabric finish and a soft center, this is the perfect sofa to indulge someone to get lazy and stay back." price:572.00 stock:@"In Stock" image:@"styleHomeUltraCozy" thumbnail:@"styleHomeUltraCozy_thumbnail" categoryId:2];
    [self addItemWithitemId:8 title:@"Supreme LoungeStyle Double Sofa" owner:@"ABC" rating:3.0 ratingCount:546 shortDescription:@"This smooth synthetic is perfect for lounge environment, and is stain proof. It is as easy as wiping stain off it with a wipe, thus reducing maintenance. It is built tough so that it does not tear or break easily." price:209.00 stock:@"In Stock" image:@"supremeLoungeStyleSofa" thumbnail:@"supremeLoungeStyle_thumbnail" categoryId:2];
    [self addItemWithitemId:9 title:@"Supreme GiantsCorner Sofa Set" owner:@"CXD" rating:4.5 ratingCount:2504 shortDescription:@"A very snug sofa set with a 3 seat sofa and a divan. Ideal for placing along corner of your large living room. Watch TV while enjoying the company of your friends and family in this giant sofa set." price:949.00 stock:@"In Stock" image:@"supremeGaintSofa" thumbnail:@"supremeGaintSofa_thumbnail" categoryId:2];
    
    [self addItemWithitemId:10 title:@"Student Laptop" owner:@"CXD" rating:3.5 ratingCount:868 shortDescription:@"This portable laptop can last hours on end, so that you don't need to sit on the loud, busy side of the lecture hall, just to be near a power source. Take all the notes you need, whether you're in class, or at home studying." price:680.00 stock:@"In Stock" image:@"studentLaptop" thumbnail:@"studentLaptop_thumbnail" categoryId:3];
    [self addItemWithitemId:11 title:@"Office Laptop" owner:@"XDF" rating:3.0 ratingCount:739 shortDescription:@"This home and office laptop is ideal for creating and working with all your important documents. You can work on everything your personal or business needs might require. Your home office has never been more efficient, and more portable!" price:720.00 stock:@"In Stock" image:@"officeLaptop" thumbnail:@"officeLaptop_thumbnail" categoryId:3];
    [self addItemWithitemId:12 title:@"Budget Laptop" owner:@"BCA" rating:4.0 ratingCount:504 shortDescription:@"This average laptop will get you from point A to point B, without having to worry about spending a fortune to get things done. This is the perfect laptop to perform lightweight tasks like checking e-mail and browsing the Web." price:400.00 stock:@"In Stock" image:@"budgetLaptop" thumbnail:@"budgetLaptop_thumbnail" categoryId:3];
    
    [self addItemWithitemId:13 title:@"Parmesan Cheese" owner:@"BCA" rating:5.0 ratingCount:400 shortDescription:@"An essential Italian hard cheese made of cows milk. Parmigiano-Reggiano can only be produced in certain regions of Italy. Grate it on pastas and salads or even pizzas." price:9.89 stock:@"In Stock" image:@"parmesan" thumbnail:@"parmesan_thumbnail" categoryId:4];
    [self addItemWithitemId:14 title:@"Blue Cheese" owner:@"BCA" rating:4.0 ratingCount:250 shortDescription:@"Not for the faint of heart, Oxford Organics strong blue cheese is a delicious and creamy cheese with the perfect bite. It's great in salads, on cooked beef, or on a cheese plate." price:3.79 stock:@"In Stock" image:@"blueCheese" thumbnail:@"blueCheese_thumbnail" categoryId:4];
    [self addItemWithitemId:15 title:@"Appenzeller Cheese" owner:@"BCA" rating:2.0 ratingCount:18 shortDescription:@"A classic Swiss cheese which gains its unique flavor from being bathed in a mixture of herbs, liquors and wines for over four months. Best served with nuts and light white wines. Serve it at your next dinner party and really impress your guests!" price:8.99 stock:@"In Stock" image:@"appenzeller" thumbnail:@"appenzeller_thumbnail" categoryId:4];
    
    [self addItemWithitemId:16 title:@"Sportsfit" owner:@"BCA" rating:4.0 ratingCount:1500 shortDescription:@"Sportfit is a sports and fitness magazine that lives and breathes a healthy athletic lifestyle. Featuring sports reporting on professional and amateur sports as well as an intense focus on health and fitness. Each month profiles an up and coming athlete, no holds barred sports commentary and new workouts to add to your routine. First published in 1988." price:18.00 stock:@"In Stock" image:@"sportsfit" thumbnail:@"sportsfit_thumbnail" categoryId:5];
    [self addItemWithitemId:17 title:@"Natura" owner:@"BCA" rating:2.5 ratingCount:404 shortDescription:@"Natura is an escape from the everyday. Featuring the best nature getaways, the latest tips on a healthy vegetarian diet and yoga exercises. Be at one with nature and your body. First published in 1969." price:24.00 stock:@"In Stock" image:@"natura" thumbnail:@"natura_thumbnail" categoryId:5];
    [self addItemWithitemId:18 title:@"Archaeo" owner:@"BCA" rating:1.5 ratingCount:15 shortDescription:@"Archaeo features profiles of the leading international designers and architects, the most ambitious and outrageous construction projects around the world and home designs of your dreams. First published in 1954." price:34.00 stock:@"In Stock" image:@"archaeo" thumbnail:@"archaeo_thumbnail" categoryId:5];

    [self addItemWithitemId:19 title:@"Albini Black Leather Bag" owner:@"BCA" rating:2.5 ratingCount:1200 shortDescription:@"This fashionable leather shoulder bag is large enough to do second duty as your tote bag. It has double leather straps embellished with metal hoops going across the body of the bag and a metal snap to adjust the length of the strap." price:90.00 stock:@"In Stock" image:@"albinibag" thumbnail:@"albinibag_thumbnail" categoryId:6];
    [self addItemWithitemId:20 title:@"Versatil Classic White Bag" owner:@"BCA" rating:5.0 ratingCount:500 shortDescription:@"A puffy white bag made of soft leather, this bag has short rounded straps for comfy grip and a zipper in the front for your cell phone and keys. The silver metal studs at the sides show off a modern, stylish look." price:60.00 stock:@"In Stock" image:@"versatilbag" thumbnail:@"versatilbag_thumbnail" categoryId:6];
    [self addItemWithitemId:21 title:@"Hermitage Leopard Bag" owner:@"BCA" rating:2.0 ratingCount:604 shortDescription:@"A shoulder bag in leopard print with short shiny black straps, this bag exemplifies the latest in vogue. This bag also has a longer strap for crosss-body wear. A small brass lock secures the zip closure." price:75.00 stock:@"In Stock" image:@"hermitagebag" thumbnail:@"hermitagebag_thumbnail" categoryId:6];
    
    [self addCategoryDataToRealmWithCategoryId:1 andCategoryTitle:@"Tablets" andImage:@"multimediaTablet_thumbnail"];
    [self addCategoryDataToRealmWithCategoryId:2 andCategoryTitle:@"Furniture" andImage:@"styleHomeUltraCozy_thumbnail"];
    [self addCategoryDataToRealmWithCategoryId:3 andCategoryTitle:@"Laptops" andImage:@"officeLaptop_thumbnail"];
    [self addCategoryDataToRealmWithCategoryId:4 andCategoryTitle:@"Dairy" andImage:@"blueCheese_thumbnail"];
    [self addCategoryDataToRealmWithCategoryId:5 andCategoryTitle:@"Magazines" andImage:@"sportsfit_thumbnail"];
    [self addCategoryDataToRealmWithCategoryId:6 andCategoryTitle:@"Handbags" andImage:@"versatilbag_thumbnail"];
}

- (void) addItemWithitemId:(NSInteger) id title:(NSString *) name owner:(NSString *) owner rating:(NSInteger) rating ratingCount:(NSInteger) rateCount shortDescription:(NSString *) shortDesc price:(NSInteger) price stock:(NSString *) availability image:(NSString *) imageName thumbnail:(NSString *) thumbnail categoryId:(NSInteger) categoryId
{
    Item *item = [[Item alloc] init];
    item.itemId = id;
    item.title = name;
    item.owner = owner;
    item.rating = rating;
    item.ratingCount = rateCount;
    item.shortDescription = shortDesc;
    item.price = price;
    item.stockAvailability = availability;
    item.image = imageName;
    item.thumbnail = thumbnail;
    item.categoryId = categoryId;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:item];
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isDefaultRealmDataSaved"];
    }];
}

- (void) addCategoryDataToRealmWithCategoryId:(NSInteger) categoryId andCategoryTitle: (NSString *) categoryTitle andImage:(NSString *) image
{
    Category *category = [[Category alloc] init];
    category.categoryId = categoryId;
    category.categoryTitle = categoryTitle;
    category.imageThumbnail = image;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:category];
    }];
}

- (void) migrateRealmData {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // Set the new schema version. This must be greater than the previously used
    // version (if you've never set a schema version before, the version is 0).
    config.schemaVersion = 3;
    
    // Set the block which will be called automatically when opening a Realm with a
    // schema version lower than the one set above
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 3) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
    };
    
    config.deleteRealmIfMigrationNeeded = YES;
    
    // Tell Realm to use this new configuration object for the default Realm
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    // Now that we've told Realm how to handle the schema change, opening the file
    // will automatically perform the migration
    [RLMRealm defaultRealm];
}

@end
