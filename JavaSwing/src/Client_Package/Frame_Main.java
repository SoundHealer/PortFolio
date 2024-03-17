package Client_Package;

import javax.swing.*;
import javax.swing.border.*;

import Server_Package_v2.Server;

import java.awt.*;
import java.awt.event.*;
import javax.swing.JOptionPane;
import mainPackage.CommonInterface;

public class Frame_Main extends JFrame implements CommonInterface {
	//서버 같이 돌리기
	static boolean serverRun = true;
	
	boolean serverConnect = false;

	String nowLayout = "";

	Panel_Main_Connect main_Connect = null;
	Panel_Main_Login main_Login = null;
	Panel_Main_SelectGame main_SelectGame = null;
	Panel_Main_SignUp main_SignUp = null;
	TCP_Class tcp_Class = null;
	Frame_Game frame_gmae = null;
	CardLayout cardLayout = new CardLayout();

	Frame_Main() { 
		
		setSize(450, 300);
		setResizable(false);
		setTitle("게임 시작하기");
		
		setFrameToCenter(this);
		
		setLayout(cardLayout);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		tcp_Class = new TCP_Class(this);
		
		main_Connect = new Panel_Main_Connect(this);
		add(main_Connect, "main_Connect");
		
		main_Login = new Panel_Main_Login(this);
		add(main_Login, "main_Login");
		
		main_SelectGame = new Panel_Main_SelectGame(this);
		add(main_SelectGame, "main_SelectGame");
		
		main_SignUp = new Panel_Main_SignUp(this);
		add(main_SignUp, "main_SignUp");

		setCardLayout("main_Connect");

		setVisible(true);
		System.out.println(main_Connect.getSize().width + " : " + main_Connect.getSize().height);
	}
	@Override
	public void receptionMsg(String msg) {// 데이터 수신용
		String[] msgArray = getText(msg);
		System.out.println("메인 : " + msg);
		if (checkText(msgArray[0], "game")) {
			if(frame_gmae != null) {
				String gameMsg = joinText(joinText(0,msgArray));
				frame_gmae.receptionMsg(gameMsg);
				System.out.println("게임 프레임으로 전송 : " + gameMsg);
				//게임 관련 내용은 게임프레임으로 전달
			}
		} else if (checkText(msgArray[0], "setLayout")) {
			if (msgArray.length > 1) {
				System.out.println("레이아웃 변경");
				setCardLayout(msgArray[1]);
			}
		} else if (checkText(msgArray[0], "selectGame")) {
			if (msgArray.length > 1) {
				if (checkText(msgArray[1], "t")) {
					this.setVisible(false);
					frame_gmae = new Frame_Game(this);
					frame_gmae.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
					frame_gmae.addWindowListener(new java.awt.event.WindowAdapter() {
			            @Override
			            public void windowClosed(java.awt.event.WindowEvent windowEvent) {
			            	Frame_Main.this.setEnabled(true);
			            	Frame_Main.this.setVisible(true);
			            	tcp_Class.sendMsg("leave");
			            }
			        });
				}
			}
		} else if (checkText(msgArray[0], "Panel_Main_Connect")) {// Panel_Main_Connect에서 보낸 데이터일때
			if (checkText(msgArray[1], "tryServerConnect")) {// 서버 접속 시도 명령 수신

				if (tcp_Class != null)
					if (msgArray.length > 2)
						serverConnect = tcp_Class.connectServer(msgArray[2]);
					else
						serverConnect = tcp_Class.connectServer();
				if (serverConnect) {// 서버 접속 성공시
					setCardLayout("main_Login"); // 패널을 로그인패널로 변경
				}
			}
		} else if (checkText(msgArray[0], "login")) {// 서버로 데이터 전송
			if (checkText(msgArray[1], "t") || checkText(msgArray[1], "T")) {// 서버로 데이터 전송
				setCardLayout("main_SelectGame");
			}
		} else if (checkText(msgArray[0], "signup")) {// 서버로 데이터 전송
			if (checkText(msgArray[1], "t") || checkText(msgArray[1], "T")) {// 서버로 데이터 전송
				showMessage("회원가입이 완료되었습니다.");
				setCardLayout("main_Login");
			}

		} else if(checkText(msgArray[0], "err")) {
			showMessage(msgArray[1]);
		} else if (checkText(msgArray[0], "send")) {// 서버로 데이터 전송
			if(!serverConnect) {
				System.out.println("서버에 접속되있지 않습니다.");
				return;
			}else {
				tcp_Class.sendMsg(joinText(joinText(0,msgArray)));
			}
		}
	}
	
	public void showMessage(String str) {
		JOptionPane.showMessageDialog(null,str);
	}
	
	public void setCardLayout(String name) {
		System.err.println(name + "으로 레이아웃 변경");
		cardLayout.show(getContentPane(), name);
		nowLayout = name;
	}

	@Override
	public void setSize(int width, int height) {// 판넬사이즈 입력
		super.setSize(width + 16, height + 39);
	}
	
	public static void main(String[] strs) {
		//new receptionServer();
		int clientCount =1;
		for(int i = 0; i < clientCount;i++) {
			new Frame_Main();
		}
		if(!serverRun) {
			new Server();
		}
		
	}
}
