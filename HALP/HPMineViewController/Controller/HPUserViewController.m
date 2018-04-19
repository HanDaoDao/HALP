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

@interface HPUserViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong) UITableView *userTableView;
@property(nonatomic,strong) NSArray *userSetterList;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) HPUser *user;
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
        UIImage *image = [[UIImage alloc] init];
        if (_user.imagePath == NULL) {
            image = [UIImage imageNamed:@"路飞"];//默认为路飞头像
        }
        else{
            image = [UIImage imageWithContentsOfFile:_user.imagePath];
        }
        _headImageView = [[UIImageView alloc] initWithImage:image];
        _headImageView.layer.cornerRadius = 30;
        _headImageView.layer.masksToBounds = YES;
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

-(void)selectImageFromPhoto{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

-(void)selectImageFromCamera{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
//    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//
//    }];
//
//    UIImage *saveImage = info[UIImagePickerControllerEditedImage];
//    self.headImageView.image = saveImage;
//
//    //将照片存到媒体库
//    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//    [self saveImage:saveImage];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    //通知给“我的”页面的头像
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:saveImage,@"modifyHead", nil];
//    NSNotification *notification = [NSNotification notificationWithName:@"changeHeadTongzhi" object:nil userInfo:dict];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//}
//
//#pragma mark - 照片存到本地后的回调
//- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
//    if (!error) {
//        NSLog(@"存储成功");
//    } else {
//        NSLog(@"存储失败：%@", error);
//    }
//}
//
//#pragma mark - 保存图片
//- (void) saveImage:(UIImage *)currentImage {
//    //    设置照片的品质
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//
//    NSLog(@"%@",NSHomeDirectory());
//    //     获取沙盒目录
//    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/currentImage.png"];
//    //     将图片写入文件
//    [imageData writeToFile:filePath atomically:NO];
//
//    self.user.imagePath = filePath;
//
//}



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
