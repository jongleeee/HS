//
//  EventViewController.m
//  HS
//
//  Created by Irene Lee on 7/20/14.
//  Copyright (c) 2014 HeapStack. All rights reserved.
//

#import "EventViewController.h"
#import "PDTSimpleCalendar.h"
#import "UpdateEventViewController.h"
#import "Event.h"
#import "EventCell.h"

@interface EventViewController ()

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)calendarButtonPressed:(UIBarButtonItem *)sender;
@property (nonatomic, weak) UIViewController *currentchildViewController;

@end

@implementation EventViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)goBackToList:(UIStoryboardSegue *)segue
{
    UpdateEventViewController *source = [segue sourceViewController];
    Event *item = source.eventItem;
    if (item != nil) {
        [self.eventItems addObject:item];
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    self.eventItems = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //no index is expanded in default
    selectedIndex = -1;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.eventItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventPrototype";
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([EventCell class])
                                             owner:nil
                                           options:nil] lastObject];
    }
    
    if (selectedIndex == indexPath.row) {
        //expand
    }
    else {
        //closed cell
    }
    
    Event *item = [self.eventItems objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = item.title;
    NSLog(@"%@", cell.titleLabel);
    NSLog(@"%@", cell.dateLabel);
    NSLog(@"%@", cell.contentLabel);
    NSDate *chosen = [item.datePicked date];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:chosen
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    cell.dateLabel.text = dateString;
    cell.contentLabel.text = [NSString stringWithFormat:@"%@", item.content];
    
    cell.clipsToBounds = YES;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndex == indexPath.row) {
        return 110;
    } else {
        return 44;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//
////delegate to calculate height
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.prototypeCell layoutIfNeeded];
//    CGSize eventSize = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return eventSize.height + 1;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //User taps expanded Row
    if (selectedIndex == indexPath.row) {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    //User taps different row
    else if (selectedIndex != -1) {
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        //User taps new row with none expanded
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
}

- (UITableViewController *)calendarEventList
{
    UITableViewController *viewController = [UITableViewController new];
    viewController.view.frame = CGRectInset(self.view.bounds, 0, 165);

    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.view.layer.borderWidth = 6;
    viewController.view.layer.cornerRadius = 8;
    viewController.view.layer.borderColor = (__bridge CGColorRef)([UIColor clearColor]);
    viewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    viewController.view.layer.shadowOffset = CGSizeZero;
    viewController.view.layer.shadowOpacity = 0.5;
    
    return viewController;
}
- (IBAction)calendarButtonPressed:(UIBarButtonItem *)sender {
    PDTSimpleCalendarViewController *calendar = [[PDTSimpleCalendarViewController alloc] init];
    
    calendar.firstDate = [NSDate date];
    
    //contained viewcontroller event tableview
    UITableViewController *viewController = [self calendarEventList];
    viewController.view.frame = CGRectMake(self.view.frame.size.width - viewController.view.frame.size.width, self.view.frame.size.height - viewController.view.frame.size.height, viewController.view.frame.size.width, viewController.view.frame.size.height);
    [calendar addChildViewController:viewController];
    [calendar.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:calendar];
    self.currentchildViewController = viewController;
    //set header
    [calendar setTitle:@"Calendar"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(navBack:)];
    calendar.navigationItem.leftBarButtonItem = backButton;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(navAdd:)];
    calendar.navigationItem.rightBarButtonItem = addButton;
    [self.navigationController pushViewController:calendar animated:YES];
    //if date is selected, see from eventitems if the date matches. if yes show in tableview & reload
}

- (IBAction)navBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)navAdd:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"addSegue" sender:sender];
}

@end
