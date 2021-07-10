package com.bookstore.utility;

public class Utility {
	
	public static String cutString(String title, int n) {
		//제목이 n자 이상인 경우 일부만 추출하기
		String result=title;
		if(title.length()>n) {
			result=title.substring(0, n)+"...";
		}

		return result;
	}
}
