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
@property (nonatomic) ActivityLoaderView *activityIndeicatorView;
@property (strong, nonatomic) IBOutlet UITableView *photosTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dateSegmentControl;
@property (nonatomic) DSort dateSort;

@end

@implementation ViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [self setUpUIView];
    [self InitVariables];
    [self loadFlickrPhotos];
}

#pragma mark - Helper Methods
- (void) setUpUIView {
    [self setUpTableView];
    [self setUpActivityIndicatorView];
    self.title = @"Flikr";
    self.dateSort = DSortPosted;
}

-(void) setUpTableView {
    UINib *cellNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.photosTableView registerNib:cellNib forCellReuseIdentifier:@"CustomCell"];
    [self.photosTableView addLoadMoreLoaderToFooter];
}

-(void)InitVariables {
    self.pageNumber = 1;
}

- (void)reload {
    [self.photosTableView reloadData];
}

/**
 Check if this is first page to load or load more data self.pageNumber > 1
 */
-(BOOL) isLoadMoreOn {
    if (self.pageNumber > 1) {
        return true;
    }
    else
    {
        return false;
    }
}

/**
 Set Activity indicator fram according to table view fram and added to the table
 */
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

-(void) startActivityIndicator {
    [self.photosTableView setHidden:true];
    [self.activityIndeicatorView show];
}

-(void) hideActivityIndicator {
    [self.activityIndeicatorView hide];
    [self.photosTableView setHidden:false];
}

#pragma mark - Navigation Methods
- (void) showDetailsViewControllerWith :(PhotoModel *) photoModel  {
    DetailsViewController * detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    detailsVC.photoModel = photoModel;
    [self.navigationController pushViewController:detailsVC animated:true];
}

#pragma mark - Web services Methods
- (void)loadFlickrPhotos {
    if (![self isLoadMoreOn]) {
        [self startActivityIndicator];
    }
    [APIManager.sharedInstance getFlickrPhotosWithPageNumber:self.pageNumber dateSort:self.dateSort completionWithSuccess:^(PhotosResponseModel*  photosReponse) {
        if ([self isLoadMoreOn]) { // Lood more response
            self.photosResponse.photos =  [self.photosResponse.photos arrayByAddingObjectsFromArray:photosReponse.photos];
        }
        else // first page response
        {
            [self hideActivityIndicator];
            self.photosResponse = photosReponse;
        }
        
        [self reload];
        
    } completionWithFail:^ (NSError* error){
        [self hideActivityIndicator];
        UIAlertController *alert = [ALertManager somethingWentWrongAlert];
        [self presentViewController:alert animated:true completion:nil];
    }];
}

#pragma mark - UISegmentedControl
- (IBAction)dateSegmentValueChnaged:(id)sender {
    switch (self.dateSegmentControl.selectedSegmentIndex) {
        case 0:
            self.dateSort = DSortPosted;
            break;
        case 1:
            self.dateSort = DSortTaken;
            break;
        case 2:
            self.dateSort = DSortInterestingness;
            break;
        default:
            break;
    }
    self.pageNumber = 1;
    [self loadFlickrPhotos];
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
    if (indexPath.row == [self.photosResponse.photos count] -1)  { // Load more data
        [self.photosTableView starLoadMoreIndicator];
        self.pageNumber +=1;
        [self loadFlickrPhotos];
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoModel * photoModel = [self.photosResponse.photos objectAtIndex:indexPath.row];
    [self showDetailsViewControllerWith:photoModel];
}

@end
