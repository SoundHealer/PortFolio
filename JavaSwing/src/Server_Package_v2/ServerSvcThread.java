package Server_Package_v2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Spliterator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Server_User.User;
import Server_User.UserDAO;
import mainPackage.CommonInterface;

public class ServerSvcThread extends Thread implements CommonInterface{
	
	Socket s;
	Server server;
	public String id;
	
	String pw;
	String responseMsg;
	private Map<String, GameInfo> gameInfoMap = new HashMap<>();
	
	public BufferedReader in;
	public PrintWriter out;
    public int score;

    public int getScore() {
        return score;
    }
	
    @Override
    public String toString() {
        return this.id+":"+this.score;
    }
	
	public ServerSvcThread(Socket s, Server server) {
		this.s = s;
		this.server = server;
        this.score = 0;
		
		try {
			this.in= new BufferedReader(new InputStreamReader(s.getInputStream()));
			this.out= new PrintWriter(s.getOutputStream(), true);
		}catch(IOException e) {
			closeAll();
		}
	}
	
	@Override
	public void run() {
	    // 클라이언트로 부터 오는 메시지 읽기
	    try {
	        while (true) {
	            String msg = in.readLine();
	            if (msg == null) {
	                // 클라이언트가 연결을 끊었을 때의 처리
	                break;
	            }
	            receptionMsg(msg);
//	            System.out.println("확인용");
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    } finally {
	        // 클라이언트가 연결을 끊었을 때의 자원 정리
	    	killUser();
	    }
	}
	

	void sendMessage(String msg) {
		out.println(msg);
	}
	
	
	void closeAll() {
		try {
			if (in !=null) { in.close(); }
			if (out !=null) { out.close(); }
			if (s!=null) {s.close();}
		}	catch(Exception e) {
			System.out.println("자원정리중 오류");
		}
	}
	
	
	@Override
	public void receptionMsg(String msg) {
	    // 클라이언트로부터 메시지를 받아들이는 메서드
	    if (msg.startsWith("login/")) {
	        
	        String[] loginInfo = getText(msg);

	        System.out.println("로그인쪽 ID와 비번" + loginInfo[1]+loginInfo[2]);

	        User user = new User();
	        user.setUserid(loginInfo[1]);
	        user.setUserpw(loginInfo[2]);

	        UserDAO userDAO = new UserDAO();
	        if (userDAO.checkUser(user)) {
	            responseMsg = joinText("login", "t");
	            this.id = loginInfo[1];
	            
	        } else {
	            responseMsg = joinText("login", "f");
	        }
	        sendMessage(responseMsg);
	        //sendMessage("err/로그인 실패");
	        System.out.println(responseMsg);
	    }
	    else if (msg.startsWith("signup/")) {
	       
	        String[] signupInfo = getText(msg);

	        System.out.println("회원가입쪽 ID와 비번 " + signupInfo[1]+signupInfo[2]);

	        User newUser = new User();
	        newUser.setUserid(signupInfo[1]);
	        newUser.setUserpw(signupInfo[2]);

	        UserDAO userDAO = new UserDAO();

	        
	        if (userDAO.checkUser(newUser)) {
	            responseMsg = joinText("signup", "f");
	        } else {
	            userDAO.insertUser(newUser);
	            responseMsg = joinText("signup", "t"); 
	        }

	        sendMessage(responseMsg);
	        System.out.println(responseMsg);
	    }
	    else if (msg.startsWith("selectGame/")) {
	        String[] selectGameInfo = getText(msg);

	        try {
	            // 난이도와 사용자 ID 추출
	            String difficulty = selectGameInfo[1];
	            String userId = this.id;
	            System.out.println(userId);

	            // 해당 난이도의 GameInfo 객체 가져오기 또는 생성
	            //server.gameInfo = server.getGameInfo();

//	            if (server.gameInfo == null) {
//	            	server.gameInfo = new GameInfo();
//                    //server.setGameInfo(server.gameInfo);  // 서버에 GameInfo 설정
//                }

	            server.gameInfo.setDifficulty(difficulty);
	            // 사용자 추가
	            server.gameInfo.addUser(this);

	            
	            // 디버깅을 위해 현재 사용자 목록 출력
	            System.out.println("현재 난이도 " + difficulty + "의 사용자 목록: " + server.gameInfo.getUsersAsString());

	            responseMsg = joinText("selectGame", "t");
	        } catch (Exception e) {
	            // 예외 처리
	            responseMsg = joinText("selectGame", "f");
	            e.printStackTrace();
	        }

	        sendMessage(responseMsg);
	        System.out.println(responseMsg);
	    }
	    else if (msg.startsWith("game/")) {
	        String[] gamemsg = getText(msg);

	        if (gamemsg.length >= 2 && gamemsg[1].equals("join")) {
	            String userListandReady = server.gameInfo.getUserListReady();
	            System.out.println("같은 난이도 유저 리스트 및 준비 상태: ");
	            responseMsg = joinText("game/userList/" + userListandReady);
	            
	            System.out.println("유저리스트 확인한다 서버쪽에서 이거"+responseMsg);
	            server.gameInfo.broadcastMsg(responseMsg);
	            server.gameInfo.broadcastMsg(joinText("game","join",id));
	        } else if (gamemsg.length > 2 && gamemsg[1].equals("ready")) {
	            String readyState = gamemsg[2];
	            server.gameInfo.setReadyStatus(this.id, readyState);

                String userListandReady = server.gameInfo.getUserListReady();

                responseMsg = joinText("game/userList/" + userListandReady);
                server.gameInfo.broadcastMsg(responseMsg);
	            // 모든 사용자의 준비 상태가 "t"인지 확인
	            List<String> userList = server.gameInfo.getUsers();
	            boolean allReady = true;
	            for (String userId : userList) {
	                if (!server.gameInfo.getReadyStatus(userId).equals("t")) {
	                    allReady = false;
	                    break;
	                }
	            }
	            // 모든 사용자가 준비 상태이면 "game/start" 메시지 전송
	            if (allReady) {
	            	System.out.println("게임 시작");
	            	server.gameInfo.broadcastMsg(joinText("game","start"));
	                server.gameInfo.startAddWordThread();
	            }
	        }else if (gamemsg.length > 2 && gamemsg[1].equals("chat")) {
	            String chatMsg = gamemsg[2];

	            // 클라이언트 ID를 메시지 형식에 포함
	            responseMsg = joinText("game", "chat", this.id, chatMsg);

	            // 모든 클라이언트에게 메시지를 브로드캐스트
	            server.gameInfo.broadcastMsg(appendNewLine(responseMsg));

//	            System.out.println("채팅 메시지 전송: " + chatMsg);
	        }
	    } else if (msg.startsWith("sendWord/")) {
	        String[] sendWordInfo = getText(msg);
	        String sendWord = sendWordInfo[1];

	        // 게임 정보의 addWordThread에 접근하여 단어를 삭제하고, 맞으면 점수 부여
	        server.gameInfo.processGuessedWord(sendWord, this);
	    } else if (msg.startsWith("killWord/")) {
	    	System.out.println("kill : " + msg);
	    	String[] killwordInfo = getText(msg);
	    	String killWord = killwordInfo[1];
	    	
	    	server.gameInfo.killWord(killWord);
	    } else if (checkText(msg,"leave")) {
	    	server.gameInfo.userList.remove(this);//접속 리스트에서 삭제
	    	server.gameInfo.readyUser.remove(id);// 게임 준비 리스트에서 삭제
	    	String userListandReady = server.gameInfo.getUserListReady();
	    	responseMsg = joinText("game","userList",userListandReady);
	        server.gameInfo.broadcastMsg(responseMsg);
	        server.gameInfo.broadcastMsg(joinText("game","killuser",id));
	    }
	    
	}
	public void killUser() {
    	server.clientThreads.remove(this);
    	server.gameInfo.broadcastMsg(joinText("game","killUser",id));//killUser/{userId}
    	String userListandReady = server.gameInfo.getUserListReady();
    	responseMsg = joinText("game","userList",userListandReady);
        
        server.gameInfo.broadcastMsg(responseMsg);
    	System.out.println(id + " : 클라이언트 연결 종료");
        closeAll();
    }
}