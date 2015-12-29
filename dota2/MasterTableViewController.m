//
//  MasterTableViewController.m
//  dota2
//
//  Created by inowei on 12/8/15.
//  Copyright © 2015 inowei. All rights reserved.
//
//--your key
#define API_KEY @""
#import "MasterTableViewController.h"
#import "BioTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DetailTableViewController.h"
@interface MasterTableViewController ()
{
 NSString *docPath;
 
}
@property NSArray *heroName;
@property NSURLSession *session;
@property NSDictionary *heroDetial;
@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"dota2";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
    self.session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [self fetchHeroNameData];
    [self fetchHeroAbilityData];
    [self fetchHeroListData];
    docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
}
- (void)viewWillAppear:(BOOL)animated
{
  
}

-(void)fetchHeroNameData{

    NSURL *Url= [NSURL URLWithString:[NSString stringWithFormat:@"https://api.steampowered.com/IEconDota2_570/GetHeroes/v0001/?key=%@&language=en_US",API_KEY]];
    NSURLSessionDataTask *dataTask=[self.session dataTaskWithURL:Url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *json= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.heroName=json[@"result"][@"heroes"];
      
         [json writeToFile:[docPath stringByAppendingPathComponent:@"heronamedata.plist" ] atomically:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData ];
        });
        
    }];
    [dataTask resume];
    
}
-(void)fetchHeroAbilityData{
    NSURL *Url=[NSURL URLWithString:@"http://www.dota2.com/jsfeed/heropediadata?feeds=abilitydata"];
    NSURLSessionDataTask *dataTask=[self.session dataTaskWithURL:Url completionHandler:^(NSData *data, NSURLResponse *resonse, NSError *error){
        NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"abilitydata"];
        [json writeToFile:[docPath stringByAppendingPathComponent:@"abilitydata.plist" ] atomically:YES];
        
        
        
    }];
    [dataTask resume];
}
-(void)fetchHeroListData{
    NSURL *Url = [NSURL URLWithString:@"http://www.dota2.com/jsfeed/heropickerdata"];
    NSURLSessionDataTask *dataTask=[self.session dataTaskWithURL:Url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        self.heroDetial=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        [self.heroDetial writeToFile:[docPath stringByAppendingPathComponent:@"herodetialdata.plist"] atomically:YES];
        NSLog(@"%@",self.heroDetial);
        
    }];
    [dataTask resume];
                  
}
-(void)setDataSource{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[docPath stringByAppendingPathComponent:@"herodetialdata.plist"]] ) {
        self.heroDetial=[NSArray arrayWithContentsOfFile:[docPath stringByAppendingPathComponent:@"herodetialdata.plist"]];
    }
    else
        [self fetchHeroListData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.y
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.heroName.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *sourceName=self.heroName[indexPath.row][@"name"];
    NSString *realName=[sourceName stringByReplacingOccurrencesOfString:@"npc_dota_hero_" withString:@""];
    
    NSString *urlName=[NSString stringWithFormat:@"http://cdn.dota2.com.cn/apps/dota2/images/heroes/%@_full.png",realName];
    NSLog(@"%@",urlName);
    cell.heroName.text=self.heroName[indexPath.row][@"localized_name"];
    cell.heroType.text=self.heroDetial[[self.heroDetial allKeys][indexPath.row]][@"atk_l"];
   
    [cell.heroIcon sd_setImageWithURL:[NSURL URLWithString:urlName]];
    

   
    
    
    // Configure the cell...
    
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"TODETAIL"]) {
        DetailTableViewController *detailVC=[segue destinationViewController];
        NSString *selectedHero=[self.heroName[self.tableView.indexPathForSelectedRow.row][@"name"] stringByReplacingOccurrencesOfString: @"npc_dota_hero_" withString:@""];
        detailVC.heroName=selectedHero;
        
        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
