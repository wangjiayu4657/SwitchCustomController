//
//  FirstViewController.m
//  SwitchController
//
//  Created by fangjs on 16/5/27.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "FirstViewController.h"
#import "WJYModel.h"

@interface FirstViewController () <UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

/**dataSource*/
@property (strong , nonatomic) NSMutableArray *dataSource;

@end

@implementation FirstViewController



-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil]];
        for (NSDictionary *dict in array) {
            WJYModel *model = [WJYModel wjyModelInitWithDictionary:dict];
            [self.dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.menuTableView) {
        return self.dataSource.count;
    }else {
        WJYModel *model = self.dataSource[self.menuTableView.indexPathForSelectedRow.row];
        return model.subcategories.count;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.menuTableView) {
        static NSString *menuCellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellID];
        }
        WJYModel *model = self.dataSource[indexPath.row];
        cell.textLabel.text = model.name;
        cell.imageView.image = [UIImage imageNamed:model.icon];
        cell.imageView.highlightedImage = [UIImage imageNamed:model.highlighted_icon];
        return cell;

    }else {
        static NSString *subCellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:subCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subCellID];
        }
        WJYModel *model = self.dataSource[self.menuTableView.indexPathForSelectedRow.row];
        cell.textLabel.text = model.subcategories[indexPath.row];
        return cell;
    }
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.menuTableView) {
        [self.contentTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
