//
//  HPUserViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/2.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPUserViewController.h"
#import "HPUserNameViewController.h"
#import "HPUser.h"
#import "SDWebImage-umbrella.h"
//#import "ReactiveObjC.h"

@interface HPUserViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong) UITableView *userTableView;
@property(nonatomic,strong) NSArray *userSetterList;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) HPUser *user;

@end

@implementation HPUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifiyName:)
                                                 name:@"changeNameTongzhi"
                                               object:nil];
    
    self.user = [HPUser sharedHPUser];
    [self initUserTableView];
    
}

-(void)initUserTableView{
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    [self.view addSubview:_userTableView];
    _userSetterList = @[@"头像",@"昵称",@"ID",@"更多"];
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HPUserNameViewController *userNameVC = [[HPUserNameViewController alloc] init];
    userNameVC.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.row == 0) {
        UIAlertController *headImageAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        [headImageAlert addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
                UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
                imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePickerVC.allowsEditing = YES;
                imagePickerVC.delegate = self;
                [self presentViewController:imagePickerVC animated:YES completion:nil];
            }
        }]];
        [headImageAlert addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //拍照获得头像
            
        }]];
        [headImageAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:headImageAlert animated:YES completion:nil];
    }
    
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:userNameVC animated:YES];
    }
    
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //换头像
    if (indexPath.row == 0) {
        UIImage *image = [[UIImage alloc] init];
        if (_user.imagePath == NULL) {
            image = [UIImage imageNamed:@"路飞"];//默认为路飞头像
        }
        else{
            image = [UIImage imageWithContentsOfFile:_user.imagePath];
        }
        _headImageView = [[UIImageView alloc] initWithImage:image];
        [_headImageView setFrame:CGRectMake(0, 0, 60, 60)];
        cell.accessoryView = _headImageView;
    }else if (indexPath.row == 1){
        cell.detailTextLabel.text = _user.name;
    }else if (indexPath.row == 2){
        cell.detailTextLabel.text = _user.ID;
    }
    cell.textLabel.text = [_userSetterList objectAtIndex:indexPath.row];
    
    return cell;
}

//通知方法
-(void)modifiyName:(NSNotification *)tableView{
    [self.userTableView reloadData];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //获取选择的照片并保存
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self saveImage:image withName:@"headImage.jpg"];
    
    //获取沙盒中名为headImage.jpg的照片路径
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"headImage.jpg"];
    self.user.imagePath = imagePath;
    UIImage *saveImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    self.headImageView.image = saveImage;
    
    //通知给“我的”页面的头像
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:saveImage,@"modifyHead", nil];
    NSNotification *notification = [NSNotification notificationWithName:@"changeHeadTongzhi" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


/**
 照片使用imageName名写入在沙盒中

 @param currentImage 保存的照片
 @param imageName 保存名
 */
-(void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//返回上一层界面事件
-(void)backPreviousViewControllerAction{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeNameTongzhi" object:nil];
    // 返回上一层界面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
