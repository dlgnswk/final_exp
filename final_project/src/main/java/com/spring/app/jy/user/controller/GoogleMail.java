package com.spring.app.jy.user.controller;

import java.util.Map;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

public class GoogleMail {
	
	public void send_certification_code(Map<String, String> paraMap) throws Exception { 
		// 1. 정보를 담기 위한 객체
        Properties prop = new Properties(); 
        
        // 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
           //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
        prop.put("mail.smtp.user", "wldus081317@gmail.com");
        
        // 3. SMTP 서버 정보 설정
        //    Google Gmail 인 경우  smtp.gmail.com
        prop.put("mail.smtp.host", "smtp.gmail.com");
             
        
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.debug", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("mail.smtp.socketFactory.fallback", "false");
        
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        Authenticator smtpAuth = new MySMTPAuthenticator();
        Session ses = Session.getInstance(prop, smtpAuth);
           
        // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
        ses.setDebug(true);
                
        // 메일의 내용을 담기 위한 객체생성
        MimeMessage msg = new MimeMessage(ses);

        // 제목 설정
        String subject = paraMap.get("subject");
        msg.setSubject(subject);
                
        // 보내는 사람의 메일주소
        String sender = "wldus081317@gmail.com";
        Address fromAddr = new InternetAddress(sender);
        msg.setFrom(fromAddr);
                
        // 받는 사람의 메일주소
        Address toAddr = new InternetAddress(paraMap.get("email"));
        msg.addRecipient(Message.RecipientType.TO, toAddr);
                
        // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
   //     msg.setContent("<h2>아이디 "+paraMap.get("userid")+" 님의 임시 비밀번호입니다.</h2><br> <span style='font-size: 15pt'>임시 비밀번호 : </span><span style='font-size:17pt; color:red;'>"+ paraMap.get("new_pwd") +"</span>", "text/html;charset=UTF-8");
        msg.setContent(paraMap.get("contents"), "text/html;charset=UTF-8");
        
        // 메일 발송하기
        Transport.send(msg);
        
	} // end of public void send_certification_code(String recipient, String certification_code) throws Exception----------
}
