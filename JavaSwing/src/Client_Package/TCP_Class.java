package Client_Package;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

import javax.swing.plaf.metal.MetalBorders.Flush3DBorder;

import mainPackage.CommonInterface;

public class TCP_Class implements Runnable, CommonInterface {
	Frame_Main mainFrame = null;
	Socket socket = null;
	BufferedReader in = null;
	PrintWriter out = null;

	boolean serverConnect = false;

	TCP_Class(Frame_Main mainFrame) {
		this.mainFrame = mainFrame;
	}
	public boolean connectServer() {
		System.out.println("로컬서버로 접속합니다.");
		return connectServer("127.0.0.1");
	}
	public boolean connectServer(String serverIP) {
		try {
			if (serverIP == null || serverIP.isBlank() || serverIP.isEmpty()) {
				//System.out.println("서버 주소가 유효하지 않습니다.");
				System.out.println("로컬서버로 접속합니다.");
				serverIP = "127.0.0.1";
			} 
			socket = new Socket(serverIP, portNumber);
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			out = new PrintWriter(socket.getOutputStream(), true);
			System.out.println("[클라이언트]서버접속 성공");
			serverConnect = true;
			
			Thread tcpThread = new Thread(this);
			tcpThread.start();
		} catch (IOException e) {
			serverConnect = false;
			System.out.println("[클라이언트]서버 접속 실패");
		}
		return serverConnect;
	}
	
	public void sendMsg(String msg) {
		//개행문자를 추가해서 서버로 전송
		System.out.println("서버로 전송 : " + msg);
		out.print(appendNewLine(msg));
		out.flush();
	}
	

	@Override
	public void run() {// 메인클래스와 별개로 실행하기 위해 스레드로 실행
		try {
			while (serverConnect) {
				String msg;
				msg = in.readLine();
				if (!msg.isEmpty() && msg.length() > 0) {
					mainFrame.receptionMsg(msg);//상위의 메인프레임으로 수신데이터 전달
				}
			}
		} catch (IOException e) {
			serverConnect = false;
			System.out.println("[클라이언트]서버 통신중 에러 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			System.out.println("[클라이언트]서버 접속이 끊어졌습니다.");
		}
	}

	@Override
	public void receptionMsg(String msg) {
		
	}

}
