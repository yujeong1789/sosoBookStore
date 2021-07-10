package com.bookstore.book.model;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;



public class booksearchAPI {
	public static final int EXIST_BOOK=1;  //아이디가 이미 존재하는 경우
	public static final int NO_BOOK=0; //존재하지 않는 경우
	
	
	public int bookchekcISBN(String isbnx) throws IOException {
		String clientID="pX6hijzTdUsRB8IokJb7"; //네이버 개발자 센터에서 발급받은 clientID입력
        String clientSecret = "Ltm1oM1GqV";        //네이버 개발자 센터에서 발급받은 clientSecret입력
        String isbn = isbnx;//검색할 ISBN코드가 들어갑니다,
        URL url=null;
        Node text = null;
		try {
			url = new URL("https://openapi.naver.com/v1/search/book.xml?query="+isbn);//API 기본정보의 요청 url을 복사해오고 필수인 query를 적어줍니당!
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}
        StringBuilder sBuffer =new StringBuilder();
        String xml;
        BookDetailVo vo=new BookDetailVo();

        URLConnection urlConn=url.openConnection(); //openConnection 해당 요청에 대해서 쓸 수 있는 connection 객체 
        
        urlConn.setRequestProperty("X-Naver-Client-ID", clientID);
        urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
        
        BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
        while (true) {
            String line = br.readLine();
            if (line ==null)
                break;
            sBuffer.append(line);
        }
        br.close();
        xml=sBuffer.toString();
        
        try {
        // 팩토리 생성
        DocumentBuilderFactory dbfactory = DocumentBuilderFactory.newInstance();
        // 빌더 생성
        DocumentBuilder builder = dbfactory.newDocumentBuilder();
        // Document오브젝트 취득
        
        InputStream is =new ByteArrayInputStream(xml.getBytes());

        Document doc = builder.parse(is);
        // 루트의 자식 노드 취득
        Element root = doc.getDocumentElement();
        System.out.println("Root : " + root.getTagName());
        // 각노드의 리스트 취득
        
        NodeList list = root.getElementsByTagName("isbn");
        text = list.item(0).getFirstChild();
        System.out.println(text.getNodeValue());
        vo.setBd_ISBN(text.getNodeValue());

    } catch (Exception e) {
        e.printStackTrace();
    }
        
        if(text.getNodeValue()==null || text.getNodeValue().isEmpty()) {
        	return NO_BOOK;
        }else {
        	return EXIST_BOOK;
        }
	}
	
	public BookDetailVo booksearchISBN(String isbnx) throws IOException {
		String clientID="pX6hijzTdUsRB8IokJb7"; //네이버 개발자 센터에서 발급받은 clientID입력
        String clientSecret = "Ltm1oM1GqV";        //네이버 개발자 센터에서 발급받은 clientSecret입력
        String isbn = isbnx;//검색할 ISBN코드가 들어갑니다,
        URL url=null;
        
		try {
			url = new URL("https://openapi.naver.com/v1/search/book.xml?query="+isbn);//API 기본정보의 요청 url을 복사해오고 필수인 query를 적어줍니당!
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		}
        StringBuilder sBuffer =new StringBuilder();
        String xml;
        BookDetailVo vo=new BookDetailVo();

        URLConnection urlConn=url.openConnection(); //openConnection 해당 요청에 대해서 쓸 수 있는 connection 객체 
        
        urlConn.setRequestProperty("X-Naver-Client-ID", clientID);
        urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
        
        BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
        while (true) {
            String line = br.readLine();
            if (line ==null)
                break;
            sBuffer.append(line);
        }
        br.close();
        xml=sBuffer.toString();
        
        try {
        // 팩토리 생성
        DocumentBuilderFactory dbfactory = DocumentBuilderFactory.newInstance();
        // 빌더 생성
        DocumentBuilder builder = dbfactory.newDocumentBuilder();
        // Document오브젝트 취득
        
        InputStream is =new ByteArrayInputStream(xml.getBytes());

        Document doc = builder.parse(is);
        // 루트의 자식 노드 취득
        Element root = doc.getDocumentElement();
        System.out.println("Root : " + root.getTagName());
        // 각노드의 리스트 취득
       
        
        NodeList list = root.getElementsByTagName("title");
        Node text = list.item(1).getFirstChild();
        System.out.println(text.getNodeValue());
        vo.setBd_title(text.getNodeValue());
        
        list = root.getElementsByTagName("pubdate");
        text = list.item(0).getFirstChild();
        System.out.println(text.getNodeValue());
        
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        Date date =format.parse(text.getNodeValue());
        vo.setBd_pubdate(date);
        
        list = root.getElementsByTagName("author");
        text = list.item(0).getFirstChild();
        System.out.println(text.getNodeValue());
        vo.setBd_author(text.getNodeValue());
        
        list = root.getElementsByTagName("image");
        text = list.item(0).getFirstChild();
        System.out.println(text.getNodeValue());
        vo.setBd_image(text.getNodeValue());
        
        list = root.getElementsByTagName("description");
        text = list.item(1).getFirstChild();
        System.out.println(text.getNodeValue());
        vo.setBd_about(text.getNodeValue());
        
        list = root.getElementsByTagName("price");
        text = list.item(0).getFirstChild();
        System.out.println(text.getNodeValue());
        vo.setBd_price(Integer.parseInt(text.getNodeValue()));
        
        list = root.getElementsByTagName("publisher");
        text = list.item(0).getFirstChild();
        System.out.println(text.getNodeValue());
        vo.setBd_publisher(text.getNodeValue());

    } catch (Exception e) {
        e.printStackTrace();
    }
        
        return vo;
	}

}