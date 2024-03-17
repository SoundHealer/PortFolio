package Server_Package_v2;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

import mainPackage.CommonInterface;

public class Server implements CommonInterface{
	ServerSocket serverSocket;
//	List<ClientInfo> clientList;
	public List<ServerSvcThread> clientThreads = new ArrayList<>();
	public GameInfo gameInfo= new GameInfo();
	
	public Server(){
//		clientList = new ArrayList<>();
		
		try {
			serverSocket = new ServerSocket(portNumber);
			System.out.println("---서버 시작---");
			
			while(true) {
				Socket s = serverSocket.accept();
				
				ServerSvcThread th = new ServerSvcThread(s, this);
				th.start();
				
//				ClientInfo clientInfo = new ClientInfo(s);
//                clientList.add(clientInfo);
                
//				System.out.println("클라이언트가 접속했습니다.");
//				System.out.println(clientList.size());
				
				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	void closeAll() {
		if(serverSocket != null) {
			try {
				serverSocket.close();
			} catch (IOException e) {
				System.out.println("자원 정리중 예외 발생");
			}
		}
	}
	
	public void broadcastMessage(String message, ServerSvcThread sender) {
	    for (ServerSvcThread clientThread : clientThreads) {
	        // 메시지에 발신자의 ID를 포함
	        String msgWithSenderId = message + "/"+ sender.getId();
	        
	        // 발신자를 제외한 모든 클라이언트에게 메시지 전송
	        if (!checkText(clientThread.id, sender.id)) {
	            clientThread.sendMessage(msgWithSenderId);
	        }
	    }
	}



	
//	public void addClientThread(ServerSvcThread clientThread) {
//        clientThreads.add(clientThread);
//    }
//
//    public void removeClientThread(ServerSvcThread clientThread) {
//        clientThreads.remove(clientThread);
//    }
//	
//	void removeClient(ClientInfo client) {
//        clientList.remove(client);
//    }
//

//	
//	public GameInfo getGameInfo() {
//        return gameInfo;
//    }
//	public void setGameInfo(GameInfo gameInfo) {
//        this.gameInfo = gameInfo;
//    }

	@Override
	public void receptionMsg(String msg) {
		// TODO Auto-generated method stub
		
	}
	public static void main(String[] args) {
		Server server = new Server();
	}
	
}