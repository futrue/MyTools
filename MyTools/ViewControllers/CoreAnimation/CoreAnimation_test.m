//
//  CoreAnimation_test.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "CoreAnimation_test.h"

#import "TachometerViewController.h"
#import "BatmanViewController.h"
#import "PacmanViewController.h"
#import "ImplicitAnimationsViewController.h"
#import "NSAViewController.h"
#import "SimpleViewPropertyAnimation.h"
#import "StickyNotesViewController.h"
#import "AVPlayerLayerViewController.h"
#import "ReflectionViewController.h"
#import "FlipViewController.h"
#import "PulseViewController.h"
#import "MakeItStickViewController.h"
#import "SublayerTransformViewController.h"

@interface UIViewController ()
+ (NSString *)displayName;
@end

@interface CoreAnimation_test ()
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation CoreAnimation_test

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [NSMutableArray array];
    
    NSMutableArray *layersList = [NSMutableArray array];
    [layersList addObject:[ImplicitAnimationsViewController class]];
    [layersList addObject:[MakeItStickViewController class]];
    [layersList addObject:[TachometerViewController class]];
    [layersList addObject:[BatmanViewController class]];
    [layersList addObject:[PacmanViewController class]];
    [layersList addObject:[SublayerTransformViewController class]];
    [layersList addObject:[AVPlayerLayerViewController class]];
    [layersList addObject:[NSAViewController class]];
    [layersList addObject:[ReflectionViewController class]];
    [layersList addObject:[PulseViewController class]];
    
    NSDictionary *layers = @{@"Core Animation": layersList};
    [self.items addObject:layers];
    
    NSMutableArray *uiKitList = [NSMutableArray array];
    [uiKitList addObject:[SimpleViewPropertyAnimation class]];
    [uiKitList addObject:[StickyNotesViewController class]];
    [uiKitList addObject:[FlipViewController class]];
    
    
    NSDictionary *uiKits = @{@"UIKit Animation": uiKitList};
    [self.items addObject:uiKits];
    
    self.title = @"Animations";
}

#pragma mark -
#pragma mark Table view data source

- (NSArray *)valuesForSection:(NSUInteger)section {
    NSDictionary *dictionary = (self.items)[section];
    NSString *key = [dictionary allKeys][0];
    return dictionary[key];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [(self.items)[section] allKeys][0];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self valuesForSection:section] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    NSArray *values = [self valuesForSection:indexPath.section];
    cell.textLabel.text = [values[indexPath.row] displayName];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *values = [self valuesForSection:indexPath.section];
    Class clazz = values[indexPath.row];
    id controller = [[clazz alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
