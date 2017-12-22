//
//  TestView.m
//  MyTools
//
//  Created by SongGuoxing on 2017/6/12.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "TestView.h"

@interface TestView ()
@property (nonatomic) CADisplayLink *displayLink;

@end

@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"initWithFrame:%@" ,NSStringFromCGRect(frame));
    }
    return self;
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews %@", self);
    [super layoutSubviews];
}

- (void)log {
    NSLog(@"super log");
}

- (void)changeRandomColor {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
//    self.displayLink.paused = YES;
    self.displayLink.preferredFramesPerSecond = 3;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)change {
//    self.displayLink.paused = NO;

    self.backgroundColor = RandomColor;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //获取当前绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置字形的变换矩阵为不做图形变换
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //平移方法，将画布向上平移一个屏幕高
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //缩放方法，x轴缩放系数为1，则不变，y轴缩放系数为-1，则相当于以x轴为轴旋转180度
    CGContextScaleCTM(context, 1.0, -1.0);
    
    /*
     事实上，图文混排就是在要插入图片的位置插入一个富文本类型的占位符。通过CTRUNDelegate设置图片
     */
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n这里在测试图文混排，\n我是一个富文本"];
    /*
     设置一个回调结构体，告诉代理该回调那些方法
     */
    //创建一个回调结构体，设置相关参数
    CTRunDelegateCallbacks callBacks;
    //memset将已开辟内存空间 callbacks 的首 n 个字节的值设为值 0, 相当于对CTRunDelegateCallbacks内存空间初始化
    memset(&callBacks,0,sizeof(CTRunDelegateCallbacks));
    callBacks.version = kCTRunDelegateVersion1;//设置回调版本，默认这个
    callBacks.getAscent = ascentCallBacks;//设置图片顶部距离基线的距离
    callBacks.getDescent = descentCallBacks;//设置图片底部距离基线的距离
    callBacks.getWidth = widthCallBacks;//设置图片宽度
    
    /*
     创建一个代理
     */
    //创建一个图片尺寸的字典，初始化代理对象需要
    NSDictionary * dicPic = @{@"height":@200,@"width":@105};
    //创建代理
    CTRunDelegateRef delegate = CTRunDelegateCreate(& callBacks, (__bridge void *)dicPic);
    
    //创建空白字符
    unichar placeHolder = 0xFFFC;
    //已空白字符生成字符串
    NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
    //用字符串初始化占位符的富文本
    NSMutableAttributedString * placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    //给字符串中的范围中字符串设置代理
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);//释放（__bridge进行C与OC数据类型的转换，C为非ARC，需要手动管理）
    //将占位符插入原富文本
    [attributeStr insertAttributedString:placeHolderAttrStr atIndex:10];
    //一个frame的工厂，负责生成frame
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
    CGMutablePathRef path = CGPathCreateMutable();//创建绘制区域
    CGPathAddRect(path, NULL, self.bounds);//添加绘制尺寸
    NSInteger length = attributeStr.length;
    //工厂根据绘制区域及富文本（可选范围，多次设置）设置frame
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
    //根据frame绘制文字
    CTFrameDraw(frame, context);
    
    UIImage * image = [UIImage imageNamed:@"樱花树1"];
    CGRect imgFrm = [self calculateImageRectWithFrame:frame];
    CGContextDrawImage(context,imgFrm, image.CGImage);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

static CGFloat ascentCallBacks(void * ref)
{
//    __bridge既是C的结构体转换成OC对象时需要的一个修饰词
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"height"] floatValue];
}
static CGFloat descentCallBacks(void * ref)
{
    return 0;
}
static CGFloat widthCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}


-(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
{
    //根据frame获取需要绘制的线的数组
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = [arrLines count];//获取线的数量
    CGPoint points[count];//建立起点的数组（cgpoint类型为结构体，故用C语言的数组）
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);//获取起点
    for (int i = 0; i < count; i ++) {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        //获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
        NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line);
        for (int j = 0; j < arrGlyphRun.count; j ++) {
            //获取CTRun
            CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j];
            //获取CTRun的属性
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            //获取代理
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;
            }
            //判断代理字典
            NSDictionary * dic = CTRunDelegateGetRefCon(delegate);
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGPoint point = points[i];//获取一个起点
            CGFloat ascent;//获取上距
            CGFloat descent;//获取下距
            CGRect boundsRun;//创建一个frame
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            boundsRun.size.height = ascent + descent;//取得高
            //获取x偏移量
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            boundsRun.origin.x = point.x + xOffset;//point是行起点位置，加上每个字的偏移量得到每个字的x
            boundsRun.origin.y = point.y - descent;//计算原点
            CGPathRef path = CTFrameGetPath(frame);//获取绘制区域
            CGRect colRect = CGPathGetBoundingBox(path);//获取剪裁区域边框
            CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
            return imageBounds;
        }
    }
    return CGRectZero;
}

@end
