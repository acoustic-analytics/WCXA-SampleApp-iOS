//
//  SearchViewController.m
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "SearchViewController.h"
#import "Category.h"
#import "ItemListViewController.h"
#import "ItemDetailViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a list of fruit to display in the table view.
    
    self.allItems = [NSMutableArray array];
    RLMResults<Category *> *result = [Category allObjects];
    for(Category *catog in result)
    {
        [self.allItems addObject:catog];
    }
    
    // Create a list to hold search results (filtered list)
    self.filteredItems = [[NSMutableArray alloc] init];
    
    // Initially display the full list.  This variable will toggle between the full and the filtered lists.
    self.displayedItems = self.allItems;
    
    // Here's where we create our UISearchController
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    
    [self.searchController.searchBar sizeToFit];
    
    self.searchController.searchBar.placeholder = @"Search for items/categories";
    
    // Add the UISearchBar to the top header of the table view
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar setBarTintColor:[UIColor colorWithRed:0.25 green:0.47 blue:0.75 alpha:1.0]];
    [self.searchController.searchBar setTintColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.25 green:0.47 blue:0.75 alpha:1.0]];
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 21)];
    view.backgroundColor = [UIColor colorWithRed:0.25 green:0.47 blue:0.75 alpha:1.0];
    [self.tableView addSubview:view];
    
    // Hides search bar initially.  When the user pulls down on the list, the search bar is revealed.
    //[self.tableView setContentOffset:CGPointMake(0, self.searchController.searchBar.frame.size.height)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [self.displayedItems count];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]; //[UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 4, 250, 42)];
    label.text = @"Categories";
    [label setFont:[UIFont boldSystemFontOfSize:18]];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)anIndexPath {
    
    UITableViewCell * cell = [aTableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    if ([[self.displayedItems objectAtIndex:anIndexPath.row] isKindOfClass:[Category class]]) {
        cell.textLabel.text = ((Category *)[self.displayedItems objectAtIndex:anIndexPath.row]).categoryTitle;
    }
    else if ([[self.displayedItems objectAtIndex:anIndexPath.row] isKindOfClass:[Item class]]) {
        cell.textLabel.text = ((Item *)[self.displayedItems objectAtIndex:anIndexPath.row]).title;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.displayedItems objectAtIndex:indexPath.row] isKindOfClass:[Category class]]) {
        [self performSegueWithIdentifier:@"itemListSegue" sender:self];
    }
    else if ([[self.displayedItems objectAtIndex:indexPath.row] isKindOfClass:[Item class]]) {
        [self performSegueWithIdentifier:@"itemDetailSegue" sender:self];
    }
}

// When the user types in the search bar, this method gets called.
- (void)updateSearchResultsForSearchController:(UISearchController *)aSearchController {
    NSLog(@"updateSearchResultsForSearchController");
    
    NSString *searchString = aSearchController.searchBar.text;
    //NSLog(@"searchString=%@", searchString);
    
    RLMResults<Item *> *items = [Item allObjects];
    
    // Check if the user cancelled or deleted the search term so we can display the full list instead.
    if (![searchString isEqualToString:@""]) {
        [self.filteredItems removeAllObjects];
        for (Category *category in self.allItems) {
            if ([searchString isEqualToString:@""] || [category.categoryTitle localizedCaseInsensitiveContainsString:searchString] == YES) {
                //NSLog(@"str=%@", category.categoryTitle);
                [self.filteredItems addObject:category];
            }
        }
        for (Item *item in items) {
            if ([searchString isEqualToString:@""] || [item.title localizedCaseInsensitiveContainsString:searchString] == YES) {
                //NSLog(@"str=%@", item.title);
                [self.filteredItems addObject:item];
            }
        }
        self.displayedItems = self.filteredItems;
    }
    else {
        self.displayedItems = self.allItems;
    }
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    /* Uncomment following line if you want to test/try one type 2 multiple type 10
     Optionally set _searchfieldeditingchanged to 1 in TealeafAdvanceConfig.json if you want to see the event. If not, you are going to see "Dynamic Update" step in replay in any case.
     */
     //[[TLFCustomEvent sharedInstance] logScreenLayoutDynamicUpdateWithViewController:self andRelatedViews:@[searchBar]];
    
    /*Uncomment following lines to test logScreenLayoutWithImage */
    /*
     UIImage* image = [UIImage imageNamed:@"Replay_screenshot.png" inBundle:[NSBundle bundleForClass:[self class]] withConfiguration:nil];
    [[TLFCustomEvent sharedInstance] logScreenLayoutWithImage:image];
     */
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"itemListSegue"]) {
        NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
        ItemListViewController *destVC = (ItemListViewController *) segue.destinationViewController;
        
        Category *category = [self.displayedItems objectAtIndex:selectedIndex.row];
        
        destVC.categoryId = category.categoryId;
        destVC.categoryTitle = category.categoryTitle;
        destVC.category = category;
    }
    else if ([segue.identifier isEqualToString:@"itemDetailSegue"]) {
        NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
        ItemDetailViewController *destVC = (ItemDetailViewController *) segue.destinationViewController;
        
        Item *item = [self.displayedItems objectAtIndex:selectedIndex.row];
        destVC.dataItem = item;
    }
    
    if (self.searchController.isActive) {
        self.searchController.active = NO;
    }
}

@end
