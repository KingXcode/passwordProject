//
//  RegularExpressionExample.h
//  pangu
//
//  Created by King on 2017/4/15.
//  Copyright © 2017年 zby. All rights reserved.
//


/*
 1.验证数字：
 只能输入1个数字
 
 
 表达式 ^\d$
 描述 匹配一个数字
 匹配的例子 0,1,2,3
 不匹配的例子
 
 2.只能输入n个数字
 表达式 ^\d{n}$  例如^\d{8}$
 描述 匹配8个数字
 匹配的例子 12345678,22223334,12344321
 不匹配的例子
 
 
 3.只能输入至少n个数字
 表达式 ^\d{n,}$ 例如^\d{8,}$
 描述 匹配最少n个数字
 匹配的例子 12345678,123456789,12344321
 不匹配的例子
 
 
 4.只能输入m到n个数字
 表达式 ^\d{m,n}$ 例如^\d{7,8}$
 描述 匹配m到n个数字
 匹配的例子 12345678,1234567
 不匹配的例子 123456,123456789
 
 
 5.只能输入数字
 表达式 ^[0-9]*$
 描述 匹配任意个数字
 匹配的例子 12345678,1234567
 不匹配的例子 E,清清月儿
 
 
 6.只能输入某个区间数字
 表达式 ^[12-15]$
 描述 匹配某个区间的数字
 匹配的例子 12,13,14,15
 不匹配的例子
 
 
 7.只能输入0和非0打头的数字
 表达式 ^(0|[1-9][0-9]*)$
 描述 可以为0，第一个数字不能为0，数字中可以有0
 匹配的例子 12,10,101,100
 不匹配的例子 01,清清月儿,http://blog.csdn.net/21aspnet
 
 
 8.只能输入实数
 表达式 ^[-+]?\d+(\.\d+)?$
 描述 匹配实数
 匹配的例子 18,+3.14,-9.90
 不匹配的例子 .6,33s,67-99
 
 
 9.只能输入n位小数的正实数
 表达式 ^[0-9]+(.[0-9]{n})?$以^[0-9]+(.[0-9]{2})?$为例
 描述 匹配n位小数的正实数
 匹配的例子 2.22
 不匹配的例子 2.222,-2.22,http://blog.csdn.net/21aspnet
 
 
 10.只能输入m-n位小数的正实数
 表达式 ^[0-9]+(.[0-9]{m,n})?$以^[0-9]+(.[0-9]{1,2})?$为例
 描述 匹配m到n位小数的正实数
 匹配的例子 2.22,2.2
 不匹配的例子 2.222,-2.2222,http://blog.csdn.net/21aspnet
 
 
 11.只能输入非0的正整数
 表达式 ^\+?[1-9][0-9]*$
 描述 匹配非0的正整数
 匹配的例子 2,23,234
 不匹配的例子 0,-4,
 
 
 12.只能输入非0的负整数
 表达式 ^\-[1-9][0-9]*$
 描述 匹配非0的负整数
 匹配的例子 -2,-23,-234
 不匹配的例子 0,4,
 
 
 13.只能输入n个字符
 表达式 ^.{n}$ 以^.{4}$为例
 描述 匹配n个字符，注意汉字只算1个字符
 匹配的例子 1234,12we,123清,清清月儿
 不匹配的例子 0,123,123www,http://blog.csdn.net/21aspnet/
 
 
 14.只能输入英文字符
 表达式 ^.[A-Za-z]+$为例
 描述 匹配英文字符，大小写任意
 匹配的例子 Asp,WWW,
 不匹配的例子 0,123,123www,http://blog.csdn.net/21aspnet/
 
 
 15.只能输入大写英文字符
 表达式 ^.[A-Z]+$为例
 描述 匹配英文大写字符
 匹配的例子 NET,WWW,
 不匹配的例子 0,123,123www,
 
 
 16.只能输入小写英文字符
 表达式 ^.[a-z]+$为例
 描述 匹配英文大写字符
 匹配的例子 asp,csdn
 不匹配的例子 0,NET,WWW,
 
 
 17.只能输入英文字符+数字
 表达式 ^.[A-Za-z0-9]+$为例
 描述 匹配英文字符+数字
 匹配的例子 1Asp,W1W1W,
 不匹配的例子 0,123,123,www,http://blog.csdn.net/21aspnet/
 
 
 18.只能输入英文字符/数字/下划线
 表达式 ^\w+$为例
 描述 匹配英文字符或数字或下划线
 匹配的例子 1Asp,WWW,12,1_w
 不匹配的例子 3#,2-4,w#$,http://blog.csdn.net/21aspnet/
 
 
 19.密码举例
 表达式 ^.[a-zA-Z]\w{m,n}$
 描述 匹配英文字符开头的m-n位字符且只能数字字母或下划线
 匹配的例子
 不匹配的例子
 
 
 20.验证首字母大写
 表达式 \b[^\Wa-z0-9_][^\WA-Z0-9_]*\b
 描述 首字母只能大写
 匹配的例子 Asp,Net
 不匹配的例子 http://blog.csdn.net/21aspnet/
 
 
 21.验证网址（带?id=中文）VS.NET2005无此功能
 表达式 ^http:\/\/([\w-]+(\.[\w-]+)+(\/[\w-   .\/\?%&=\u4e00-\u9fa5]*)?)?$
 
 描述 验证带?id=中文
 匹配的例子 http://blog.csdn.net/21aspnet/,
 http://blog.csdn.net?id=清清月儿
 不匹配的例子
 
 
 22.验证汉字
 表达式 ^[\u4e00-\u9fa5]{0,}$
 描述 只能汉字
 匹配的例子 清清月儿
 不匹配的例子 http://blog.csdn.net/21aspnet/
 
 
 23.验证QQ号
 表达式 [0-9]{5,9}
 描述 5-9位的QQ号
 匹配的例子 10000,123456
 不匹配的例子 10000w,http://blog.csdn.net/21aspnet/
 
 
 24.验证电子邮件（验证MSN号一样）
 表达式 \w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
 描述 注意MSN用非hotmail.com邮箱也可以
 匹配的例子 aaa@msn.com
 不匹配的例子 111@1.   http://blog.csdn.net/21aspnet/
 
 
 25.验证身份证号（粗验，最好服务器端调类库再细验证）
 表达式 ^[1-9]([0-9]{16}|[0-9]{13})[xX0-9]$
 描述
 匹配的例子 15或者18位的身份证号，支持带X的
 不匹配的例子 http://blog.csdn.net/21aspnet/
 
 
 26.验证手机号（包含159，不包含小灵通）
 表达式 ^13[0-9]{1}[0-9]{8}|^15[9]{1}[0-9]{8}
 描述 包含159的手机号130-139
 匹配的例子 139XXXXXXXX
 不匹配的例子 140XXXXXXXX,http://blog.csdn.net/21aspnet/
 
 
 27.验证电话号码号（很复杂，VS.NET2005给的是错的）
 表达式（不完美） 方案一  ((\(\d{3}\)|\d{3}-)|(\(\d{4}\)|\d{4}-))?(\d{8}|\d{7})
 方案二 (^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)  支持手机号但也不完美
 描述 上海：02112345678   3+8位
 上海：021-12345678
 上海：(021)-12345678
 上海：(021)12345678
 郑州：03711234567    4+7位
 杭州：057112345678    4+8位
 还有带上分机号，国家码的情况
 由于情况非常复杂所以不建议前台做100%验证，到目前为止似乎也没有谁能写一个包含所有的类型，其实有很多情况本身就是矛盾的。
 如果谁有更好的验证电话的请留言
 
 匹配的例子
 不匹配的例子
 
 
 28.验证护照
 表达式 (P\d{7})|G\d{8})
 
 描述 验证P+7个数字和G+8个数字
 匹配的例子
 不匹配的例子 清清月儿,http://blog.csdn.net/21aspnet/
 
 
 29.验证IP
 表达式 ^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$
 
 描述 验证IP
 匹配的例子 192.168.0.1   222.234.1.4
 不匹配的例子
 
 
 30.验证域
 表达式 ^[a-zA-Z0-9]+([a-zA-Z0-9\-\.]+)?\.s|)$
 
 描述 验证域
 匹配的例子 csdn.net   baidu.com  it.com.cn
 不匹配的例子 192.168.0.1
 
 
 31.验证信用卡
 表达式 ^((?:4\d{3})|(?:5[1-5]\d{2})|(?:6011)|(?:3[68]\d{2})|(?:30[012345]\d))[ -]?(\d{4})[ -]?(\d{4})[ -]?(\d{4}|3[4,7]\d{13})$
 
 描述 验证VISA卡，万事达卡，Discover卡，美国运通卡
 匹配的例子
 不匹配的例子
 
 
 32.验证ISBN国际标准书号
 表达式 ^(\d[- ]*){9}[\dxX]$
 
 描述 验证ISBN国际标准书号
 匹配的例子 7-111-19947-2
 不匹配的例子
 
 
 33.验证GUID全球唯一标识符
 表达式 ^[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}$
 
 描述 格式8-4-4-4-12
 匹配的例子 2064d355-c0b9-41d8-9ef7-9d8b26524751
 不匹配的例子
 
 
 34.验证文件路径和扩展名
 表达式 ^([a-zA-Z]\:|\\)\\([^\\]+\\)*[^\/:*?"<>|]+\.txt(l)?$
 
 描述 检查路径和文件扩展名
 匹配的例子 E:\mo.txt
 不匹配的例子 E:\ , mo.doc, E:\mo.doc ,http://blog.csdn.net/21aspnet/
 
 
 35.验证Html颜色值
 表达式 ^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$
 
 描述 检查颜色取值
 匹配的例子 #FF0000
 不匹配的例子 http://blog.csdn.net/21aspnet/
 
 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$
 
 整数或者小数：^[0-9]+\.{0,1}[0-9]{0,2}$
 只能输入数字："^[0-9]*$"。
 只能输入n位的数字："^\d{n}$"。
 只能输入至少n位的数字："^\d{n,}$"。
 只能输入m~n位的数字：。"^\d{m,n}$"
 只能输入零和非零开头的数字："^(0|[1-9][0-9]*)$"。
 只能输入有两位小数的正实数："^[0-9]+(.[0-9]{2})?$"。
 只能输入有1~3位小数的正实数："^[0-9]+(.[0-9]{1,3})?$"。
 只能输入非零的正整数："^\+?[1-9][0-9]*$"。
 只能输入非零的负整数："^\-[1-9][]0-9"*$。
 只能输入长度为3的字符："^.{3}$"。
 只能输入由26个英文字母组成的字符串："^[A-Za-z]+$"。
 只能输入由26个大写英文字母组成的字符串："^[A-Z]+$"。
 只能输入由26个小写英文字母组成的字符串："^[a-z]+$"。
 只能输入由数字和26个英文字母组成的字符串："^[A-Za-z0-9]+$"。
 只能输入由数字、26个英文字母或者下划线组成的字符串："^\w+$"。
 验证用户密码："^[a-zA-Z]\w{5,17}$"正确格式为：以字母开头，长度在6~18之间，只能包含字符、数字和下划线。
 验证是否含有^%&',;=?$\"等字符："[^%&',;=?$\x22]+"。
 只能输入汉字："^[\u4e00-\u9fa5]{0,}$"
 验证Email地址："^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"。
 验证InternetURL："^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$"。
 验证电话号码："^(\(\d{3,4}-)|\d{3.4}-)?\d{7,8}$"正确格式为："XXX-XXXXXXX"、"XXXX-XXXXXXXX"、"XXX-XXXXXXX"、"XXX-XXXXXXXX"、"XXXXXXX"和"XXXXXXXX"。
 验证身份证号（15位或18位数字）："^\d{15}|\d{18}$"。
 验证一年的12个月："^(0?[1-9]|1[0-2])$"正确格式为："01"～"09"和"1"～"12"。
 验证一个月的31天："^((0?[1-9])|((1|2)[0-9])|30|31)$"正确格式为；"01"～"09"和"1"～"31"。
 匹配中文字符的正则表达式： [\u4e00-\u9fa5]
 匹配双字节字符(包括汉字在内)：[^\x00-\xff]
 
 匹配空行的正则表达式：\n[\s| ]*\r
 
 匹配html标签的正则表达式：<(.*)>(.*)<\/(.*)>|<(.*)\/>
 
 匹配首尾空格的正则表达式：(^\s*)|(\s*$)
 
 
 
 匹配Email地址的正则表达式：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
 
 匹配网址URL的正则表达式：http://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?
 
 
 
 手机号码：(^(\d{3,4}-)?\d{7,8})$|(13[0-9]{9})|(15[8-9]{9})
 
 不会的也可以根据上面介绍的写出来了吧，只是得花点时间了。
 
 
 
 验证数字的正则表达式集
 验证数字：^[0-9]*$
 验证n位的数字：^\d{n}$
 验证至少n位数字：^\d{n,}$
 验证m-n位的数字：^\d{m,n}$
 验证零和非零开头的数字：^(0|[1-9][0-9]*)$
 验证有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
 验证有1-3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
 验证非零的正整数：^\+?[1-9][0-9]*$
 验证非零的负整数：^\-[1-9][0-9]*$
 验证非负整数（正整数 + 0） ^\d+$
 验证非正整数（负整数 + 0） ^((-\d+)|(0+))$
 验证长度为3的字符：^.{3}$
 验证由26个英文字母组成的字符串：^[A-Za-z]+$
 验证由26个大写英文字母组成的字符串：^[A-Z]+$
 验证由26个小写英文字母组成的字符串：^[a-z]+$
 验证由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$
 验证由数字、26个英文字母或者下划线组成的字符串：^\w+$
 验证用户密码:^[a-zA-Z]\w{5,17}$ 正确格式为：以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 验证是否含有 ^%&',;=?$\" 等字符：[^%&',;=?$\x22]+
 验证汉字：^[\u4e00-\u9fa5],{0,}$
 验证Email地址：^\w+[-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$
 验证InternetURL：^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$
 验证电话号码：^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$：--正确格式为：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX。
 验证身份证号（15位或18位数字）：^\d{15}|\d{}18$
 验证一年的12个月：^(0?[1-9]|1[0-2])$ 正确格式为：“01”-“09”和“1”“12”
 验证一个月的31天：^((0?[1-9])|((1|2)[0-9])|30|31)$  正确格式为：01、09和1、31。
 整数：^-?\d+$
 非负浮点数（正浮点数 + 0）：^\d+(\.\d+)?$
 正浮点数  ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
 非正浮点数（负浮点数 + 0） ^((-\d+(\.\d+)?)|(0+(\.0+)?))$
 负浮点数 ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
 浮点数 ^(-?\d+)(\.\d+)?
 */

/*
 一、校验数字的表达式
 1 数字：^[0-9]*$
 2 n位的数字：^\d{n}$
 3 至少n位的数字：^\d{n,}$
 4 m-n位的数字：^\d{m,n}$
 5 零和非零开头的数字：^(0|[1-9][0-9]*)$
 6 非零开头的最多带两位小数的数字：^([1-9][0-9]*)+(.[0-9]{1,2})?$
 7 带1-2位小数的正数或负数：^(\-)?\d+(\.\d{1,2})?$
 8 正数、负数、和小数：^(\-|\+)?\d+(\.\d+)?$
 9 有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
 10 有1~3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
 11 非零的正整数：^[1-9]\d*$ 或 ^([1-9][0-9]*){1,3}$ 或 ^\+?[1-9][0-9]*$
 12 非零的负整数：^\-[1-9][]0-9"*$ 或 ^-[1-9]\d*$
 13 非负整数：^\d+$ 或 ^[1-9]\d*|0$
 14 非正整数：^-[1-9]\d*|0$ 或 ^((-\d+)|(0+))$
 15 非负浮点数：^\d+(\.\d+)?$ 或 ^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0$
 16 非正浮点数：^((-\d+(\.\d+)?)|(0+(\.0+)?))$ 或 ^(-([1-9]\d*\.\d*|0\.\d*[1-9]\d*))|0?\.0+|0$
 17 正浮点数：^[1-9]\d*\.\d*|0\.\d*[1-9]\d*$ 或 ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
 18 负浮点数：^-([1-9]\d*\.\d*|0\.\d*[1-9]\d*)$ 或 ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
 19 浮点数：^(-?\d+)(\.\d+)?$ 或 ^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$
 
 二、校验字符的表达式
 1 汉字：^[\u4e00-\u9fa5]{0,}$
 2 英文和数字：^[A-Za-z0-9]+$ 或 ^[A-Za-z0-9]{4,40}$
 3 长度为3-20的所有字符：^.{3,20}$
 4 由26个英文字母组成的字符串：^[A-Za-z]+$
 5 由26个大写英文字母组成的字符串：^[A-Z]+$
 6 由26个小写英文字母组成的字符串：^[a-z]+$
 7 由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$
 8 由数字、26个英文字母或者下划线组成的字符串：^\w+$ 或 ^\w{3,20}$
 9 中文、英文、数字包括下划线：^[\u4E00-\u9FA5A-Za-z0-9_]+$
 10 中文、英文、数字但不包括下划线等符号：^[\u4E00-\u9FA5A-Za-z0-9]+$ 或 ^[\u4E00-\u9FA5A-Za-z0-9]{2,20}$
 11 可以输入含有^%&',;=?$\"等字符：[^%&',;=?$\x22]+
 12 禁止输入含有~的字符：[^~\x22]+
 
 三、特殊需求表达式
 1 Email地址：^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$
 2 域名：[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(/.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+/.?
 3 InternetURL：[a-zA-z]+://[^\s]* 或 ^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$
 4 手机号码：^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$
 5 电话号码("XXX-XXXXXXX"、"XXXX-XXXXXXXX"、"XXX-XXXXXXX"、"XXX-XXXXXXXX"、"XXXXXXX"和"XXXXXXXX)：^(\(\d{3,4}-)|\d{3.4}-)?\d{7,8}$
 6 国内电话号码(0511-4405222、021-87888822)：\d{3}-\d{8}|\d{4}-\d{7}
 7 身份证号(15位、18位数字)：^\d{15}|\d{18}$
 8 短身份证号码(数字、字母x结尾)：^([0-9]){7,18}(x|X)?$ 或 ^\d{8,18}|[0-9x]{8,18}|[0-9X]{8,18}?$
 9 帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 10 密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)：^[a-zA-Z]\w{5,17}$
 11 强密码(必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间)：^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$
 12 日期格式：^\d{4}-\d{1,2}-\d{1,2}
 13 一年的12个月(01～09和1～12)：^(0?[1-9]|1[0-2])$
 14 一个月的31天(01～09和1～31)：^((0?[1-9])|((1|2)[0-9])|30|31)$
 15 钱的输入格式：
 16 1.有四种钱的表示形式我们可以接受:"10000.00" 和 "10,000.00", 和没有 "分" 的 "10000" 和 "10,000"：^[1-9][0-9]*$
 17 2.这表示任意一个不以0开头的数字,但是,这也意味着一个字符"0"不通过,所以我们采用下面的形式：^(0|[1-9][0-9]*)$
 18 3.一个0或者一个不以0开头的数字.我们还可以允许开头有一个负号：^(0|-?[1-9][0-9]*)$
 19 4.这表示一个0或者一个可能为负的开头不为0的数字.让用户以0开头好了.把负号的也去掉,因为钱总不能是负的吧.下面我们要加的是说明可能的小数部分：^[0-9]+(.[0-9]+)?$
 20 5.必须说明的是,小数点后面至少应该有1位数,所以"10."是不通过的,但是 "10" 和 "10.2" 是通过的：^[0-9]+(.[0-9]{2})?$
 21 6.这样我们规定小数点后面必须有两位,如果你认为太苛刻了,可以这样：^[0-9]+(.[0-9]{1,2})?$
 22 7.这样就允许用户只写一位小数.下面我们该考虑数字中的逗号了,我们可以这样：^[0-9]{1,3}(,[0-9]{3})*(.[0-9]{1,2})?$
 23 8.1到3个数字,后面跟着任意个 逗号+3个数字,逗号成为可选,而不是必须：^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$
 24 备注：这就是最终结果了,别忘了"+"可以用"*"替代如果你觉得空字符串也可以接受的话(奇怪,为什么?)最后,别忘了在用函数时去掉去掉那个反斜杠,一般的错误都在这里
 25 xml文件：^([a-zA-Z]+-?)+[a-zA-Z0-9]+\\.[x|X][m|M][l|L]$
 26 中文字符的正则表达式：[\u4e00-\u9fa5]
 27 双字节字符：[^\x00-\xff] (包括汉字在内，可以用来计算字符串的长度(一个双字节字符长度计2，ASCII字符计1))
 28 空白行的正则表达式：\n\s*\r (可以用来删除空白行)
 29 HTML标记的正则表达式：<(\S*?)[^>]*>.*?</\1>|<.*? /> (网上流传的版本太糟糕，上面这个也仅仅能部分，对于复杂的嵌套标记依旧无能为力)
 30 首尾空白字符的正则表达式：^\s*|\s*$或(^\s*)|(\s*$) (可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式)
 31 腾讯QQ号：[1-9][0-9]{4,} (腾讯QQ号从10000开始)
 32 中国邮政编码：[1-9]\d{5}(?!\d) (中国邮政编码为6位数字)
 33 IP地址：\d+\.\d+\.\d+\.\d+ (提取IP地址时有用)
 34 IP地址：((?:(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d?\\d))
 */






