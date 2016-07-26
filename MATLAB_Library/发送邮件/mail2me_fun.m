function mail2me_fun(subject,content) 
%====================================================================
%发邮件的程序（ling）
%mail2me_fun(subject,content)
%====================================================================
%输入参数：
%   [1] subject(string) 为邮件主题
%   [2] content(string) 为邮件内容

%% 函数默认值设定部分
if nargin==0
    subject = '程序运行完毕！';
    content = '请查看结果！';
end
%%
MailAddress = '18368917465@163.com'; 
password = 'APTX4869';   
setpref('Internet','E_mail',MailAddress); 
setpref('Internet','SMTP_Server','smtp.163.com'); 
setpref('Internet','SMTP_Username',MailAddress); 
setpref('Internet','SMTP_Password',password); 
props = java.lang.System.getProperties; 
props.setProperty('mail.smtp.auth','true'); 
sendmail('jwwang12@lzu.edu.cn',subject,content); 
display('程序运行完毕，邮件发送成功！');
end