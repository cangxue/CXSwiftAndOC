//
//  CXFileManagerViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/10/23.
//  Copyright © 2017年 CX. All rights reserved.
//
//  参考资料：http://www.jianshu.com/p/a08cf375043a

#import "CXFileManagerViewController.h"

@interface CXFileManagerViewController ()

@end

@implementation CXFileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取文件目录路径
    [self getFileDirectoryPath];
    
    // 创建文件夹/目录(返回创建结果)
}

// 获取文件目录路径
- (void)getFileDirectoryPath {
    /**
     NSSearchPathForDirectoriesInDomains方法用于查找目录，返回指定范围内的指定名称的目录的路径集合。有三个参数：
     directory NSSearchPathDirectory类型的enum值，表明我们要搜索的目录名称，比如这里用NSDocumentDirectory表明我们要搜索的是Documents目录。如果我们将其换成NSCachesDirectory就表示我们搜索的是Library/Caches目录。
     domainMask NSSearchPathDomainMask类型的enum值，指定搜索范围，这里的NSUserDomainMask表示搜索的范围限制于当前应用的沙盒目录。还可以写成NSLocalDomainMask（表示/Library）、NSNetworkDomainMask（表示/Network）等。
     expandTilde BOOL值，表示是否展开波浪线~。我们知道在iOS中~的全写形式是/User/userName，该值为YES即表示写成全写形式，为NO就表示直接写成“~”。
     
     该值为NO:Caches目录路径~/Library/Caches
     该值为YES:Caches目录路径
     /var/mobile/Containers/Data/Application/E7B438D4-0AB3-49D0-9C2C-B84AF67C752B/Library/Caches
     */
    
    // 获取沙盒主目录路径
    NSString *homeDir = NSHomeDirectory();
    // 获取Documents目录路径
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // 获取Library目录路径
    NSString *libDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    // 获取Caches目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    // 获取tmp目录路径
    NSString *tmpDir = NSTemporaryDirectory();
    
    //获取应用程序包中资源文件路径
    NSLog(@"%@",[[NSBundle mainBundle] bundlePath]);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"];
    UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
}

// 创建文件夹/目录(返回创建结果)
- (BOOL)createDir:(NSString *)dirName {
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dirPath = [cachesDir stringByAppendingPathComponent:dirName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDir]) {
        BOOL res = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        return res;
    } else {
        return YES;
    }
}

// 创建文件(返回创建结果)
- (BOOL)createFile:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *testDir = [cachesDir stringByAppendingPathComponent:@"CXTestDir"];
    //在testDir路径下创建test.pdf文件
    NSString *testPath = [testDir stringByAppendingPathComponent:@"test.pdf"];
    BOOL res = [fileManager createFileAtPath:testPath contents:nil attributes:nil];
    return res;
}

// 写数据到文件(返回写入结果)
-(BOOL)writeFile:(NSString *)path{
    NSString *testPath = [path stringByAppendingPathComponent:@"test.txt"];
    NSString *content=@"将数据写入到文件！";
    BOOL res=[content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return res;
}

// 读文件数据
-(void)readFile:(NSString *)path{
    //方法1:
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSString * content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //方法2:
    NSString * content2 = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"文件读取成功: %@",content);
}

// 文件属性
-(void)fileAttriutes:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    NSArray *keys;
    id key, value;
    keys = [fileAttributes allKeys];
    NSUInteger count = [keys count];
    for (int i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];  //获取文件名
        value = [fileAttributes objectForKey: key];  //获取文件属性
    }
}

//根据路径删除文件(返回删除结果)
-(BOOL)deleteFileByPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager removeItemAtPath:path error:nil];
    
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
    
    return res;
}

// 根据文件名删除文件
- (BOOL)deleteFileByName:(NSString *)name{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:[self getLocalFilePath:name] error:nil];//getLocalFilePath方法在下面
    
    return [fileManager isExecutableFileAtPath:[self getLocalFilePath:name]];
}

// 根据路径复制文件
- (BOOL)copyFile:(NSString *)path topath:(NSString *)topath {
    
    BOOL result = NO;
    NSError * error = nil;
    
    result = [[NSFileManager defaultManager]copyItemAtPath:path toPath:topath error:&error ];
    
    if (error){
        NSLog(@"copy失败：%@",[error localizedDescription]);
    }
    return result;
}

// 根据路径剪切文件
- (BOOL)cutFile:(NSString *)path topath:(NSString *)topath {
    
    BOOL result = NO;
    NSError * error = nil;
    result = [[NSFileManager defaultManager]moveItemAtPath:path toPath:topath error:&error ];
    if (error){
        NSLog(@"cut失败：%@",[error localizedDescription]);
    }
    return result;
    
}

// 根据文件名获取资源文件路径
- (NSString *)getResourcesFile:(NSString *)fileName {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
}

// 根据文件名获取文件路径
- (NSString *)getLocalFilePath:(NSString *) fileName {
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents"];
    return [NSString stringWithFormat:@"%@/%@",path,fileName];
}

// 根据文件路径获取文件名称
- (NSString *)getFileNameByPath:(NSString *)filepath {
    NSArray *array=[filepath componentsSeparatedByString:@"/"];
    if (array.count==0) return filepath;
    return [array objectAtIndex:array.count-1];
}

// 根据路径获取该路径下所有目录
- (NSArray *)getAllFileByName:(NSString *)path {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *array = [defaultManager contentsOfDirectoryAtPath:path error:nil];
    return array;
}

// 根据路径获取文件目录下所有文件
- (NSArray *)getAllFloderByName:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * fileAndFloderArr = [self getAllFileByName:path];
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString * file in fileAndFloderArr){
        
        NSString *paths = [path stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:paths isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:file];
        }
        isDir = NO;
    }
    return dirArray;
}

// 获取文件及目录的大小
- (float)sizeOfDirectory:(NSString *)dir {
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    NSString *pname;
    int64_t s=0;
    while (pname = [direnum nextObject]){
        //NSLog(@"pname   %@",pname);
        NSDictionary *currentdict=[direnum fileAttributes];
        NSString *filesize=[NSString stringWithFormat:@"%@",[currentdict objectForKey:NSFileSize]];
        NSString *filetype=[currentdict objectForKey:NSFileType];
        
        if([filetype isEqualToString:NSFileTypeDirectory]) continue;
        s=s+[filesize longLongValue];
    }
    return s*1.0;
}

// 重命名文件或目录
- (BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName {
    
    BOOL result = NO;
//    NSError * error = nil;
//    result = [[NSFileManager defaultManager] moveItemAtPath:[kDSRoot stringByAppendingPathComponent:oldName] toPath:[kDSRoot stringByAppendingPathComponent:newName] error:&error];
//
//    if (error){
//        NSLog(@"重命名失败：%@",[error localizedDescription]);
//    }
    
    return result;
}

// 读取文件
- (NSData *)readFileContent:(NSString *)filePath {
    
    return [[NSFileManager defaultManager] contentsAtPath:filePath];
}

// 保存文件
- (BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName {
    NSString * resultPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",newName]];
    return [[NSFileManager defaultManager] createFileAtPath:resultPath contents:data attributes:nil];
}

@end
