##第一章 ggplot2

library(tidyverse)

ggplot(mpg) +
  geom_point(aes(displ,hwy))

#图形属性
ggplot(mpg) +
  geom_point(aes(displ,hwy), color='blue')

ggplot(mpg) +
  geom_point(aes(displ,hwy, color=class))

ggplot(mpg) +
  geom_point(aes(displ,hwy, size=class))

ggplot(mpg) +
  geom_point(aes(displ,hwy, alpha=class))

ggplot(mpg) +
  geom_point(aes(displ,hwy, shape=class))

ggplot(mpg) +
  geom_point(aes(displ, hwy, color=cty))

ggplot(mpg) +
  geom_point(aes(displ, hwy, size=cty))

ggplot(mpg) +
  geom_point(aes(displ, hwy, shape=cty))

ggplot(mpg) +
  geom_point(aes(displ, hwy, color=cty, size=cty))

ggplot(mpg) +
  geom_point(aes(displ, hwy, color=displ<5))

##分面
ggplot(mpg) +
  geom_point(aes(displ,hwy)) +
  facet_wrap(~class, nrow=2)

ggplot(mpg) +
  geom_point(aes(displ,hwy)) +
  facet_grid(drv~cyl)

ggplot(mpg) +
  geom_point(aes(displ,hwy)) +
  facet_grid(~cyl)


ggplot(mpg) +
  geom_point(aes(displ,hwy)) +
  facet_grid(cty~)

ggplot(mpg) +
  geom_point(aes(displ,hwy,color=drv),size=1) +
  geom_smooth(aes(displ,hwy,color=drv))
#全局映射
ggplot(mpg, aes(displ,hwy,color=drv)) +
  geom_point(size=1) +
  geom_smooth()

ggplot(mpg) +
  geom_smooth(aes(displ,hwy,group=drv))

#单个映射只包含数据子集
ggplot(mpg, aes(displ,hwy,color=drv)) +
  geom_point(size=1) +
  geom_smooth(data=filter(mpg,class=='subcompact'),se=F,show.legend = FALSE)

##############################################
##diamonds
#cut频数分布图
ggplot(diamonds) +
  geom_bar(aes(cut))

#cut频率分布图
ggplot(diamonds) +
  geom_bar(aes(cut, ..prop..,group=1))

#用已经统计好的数据画图
demo <- tribble(
  ~a,  ~b,
  'a', 20,
  'b', 30,
  'c', 40)

ggplot(demo) +
  geom_bar(aes(a,b),stat='identity')

ggplot(demo) +
  geom_col(aes(a,b))

#数学变换
ggplot(diamonds) +
  stat_summary(aes(cut, depth))

ggplot(diamonds) +
  geom_pointrange(aes(cut,depth),
                  stat = 'summary'
                  )
 
  
ggplot(diamonds) +
  stat_summary(aes(cut, depth),
               fun.ymin = min,
               fun.ymax = max,
               fun.y = median
               )

##上色
ggplot(data = diamonds) +
  geom_bar(aes(cut, color = cut))

ggplot(data = diamonds) +
  geom_bar(aes(cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(aes(cut, fill = clarity))

##堆叠
#比较各组中clarity比例
ggplot(diamonds, aes(cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")

ggplot(diamonds, aes(cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

ggplot(diamonds) +
  geom_bar(aes(cut, fill = clarity),
    position = "fill"
  )

ggplot(diamonds) +
  geom_bar(aes(cut, fill = clarity),
           position = 'dodge')

#散点图中的堆叠
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy)
  )

ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy),
    position = "jitter"
  )

ggplot(mpg) +
  geom_jitter(aes(displ, hwy),
              width = 0.5, height = 0.5)


#交换坐标轴
ggplot(mpg) +
  geom_boxplot(aes(class, hwy))

ggplot(mpg) +
  geom_boxplot(aes(class, hwy)) +
  coord_flip()

#纵横比coord_quickmap
#极坐标
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()
