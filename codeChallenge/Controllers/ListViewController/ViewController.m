//
//  ViewController.m
//  codeChallenge
//
//  Created by Nano Suarez on 18/04/2018.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "codeChallenge-Swift.h"


@interface ViewController ()
@property (nonatomic, readwrite) PhotosResponseModel *photosResponse;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic, copy) void (^ reloadBlock)(void);
@property (nonatomic) ActivityLoaderView *activityIndeicatorView;
@property (strong, nonatomic) IBOutlet UITableView *photosTableView;
@property (nonatomic) BOOL showLoadMore;

@end

@implementation ViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [self setUpUIView];
    [self InitVariables];
    [self loadFlickrPhotos];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

#pragma mark - Helper Methods
- (void) setUpUIView {
    [self setUpTableView];
    [self setUpActivityIndicatorView];
    
}

-(void) setUpTableView {
    UINib *cellNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CustomCell"];
    [self.photosTableView addLoadMoreLoaderToFooter];
}

-(void)InitVariables {
    self.pageNumber = 1;
    self.showLoadMore = false;
}

- (void)reload {
    [self.tableView reloadData];
}

-(BOOL) isLoadMoreOn {
    if (self.pageNumber > 1) {
        return true;
    }
    else
    {
        return false;
    }
}

- (void) setUpActivityIndicatorView {
    CGRect tableViewFrame = self.photosTableView.frame;
    CGFloat xPosition = tableViewFrame.origin.x;
    CGFloat yPosition = tableViewFrame.origin.y;
    CGFloat width = tableViewFrame.size.width;
    CGRect frame = CGRectMake(xPosition, yPosition, width, 35);
    self.activityIndeicatorView  = [[ActivityLoaderView alloc] initWithFrame:frame];
    [self.view addSubview:self.activityIndeicatorView];
    [self.activityIndeicatorView hide];
}

#pragma mark - Web services Methods
- (void)loadFlickrPhotos {
    if (![self isLoadMoreOn]) {
        [self.activityIndeicatorView show];
    }
    [APIManager.sharedInstance getFlickrPhotosWithPageNumber:self.pageNumber completionWithSuccess:^(PhotosResponseModel*  photosReponse) {
        if ([self isLoadMoreOn]) { // Lood more reponse
           self.photosResponse.photos =  [self.photosResponse.photos arrayByAddingObjectsFromArray:photosReponse.photos];
        }
        else
        {
           [self.activityIndeicatorView hide];
           self.photosResponse = photosReponse;
        }
        
        [self reload];
        
    } completionWithFail:^ (NSError* error){
        
    }];
}

#pragma mark - TableViewDatasource , UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.photosResponse.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CustomCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setUpCellWith: [self.photosResponse.photos objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.photosResponse.photos count] -1)  {
        if (self.showLoadMore){
            [self.photosTableView starLoadMoreIndicator];
            self.pageNumber +=1;
            [self loadFlickrPhotos];
        }
        else
        {
            self.showLoadMore = true;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

@end
