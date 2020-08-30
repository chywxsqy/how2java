package com.javawebxx.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;



public class TranUtil {
	
	private static String SERVICES_HOST = "www.webxml.com.cn";
    private static String TRAN_QUERY_URL = "http://webservice.webxml.com.cn/WebServices/TrainTimeWebService.asmx/getStationAndTimeByStationName?UserID=";
    
    /**
     * 通过cityCode获取天气信息
     * @param cityCode
     * @return
     */
    public static List<Map<String, String>> getTrans(String start, String end){
    	List<Map<String, String>> tranList = new ArrayList<Map<String, String>>();
        Document doc;
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        
        try {
			DocumentBuilder db = dbf.newDocumentBuilder();
			
			InputStream is = getSoapInputStream(TRAN_QUERY_URL + "&StartStation=" + URLEncoder.encode(start, "utf-8")+ "&ArriveStation=" + URLEncoder.encode(end, "utf-8"));
			doc = db.parse(is);

			NodeList nl = doc.getElementsByTagName("TimeTable");
			int len = nl.getLength();
			
			for (int i = 0; i < len; i++)
			{
			    Node n = nl.item(i);
			    NodeList nodeMap = n.getChildNodes();
			    
			    Map<String, String> mapTran = new HashMap<String, String>();
			    mapTran.put("TrainCode", nodeMap.item(1).getTextContent());
			    mapTran.put("FirstStation", nodeMap.item(3).getTextContent());
			    mapTran.put("LastStation", nodeMap.item(5).getTextContent());
			    mapTran.put("StartStation", nodeMap.item(7).getTextContent());
			    mapTran.put("StartTime", nodeMap.item(9).getTextContent());
			    mapTran.put("ArriveStation", nodeMap.item(11).getTextContent());
			    mapTran.put("ArriveTime", nodeMap.item(13).getTextContent());
			    tranList.add(mapTran);
			    
//			    System.out.println("列车："+nodeMap.item(1).getTextContent());
//			    System.out.println("始发："+nodeMap.item(3).getTextContent());
//			    System.out.println("终点："+nodeMap.item(5).getTextContent());
//			    System.out.println("起点："+nodeMap.item(7).getTextContent());
//			    System.out.println("开始时间："+nodeMap.item(9).getTextContent());
//			    System.out.println("到站："+nodeMap.item(11).getTextContent());
//			    System.out.println("到站时间："+nodeMap.item(13).getTextContent());
//			    System.out.println("--------------------------");
			    
			}
			is.close();
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		} catch (DOMException e) {
			
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			
			e.printStackTrace();
		} catch (SAXException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
        return tranList;
    }
    
    /**
     * 自己写的加载方法
     * @param url
     * @return
     */
    private static InputStream getSoapInputStream(String url)
    {
        InputStream is = null;

        try {
			URL U = new URL(url);
			URLConnection conn = U.openConnection();
			conn.setRequestProperty("Host", SERVICES_HOST);
			conn.connect();
			is = conn.getInputStream();
		} catch (MalformedURLException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
        return is;
    }
    
	public static void main(String[] args){
		List<Map<String, String>> listTrans = TranUtil.getTrans("无锡", "阜阳");
		for(Map<String,String> m:listTrans){
		    System.out.println("列车车次："+m.get("TrainCode"));
		    System.out.println("始发："+m.get("FirstStation"));
		    System.out.println("终点："+m.get("LastStation"));
		    System.out.println("起点："+m.get("StartStation"));
		    System.out.println("开始时间："+m.get("StartTime"));
		    System.out.println("到站："+m.get("ArriveStation"));
		    System.out.println("到站时间："+m.get("ArriveTime"));
		    System.out.println("--------------------------");
		}
	}
}
