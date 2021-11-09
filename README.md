# HeartLighting
心形流水灯---给Girl带来的惊喜！！！

# 效果图
![心形灯](https://img2020.cnblogs.com/blog/775305/202111/775305-20211108175708776-1648080825.gif)  
# 点亮模式
    // 点亮一圈  
    case one_clockwise_all              // 顺时针一圈连续  
    case one_anticlockwise_all          // 顺时针一圈连续  
    case one_clockwise_one              // 顺时针一圈一个接一个  
    case one_anticlockwise_one          // 逆时针一圈一个接一个  
    
    // 点亮半圈  
    case half_clockwise_all             // 从上至下半圈连续  
    case half_anticlockwise_all         // 从下至上圈连续  
    case half_clockwise_one             // 从上至下半圈一个接一个  
    case half_anticlockwise_one         // 从下至上半圈一个接一个  
    
    // 点亮1234象限  
    case quarter1234_clockwise_all      // 顺时针全象限连续  
    case quarter1234_anticlockwise_all  // 顺时针全象限连续  
    case quarter1234_clockwise_one      // 顺时针全象限一个接一个  
    case quarter1234_anticlockwise_one  // 逆时针全象限一个接一个  
    
    // 点亮13象限  
    case quarter13_clockwise_all        // 顺时针13象限连续  
    case quarter13_anticlockwise_all    // 顺时针13象限连续  
    case quarter13_clockwise_one        // 顺时针13象限一个接一个  
    case quarter13_anticlockwise_one    // 逆时针13象限一个接一个  
    
    // 点亮24象限  
    case quarter24_clockwise_all        // 顺时针24象限连续  
    case quarter24_anticlockwise_all    // 顺时针24象限连续  
    case quarter24_clockwise_one        // 顺时针24象限一个接一个  
    case quarter24_anticlockwise_one    // 逆时针24象限一个接一个  
    
    // 点亮14象限  
    case quarter14_clockwise_all        // 顺时针14象限连续  
    case quarter14_anticlockwise_all    // 顺时针14象限连续  
    case quarter14_clockwise_one        // 顺时针14象限一个接一个  
    case quarter14_anticlockwise_one    // 逆时针14象限一个接一个  
    
    // 点亮23象限  
    case quarter23_clockwise_all        // 顺时针23象限连续  
    case quarter23_anticlockwise_all    // 顺时针23象限连续  
    case quarter23_clockwise_one        // 顺时针23象限一个接一个  
    case quarter23_anticlockwise_one    // 逆时针23象限一个接一个  
    
    // 亮熄切换  
    case allin_allout                   // 全亮全熄切换  
    case left_right                     // 左右切换  
    case top_bottom                     // 上下切换  
    case leftup_rightbottom             // 左上右下切换   
    case rightup_leftbottom             // 右上左下切换  
    case odd_even                       // 奇偶切换  
