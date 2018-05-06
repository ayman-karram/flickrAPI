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

NSString *const FlickrAPIKey = @"2ed35a9f4fda03bc96e73dbd03602780";


@interface ViewController ()
@property (nonatomic, readwrite) NSArray *photos;
@property (nonatomic) NSInteger imagePageOffset;
@property (nonatomic, copy) void (^ reloadBlock)(void);

@end

@implementation ViewController

- (void)viewDidLoad {
    self.imagePageOffset = 1;
    [self loadFlickrPhotos];
    
    UINib *cellNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CustomCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
}



//TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CustomCell";
    
     CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.imageTitleCell.text = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imageSubtitleCell.text = [[[self.photos objectAtIndex:indexPath.row] objectForKey:@"description"] objectForKey:@"_content"];;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 98;
}

- (void)reload {
     [self.tableView reloadData];
}

- (void)loadFlickrPhotos {
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=15&format=json&nojsoncallback=1&extras=date_taken,description,tags", FlickrAPIKey, @"cooking"];
    NSLog(@"%@", urlString);
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (!error) {
        NSDictionary *photosDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.photos = [[photosDictionary objectForKey:@"photos"] objectForKey:@"photo"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}



@end
