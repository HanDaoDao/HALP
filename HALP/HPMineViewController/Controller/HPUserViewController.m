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
#import "ReactiveObjC.h"
#import "UIImageView+HPHelper.h"

@interface HPUserViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong) UITableView *userTableView;
@property(nonatomic,strong) NSArray *userSetterList;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) HPUser *user;
@property(nonatomic,strong) BmobUser *bUser;
@property (nonatomic,strong) UIImagePickerController *imagePickerController;


@end

@implementation HPUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //使用RAC添加通知
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"changeNameTongzhi" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self.userTableView reloadData];
    }];
    
    self.user = [HPUser sharedHPUser];
    [self.user initUser];
    [self initUserTableView];
    [self initPickerView];
    
}

-(void)initUserTableView{
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    [self.view addSubview:_userTableView];
    _userSetterList = @[@"头像",@"昵称",@"ID",@"更多"];
}

-(void)initPickerView{
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = 30;
    _headImageView.layer.masksToBounds = YES;
    [_headImageView HPHeadimageBrowser];
    [_headImageView setFrame:CGRectMake(0, 0, 60, 60)];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    //打开相册时的动画效果
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePickerController.allowsEditing = YES;
    
    //不设置contentMode，图片会被压扁
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headImageView setClipsToBounds:YES];
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
                [self selectImageFromPhoto];
            }
        }]];
        [headImageAlert addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //拍照获得头像
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
                [self selectImageFromCamera];
            }
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

        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_user.icon] placeholderImage:[UIImage imageNamed:@"路飞"]];
        cell.accessoryView = _headImageView;
    }else if (indexPath.row == 1){
        cell.detailTextLabel.text = _user.nickName;
    }else if (indexPath.row == 2){
        cell.detailTextLabel.text = _user.stuID;
    }
    cell.textLabel.text = [_userSetterList objectAtIndex:indexPath.row];
    
    return cell;
}

//通知方法
-(void)modifiyName:(NSNotification *)tableView{
    [self.userTableView reloadData];
}

-(void)selectImageFromPhoto{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

-(void)selectImageFromCamera{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    NSString *imagePath;
    int randomValue = arc4random() % 1000;
    imagePath = [NSString stringWithFormat:@"%d.png", randomValue];
    if (@available(iOS 11.0, *)) {
        if (_imagePickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            NSURL *string = info[UIImagePickerControllerImageURL];
            NSArray *arr = [[string absoluteString] componentsSeparatedByString:@"/"];
            imagePath = arr[11];
            NSLog(@"图像路径完整路径~~%@",(NSString *)info[UIImagePickerControllerImageURL]);
        }
    }
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.headImageView.image = image;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    BmobFile *file = [[BmobFile alloc]initWithFileName:imagePath withFileData:imageData];
    BmobObject *obj = [[BmobObject alloc] initWithClassName:@"_User"];
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //上传文件的URL地址
            [obj setObject:file.url forKey:@"userIcon"];
            [obj saveInBackground];
            NSLog(@"头像保存成功！！！%@",file.url);
            _user.icon = file.url;
            BmobUser *bUser = [BmobUser currentUser];
            [bUser setObject:file forKey:@"userIcon"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                NSLog(@"error %@",[error description]);
            }];
        }else{
            //进行处理
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController * )picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//返回上一层界面事件
-(void)backPreviousViewControllerAction{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeNameTongzhi" object:nil];
    // 返回上一层界面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
