#import "TutrialViewController.h"

@interface UIViewController()

@end

@implementation TutrialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
    [self setUpViews];
    [self setAndFireTimer];
}

- (void)setUpViews {
    CGSize viewSize = self.view.frame.size;
    //=======================scrollViewの用意=======================//
    if (viewSize.height / 2 - 220 < 100) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(viewSize.width / 2 - 95, viewSize.height / 2 - 178 , 190, 336)];
    } else {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(viewSize.width / 2 - 95, viewSize.height / 2 - 168 , 190, 336)];
    }
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    
    //=======================おじさんずの画像の用意=======================//
    //おじさんたちの画像を3つつなげるViewを作成 (190 * 3) * 336 --- "scrollView"に配置
    UIView* menView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 190 * 3, 336)];
    //3人のおじさんの画像を用意 190 * 336 --- 1から3を"menview"の左から配置
    UIImageView* redMenImageVie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onlyRedMan.png"]];
    redMenImageVie.frame = CGRectMake(0, 0, 190, 336);
    [menView addSubview:redMenImageVie];
    UIImageView* blueMenImageVie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onlyBuleMan.png"]];
    blueMenImageVie.frame = CGRectMake(190, 0, 190, 336);
    [menView addSubview:blueMenImageVie];
    UIImageView* greenMenImageVie = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onlyGreenMan.png"]];
    greenMenImageVie.frame = CGRectMake(380, 0, 190, 336);
    [menView addSubview:greenMenImageVie];
    //"menView"を"scrollview"に配置
    [scrollView addSubview:menView];
    
    //=======================iPhoneのフレーム=======================//
    //iPhoneの画像を用意 220 * 440 --- 真ん中に配置
    UIImageView* iPoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onlyiPhone.png"]];
    if (viewSize.height / 2 - 220 < 100) {
        iPoneImageView.frame = CGRectMake(viewSize.width / 2 - 110, viewSize.height / 2 - 230, 220 , 440);
    } else {
        iPoneImageView.frame = CGRectMake(viewSize.width / 2 - 110, viewSize.height / 2 - 220, 220 , 440);
    }
    //=======================バックグラウンド=======================//
    //バックグラウンドのスクロールビュー
    bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, viewSize.height)];
    bgScrollView.pagingEnabled = YES;
    bgScrollView.bounces = NO;
    //バックグラウンド3枚をつなげるView (220 * 3) * 440 --- "bgScrollView"に配置
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewSize.width * 3, viewSize.height)];
    //バックグラウンド3枚のUIImageView viewのサイズ --- "bgView"に左から配置 赤、青、緑の順番
    UIImageView* redBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Red.png"]];
    redBgView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    [bgView addSubview:redBgView];
    UIImageView* blueBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Blue.png"]];
    blueBgView.frame = CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
    [bgView addSubview:blueBgView];
    UIImageView* greenBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Green.png"]];
    greenBgView.frame = CGRectMake(viewSize.width * 2, 0, viewSize.width, viewSize.height);
    [bgView addSubview:greenBgView];
    [bgScrollView addSubview:bgView];
    //=======================Tutorialを閉じるボタンの作成=======================//
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    float height = 0.0f;
    float width = 0.0f;
    float length = 0.0f;
    if (viewSize.height / 2 - 220 < 100) {
        NSLog(@"small");
        height = 20.0f;
        width = 60.0f;
        length = 30.0f;
    } else if (viewSize.height / 2 - 220 < 140) {
        NSLog(@"None");
        height = 50.0f;
        width = 70.0f;
        length = 40.0f;
    } else {
        height = 65.0f;
        width = 84.0f;
        length = 55.0f;
    }
    closeButton.frame = CGRectMake(viewSize.width - width, height, length, length);
    [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateFocused];
    [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    //=======================下に表示するLabelの作成=======================//
    UILabel* label = [[UILabel alloc] init];
    float top = iPoneImageView.frame.origin.y + iPoneImageView.frame.size.height;
    label.frame = CGRectMake(0, top, viewSize.width, self.view.frame.size.height - top);
    label.text = @"あいうえおかきくけこ\nさしすせそたちつてと";
    label.numberOfLines = 2;
    label.textAlignment = UITextAlignmentCenter;
    
    //=======================ViewにaddSubView=======================//
    //"bgScrollView","iPoneImageView""scrollView"を追加
    [self.view addSubview:bgScrollView];
    [self.view addSubview:iPoneImageView];
    [self.view addSubview:scrollView];
    [self.view addSubview:closeButton];
    [self.view addSubview:label];
    scrollView.contentOffset = CGPointMake(190, 0);
    where = 2;
    bgScrollView.contentOffset = CGPointMake(viewSize.width, 0);
}

- (void)setAndFireTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(selectorOfTimer:) userInfo:Nil repeats:YES];
}
- (void)leftToRight {
    if(where == 3) {
        [scrollView setContentOffset:CGPointMake(190, 0) animated:YES];
        [bgScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
        where = 2;
    }else if(where == 2) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        where = 1;
    }
}

- (void)close:(UIButton*)sender {
    NSLog(@"close");
}


- (void)selectorOfTimer:(NSTimer*)timer {
    
}

- (void)rightToleft {
    if(where == 2) {
        [scrollView setContentOffset:CGPointMake(380,0) animated:YES];
        [bgScrollView setContentOffset:CGPointMake(self.view.frame.size.width * 2, 0) animated:YES];
        where = 3;
    } else if (where == 1) {
        [scrollView setContentOffset:CGPointMake(190, 0) animated:YES];
        [bgScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
        where = 2;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)handleOfLeft:(id)sender {
    [self rightToleft];
}

- (IBAction)handleOfRight:(id)sender {
    [self leftToRight];
}

@end
