package Server_Package_v2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import Server_word.Words;
import mainPackage.CommonInterface;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class GameInfo implements CommonInterface{
    public String difficulty;

    ArrayList<ServerSvcThread> userList = new ArrayList<ServerSvcThread>();
    private AddWord addWordThread;
    
    public Map<String, String> readyUser; // 사용자의 준비 상태를 저장하는 맵
    
    public Map<String, String> wordList;//단어 : 사용여부{t/f}
    

    public GameInfo() {
//        this.usersByDifficulty = new HashMap<>();
        this.readyUser = new HashMap<>();
        this.addWordThread = new AddWord();
        this.wordList = new ConcurrentHashMap<>();
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }
    public String getDifficulty() {
        return difficulty;
    }
    
    public void addUser(ServerSvcThread user) {
        // 난이도에 해당하는 사용자 목록 가져오기
    	String id = user.id;
    	System.out.println("난이도 확인"+difficulty);
        // 중복 체크
//    	broadcastMsg("새로운 유저 접속함 "+userList.size()+"명 [" + user.id + "]");
    	user.out.println(user.id + " 접속 확인.");
    	
    	if(userList.size() > 2) {
    		System.out.println("유저1,2 out 중복 확인" + userList.get(0).out.equals(userList.get(1).out));
    		System.out.println("유저1 : " + userList.get(0).out.toString());
    		System.out.println("유저2 : " + userList.get(1).out.toString());
    	}
    	
        if (!userList.contains(user)) {
            // 사용자 추가
            userList.add(user);
            System.out.println("userList 추가 : " + userList.size());
            
            
            // 난이도에 해당하는 사용자 목록 갱신
//            usersByDifficulty.put(difficulty, userList);

            // 사용자의 준비 상태 초기화 (기본값: "f")
            readyUser.put(id, "f");

            // PrintWriter를 리스트에 추가

            // 로그 출력
            System.out.println("사용자 추가: 난이도 " + difficulty + ", 사용자 ID: " + id);
            
            // 디버깅을 위해 현재 사용자 목록 출력
            System.out.println("현재 난이도 " + difficulty + "의 사용자 목록: " + getUsersAsString());
        } else {
            // 이미 추가된 사용자인 경우 메시지 출력 또는 처리
            System.out.println("이미 추가된 사용자입니다: " + id);
        }
    }

    public void removeUser(PrintWriter writer) {
        // PrintWriter를 리스트에서 제거
    	for(ServerSvcThread user :  userList) {
    		if(user.out.equals(writer)) {
    			userList.remove(user);
    		}
    	}
    		
//        clientWriters.remove(writer);
    }

    public List<String> getUsers() {
        // 난이도에 해당하는 사용자 목록 가져오기
    	//userList
    	List<String> result = new ArrayList<>();
    	
    	for(ServerSvcThread user : userList)
    		result.add(user.id);
        return result;
    }

    // 사용자 목록을 문자열로 반환하는 메소드 추가
    public String getUsersAsString() {
        List<String> userList = getUsers();
        return String.join(", ", userList);
    }

    // 사용자의 준비 상태 설정 메소드
    public void setReadyStatus(String userId, String readyStatus) {
        readyUser.put(userId, readyStatus);
    }

    // 사용자의 준비 상태 반환 메소드
    public String getReadyStatus(String userId) {
        return readyUser.getOrDefault(userId, "f");
    }

    public String getUserListReady() {
        List<String> userList = getUsers();
        StringBuilder result = new StringBuilder();

        for (String userId : userList) {
            String readyStatus = getReadyStatus(userId);
            result.append(userId).append(":").append(readyStatus).append("/");
        }

        return result.toString();
    }
    
    

    class AddWord extends Thread {
        GameInfo gameInfo; // GameInfo 인스턴스를 참조하기 위한 필드
        
        Words AAAwords = new Words("resource/hard.txt");
        Words BBBwords = new Words("resource/middle.txt");
        Words CCCwords = new Words("resource/easy.txt");
        

        @Override
        public void run() {
        	
            while (true) {
                try {
                    int ranX = rand(0, 500);

                    // 해당 난이도에 따라 단어 가져오기
                    String word;
                    switch (difficulty) {
                        case "AAA":
                            word = AAAwords.getRandomWord();
                            break;
                        case "BBB":
                            word = BBBwords.getRandomWord();
                            break;
                        case "CCC":
                            word = CCCwords.getRandomWord();
                            break;
                        default:
                        	word = CCCwords.getRandomWord();
                    }

                    // 단어와 초기 상태 "f" 추가
                    wordList.put(word, "f");

                    // 메시지 생성 및 브로드캐스트
                    String message = "game/addword/" + word + "/" + ranX;
                    broadcastMsg(message);

                    if (wordList.size() >= 5) {
                        break;
                    }

                    sleep(1000); // 루프에서 나온 후 1초 대기
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }


    public void startAddWordThread() {
        addWordThread.start();
    }

    public void processGuessedWord(String guessedWord, ServerSvcThread client) {
        // wordList에서 단어 찾기
        if (wordList.containsKey(guessedWord) && wordList.get(guessedWord).equals("f")) {
            // 해당 단어의 상태를 't'로 변경
            wordList.put(guessedWord, "t");

            // 해당 클라이언트에게 점수 부여
            client.score++;

            // 브로드캐스트: 맞춘 단어와 점수를 전송
            broadcastGuessedWord(guessedWord);
//            System.out.println("맞춘 단어 전달"+guessedWord);
            broadcastClientScore(client);
//            System.out.println("서버쪽 유저,점수 "+client.id +":"+client.score);

            // 모든 단어가 't'인지 확인하고 클리어 상태일 경우 game/end 메시지 전송
            if (isAllWordsCleared()) {
                broadcastGameEnd();
            }
        }
    }
    
    public void killWord(String guessedWord) {
    	System.out.println("killWord 함수 실행됨");
    	if (wordList.containsKey(guessedWord) && wordList.get(guessedWord).equals("f")) {
            // 해당 단어의 상태를 't'로 변경
            wordList.put(guessedWord, "t");
            String delWordMsg = joinText("game","delWord",guessedWord);
            // 틀린 단어 전달
            broadcastMsg(delWordMsg);
            System.out.println("단어 삭제 알림 : "+guessedWord);
            
            if (isAllWordsCleared()) {
                broadcastGameEnd();
            }
    	}

    }

    public boolean isAllWordsCleared() {
        // 모든 단어의 상태가 't'인지 확인
        for (String word : wordList.keySet()) {
            if (wordList.get(word).equals("f")) {
                return false; // 하나라도 'f'인 단어가 있으면 클리어 상태가 아님
            }
        }
        return true; // 모든 단어의 상태가 't'이면 클리어 상태
    }

    public void broadcastGuessedWord(String guessedWord) {
        String message = "game/delWord/"+guessedWord;

        // 모든 클라이언트에게 메시지 브로드캐스트
        broadcastMsg(message);
    }
    
    public void broadcastClientScore(ServerSvcThread client) {
    	
    	String message = "game/addScore/"+client;
    	broadcastMsg(message);
    }
    
    public void broadcastMsg(String msg) {
    	//클라이언트 전체 전송
    	for (ServerSvcThread client : userList) {
    		System.out.println("broadcastMsg : " + client.id + " 에게 전송함 : " + msg);
        	client.out.println(msg);
        }
    }
    
    public void broadcastGameEnd() {
        // 게임이 종료되었음을 클라이언트에게 알리는 메시지 생성
        String userListAndScores = getUserListAndScores();
        String message = joinText("game","gameEnd", userListAndScores);
//        System.out.println("게임 끝났음");

        // 모든 클라이언트에게 메시지 브로드캐스트
        broadcastMsg(message);
        
        resetGame();
    }
    
    private String getUserListAndScores() {
        String result = "";
    	for (ServerSvcThread client : userList) {
    		result = joinText(result,client.id + ":" + client.score);
        }
        return result;
    }
    
    public void resetGame() {
    	
    	for(ServerSvcThread user : userList) {
    		user.score = 0;
    	}
    	
        userList.clear();
        readyUser.clear();
        wordList.clear();
        addWordThread.interrupt();
        addWordThread = new AddWord();
    }

	@Override
	public void receptionMsg(String msg) {
		// TODO Auto-generated method stub
		
	}
}
