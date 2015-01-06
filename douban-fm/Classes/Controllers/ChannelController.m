//
//  ChannelController.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "ChannelController.h"


@interface ChannelController ()

@end

@implementation ChannelController {
    
@private
    
    NSMutableDictionary *_sections;
    
    NSMutableArray *_sectionNames;
    
    NSMutableDictionary *_cells;
}

@synthesize channels = _channels;
@synthesize radioController = _radioController;
@synthesize selectedChannelIndex = _selectedChannelIndex;

- (id)init
{
    self = [super init];
    
    if (self) {
        self.title = @"豆瓣FM";
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _channels = [FmService sharedInstance].channels;
    
    _sections = [[NSMutableDictionary alloc] init];
    
    _sectionNames = [[NSMutableArray alloc] initWithObjects:@"未登陆", @"公共频道", nil];
    
    _cells = [[NSMutableDictionary alloc] init];
    
    _selectedChannelIndex = -1;
    
    int index = 0;
    
    for (FmChannel *channel in _channels) {
        
        NSString *sectionName = [_sectionNames objectAtIndex:index > 1 ? 1 : 0];
        
        NSMutableArray *list = [_sections objectForKey:sectionName];
        
        if(list == nil)
        {
            list = [NSMutableArray array];
            [_sections setValue:list forKey:sectionName];
        }
        
        [list addObject:channel.name];
        
        index++;
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:79/255.0 green:73/255.0 blue:69/255.0 alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:44/255.0 green:41/255.0 blue:38/255.0 alpha:1.0]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 29;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (id key in _cells) {
        
        UIChannelTableViewCell *cell = (UIChannelTableViewCell *)[_cells objectForKey:key];
        
        [cell hideSelectedState];
        
    }
    
    UIChannelTableViewCell *cell = (UIChannelTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell showSelectedState];

    NSString *channelName = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    [FmService sharedInstance].currentChannelIndex = [[FmService sharedInstance] channelIndexWithName:channelName];
    
    [self.navigationController pushViewController:_radioController animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    FmChannel *channel = [[FmService sharedInstance] currentChannel];
    
    for (id key in _cells) {
        
        UIChannelTableViewCell *cell = (UIChannelTableViewCell *)[_cells objectForKey:key];
        
        if ([cell.textLabel.text isEqual:channel.name]) {
            [cell showSelectedState];
        } else {
            [cell hideSelectedState];
        }
        
    }

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 29)];
    
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_channel.png"]];
    
    UIView *topBorderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    topBorderView.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    
    [label setText: [_sectionNames objectAtIndex:section]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    
    [view addSubview:topBorderView];
    [view addSubview:label];
    
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return [_sectionNames objectAtIndex:section];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *sectionName = [_sectionNames objectAtIndex:section];
    
    NSMutableArray *sectionList = [_sections objectForKey:sectionName];
    
    return sectionList.count;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _sectionNames.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    NSMutableArray *sectionList = [_sections objectForKey:[_sectionNames objectAtIndex:indexPath.section]];
    
    UIChannelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *channelName = [sectionList objectAtIndex:indexPath.row];;
    
    if (!cell) {
        
        cell = [[UIChannelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        [_cells setObject:cell forKey:channelName];
    }
    
    cell.textLabel.text = channelName;
    
    return cell;
}




@end
