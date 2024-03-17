package Client_Package;

import javax.swing.*;
import javax.swing.border.*;
import javax.swing.text.BadLocationException;
import javax.swing.text.Style;
import javax.swing.text.StyleConstants;
import javax.swing.text.StyleContext;
import javax.swing.text.StyledDocument;

import java.awt.*;
import java.awt.event.*;
import java.text.BreakIterator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;

import mainPackage.CommonInterface;

public class Panel_Game extends JPanel implements CommonInterface, Runnable {

	Frame_Main mainFrame = null;
	String difficulty = "";
	JButton gameReady_Btn;
	JTextPane chatBox;
	JTextField inputText;
	JTextField inputChat;
	JPanel drawTextPanel;
	JPanel userList;
	UserInfoPanel userListTitle;
	ArrayList<UserInfoPanel> userInfoList = new ArrayList<UserInfoPanel>();
	ArrayList<userScore> userScoreList = new ArrayList<userScore>();

	Thread gameThread = null;

	ArrayList<JLabel> wordLabelList = new ArrayList<JLabel>();
	JPanel scorePanel;
	boolean runGame = false;

	boolean isScoreMode;

	StyledDocument chatBoxStyledDoc;

	// "err" 텍스트용 스타일 객체 생성 (빨간색)
	MyKeyListener listener = new MyKeyListener();

	Panel_Game(Frame_Main mainFrame, String difficulty) {

		this.mainFrame = mainFrame;
		this.difficulty = difficulty;
		setLayout(null);
		setSize(730, 560);

		drawTextPanel = new JPanel();
		drawTextPanel.setBorder(border_black_line);
		drawTextPanel.setBounds(12, 10, 500, 500);
		drawTextPanel.setBackground(Color.WHITE);
		drawTextPanel.setLayout(null);
		add(drawTextPanel);

		gameReady_Btn = new JButton("Ready?");
		gameReady_Btn.setFont(new Font("굴림", Font.BOLD, 24));
		gameReady_Btn.setBounds(183, 224, 133, 52);

		gameReady_Btn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				mainFrame.receptionMsg(joinText("send", "game", "ready", "t"));// game/ready/{t:f}
				gameReady_Btn.setVisible(false);
			}
		});

		drawTextPanel.add(gameReady_Btn);
//		drawTextPanel.setBackground(Color.GREEN);

		FlowLayout flowLayout = new FlowLayout(FlowLayout.CENTER);
		flowLayout.setHgap(-1);
		flowLayout.setVgap(-1);

		userList = new JPanel();
		userList.setLayout(flowLayout);
		userList.setBorder(border_black_line);
		userList.setBounds(520, 10, 200, 189);
		userList.setBackground(Color.WHITE);
		EmptyBorder paddingBorder = new EmptyBorder(10, 10, 10, 10);

		// 패딩 적용
		userList.setBorder(paddingBorder);

		scorePanel = new JPanel();
		scorePanel.setBounds(130, 50, 240, 400);
		scorePanel.setLayout(flowLayout);
		scorePanel.setBorder(border_black_line);
		scorePanel.setBorder(paddingBorder);
		drawTextPanel.add(scorePanel);

		JLabel lblNewLabel = new JLabel("SCORE");
		lblNewLabel.setHorizontalAlignment(JLabel.CENTER);
		lblNewLabel.setFont(new Font("굴림", Font.BOLD, 28));
		Dimension di = new Dimension(220,40);
		lblNewLabel.setPreferredSize(di);
		scorePanel.add(lblNewLabel);

		scorePanel.setVisible(false);

		add(userList);

		chatBox = new JTextPane();
		chatBox.setBounds(520, 209, 200, 300);
		chatBox.setBackground(Color.WHITE);
		chatBox.setEnabled(true);
		chatBox.setEditable(false);

		JScrollPane scollPanel = new JScrollPane(chatBox);
		scollPanel.setBorder(border_black_line);

		scollPanel.setBounds(520, 209, 200, 300);
		scollPanel.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);

		add(scollPanel);

		inputText = new JTextField();
		inputText.setBounds(12, 520, 500, 30);
		inputText.setBorder(border_black_line);
		inputText.setColumns(10);
		inputText.setName("word");
		inputText.addKeyListener(listener);
		add(inputText);

		inputChat = new JTextField();
		inputChat.setColumns(10);
		inputChat.setBorder(border_black_line);
		inputChat.setBounds(520, 520, 200, 30);
		inputChat.setName("chat");
		add(inputChat);
		inputChat.addKeyListener(listener);

		mainFrame.receptionMsg(joinText("send", "game", "join"));

		chatBoxStyledDoc = chatBox.getStyledDocument();
		addUserList("유저아이디:준비상태", false);
	}

	public void addText(String text) {
		try {
			chatBoxStyledDoc.insertString(chatBoxStyledDoc.getLength(), appendNewLine(text), null);
		} catch (BadLocationException e) {
			e.printStackTrace();
		}
	}

	public void addColoredText(String text) {
		addText(appendNewLine(text));
	}

	public void addColoredText(String text, Color color) {
		Style style = chatBoxStyledDoc.addStyle("ColorStyle", null);
		StyleConstants.setForeground(style, color);

		try {
			chatBoxStyledDoc.insertString(chatBoxStyledDoc.getLength(), appendNewLine(text), style);
		} catch (BadLocationException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void receptionMsg(String msg) {
		String[] msgArray = getText(msg);
		System.out.println("게임 : " + msg);
		if (checkText(msgArray[0], "userList")) {// userList/[{userid}:{ready}]
			clearUserList();
			for (int i = 1; i < msgArray.length; i++) {
//				String[] userInfo = getText(msgArray[i], ":");
				addUserList(msgArray[i]);
//				System.out.println(i + " : " + userInfo[0] + " : " + userInfo[1]);
			}
		} else if (checkText(msgArray[0], "chat")) {// userList/[{userid}:{ready}]
			if (msgArray.length >= 3) {
				addColoredText(appendNewLine(msgArray[1] + " : " + msgArray[2]));
			} else {

				addColoredText(joinText(" ", msgArray), Color.RED);
			}
		} else if (checkText(msgArray[0], "addWord")) {// addWord/{str}/{x} addword/kind/248
			if (!runGame)
				return;
			if (msgArray.length >= 3) {
				String word = msgArray[1];
				String XPoition = msgArray[2];
				JLabel label = new JLabel(msgArray[1]);
				drawTextPanel.add(label); // 단어를 화면에 표시
				setLabelAutoSize(label); // 라벨 크기를 글자에 맞춤
				label.setBackground(Color.RED);
//				label.setBorder(border_black_line);
				label.setLocation(value(XPoition), 0); // 라벨 위치 설정
				if (getLabelLocation(label).get("r") > drawTextPanel.getWidth()) {
					label.setLocation(value(XPoition) - (getLabelLocation(label).get("r") - drawTextPanel.getWidth()),
							0); // 라벨 위치 설정
				}
				wordLabelList.add(label); // 리스트에 라벨 추가
			}
			if (gameThread == null) {
				gameThread = new Thread(this);
				gameThread.start();
			}
		} else if (checkText(msgArray[0], "start")) {// userList/[{userid}:{ready}]
			runGame = true;
			setScoreMode(true);
			addColoredText("채팅이 비활성화 되었습니다.", Color.RED);
			inputChat.setEditable(false);
		} else if (checkText(msgArray[0], "delWord")) {// game/delWord/{str}
			delWordLabel(msgArray[1]);
		} else if (checkText(msgArray[0], "addScore")) {// userList/[{userid}:{ready}]
			addUserScore(msgArray[1]);
		} else if (checkText(msgArray[0], "gameEnd")) {// gameEnd/[{userId:score}]
			runGame = false;
			for (int i = 1; i < msgArray.length; i++) {
				String userinf[] = getText(msgArray[i],":");
				userScoreList.add(new userScore(userinf[0], value(userinf[1])));
			}
			Collections.sort(userScoreList, Comparator.comparingInt(userScore::getScore).reversed());

			// 결과 출력
			for (int i = 0;i<userScoreList.size();i++) {
				userScore user = userScoreList.get(i);
				System.out.println(user.getid() + ": " + user.getScore());
				Dimension di = new Dimension(220,40);
				UserScorePanel panel = new UserScorePanel(i+1,user.getid(),user.getScore());
				panel.setPreferredSize(di);
				panel.setBorder(border_black_line);
				scorePanel.add(panel);
			}
			scorePanel.revalidate();
			scorePanel.repaint();
			scorePanel.setVisible(true);
		} else if (checkText(msgArray[0], "killUser")) {//killUser/qwe
			addText(msgArray[1] + "님이 게임을 퇴장했습니다.");
		} else if (checkText(msgArray[0], "join")) {//killUser/qwe
			addText(msgArray[1] + "님이 게임에 입장했습니다.");
		}

	}

	public void addUserScore(String str) { // id:{점수}
		String userinfo[] = getText(str, ":");
		for (UserInfoPanel userlist : userInfoList) {
			if (checkText(userlist.userId.getText(), userinfo[0])) {
				userlist.setScore(userinfo[1]);
			}
		}
	}

	public void addUserList(String str) { // id:{준비}
		addUserList(str, true);
	}

	public void addUserList(String str, boolean doAppendList) { // id:{준비}
		String userinfo[] = getText(str, ":");
		for (UserInfoPanel user : userInfoList) {
			if (checkText(user.userId.getText(), userinfo[0])) {
				// 리스트에 이미 있다면 종료
				return;
			}
		}

		UserInfoPanel userPanel = new UserInfoPanel(str);
		userPanel.setBorder(border_black_line);
		Dimension panelSize = new Dimension(userList.getWidth() - 20, 20);
		userPanel.setSize(panelSize);
		userPanel.setPreferredSize(panelSize);
		userList.add(userPanel);

		System.out.println("유저 정보 : " + str + " 추가");

		userList.revalidate();
		userList.repaint();

		if (doAppendList) {
			userInfoList.add(userPanel);
		} else {
			userListTitle = userPanel;
		}

	}

	public void clearUserList() { // 현재 유저리스트 초기화
		ArrayList<UserInfoPanel> duList = userInfoList;
		for (int i = 0; i < duList.size(); i++) {
			UserInfoPanel user = duList.get(i);
			System.out.println("유저 정보 : " + user.userId.getText() + " 삭제");
			userList.remove(user);
			userInfoList.remove(user);
		}
		userList.revalidate();
		userList.repaint();
	}

	public void wordMoveDown() {
		ArrayList<JLabel> duList = wordLabelList;
		for (int i = 0; i < duList.size(); i++) {
			JLabel label = duList.get(i);
			int x = label.getX();
			int y = label.getY();
			int w = label.getWidth();
			int h = label.getHeight();

			if ((y + h) >= drawTextPanel.getHeight()) {
				mainFrame.receptionMsg(joinText("send", "killWord", label.getText()));// killWord/{str}
			} else {
				label.setLocation(x, y + 5);
			}
		}
	}

	public void delWordLabel(String str) {

		for (int i = 0; i < wordLabelList.size(); i++) {
			JLabel label = wordLabelList.get(i);
			if (checkText(label.getText(), str)) {
				System.out.println(str + " 삭제");
				drawTextPanel.remove(label); // 판넬에서 삭제

				drawTextPanel.revalidate();
				drawTextPanel.repaint();

				wordLabelList.remove(i); // 리스트에서 삭제

				break;
			}
		}
	}

	public void setScoreMode(boolean isScore) {
		isScoreMode = isScore;
		if (isScore) {
			userListTitle.userInfo.setForeground(Color.BLACK);
			userListTitle.setInfo("점수");
			for (UserInfoPanel userlist : userInfoList) {
				userlist.setScoreMode(isScore);
			}
		} else {
			userListTitle.setInfo("준비상태");
		}
	}

	@Override
	public void run() {
		while (true) {
			while (runGame && wordLabelList.size() > 0) {
				try {
//					System.out.println("리스트 개수 : " + wordLabelList.size());
					wordMoveDown();
					Thread.sleep(500);
				} catch (Exception e) {

				}
			}
		}
	}

	public class MyKeyListener extends KeyAdapter {

		public void keyPressed(KeyEvent e) {
			try {
				int keyCode = e.getKeyCode();
				if (e.getSource() instanceof JTextField) {
					JTextField jt = (JTextField) e.getSource();
					String name = jt.getName();
					String str = appendNewLine(jt.getText());

					if (name.equals("chat") && keyCode == KeyEvent.VK_ENTER) {
						// send/game/chat
						mainFrame.receptionMsg(joinText("send", "game", "chat", appendNewLine(str)));
						jt.setText("");

					} else if (name.equals("word") && keyCode == KeyEvent.VK_ENTER) {
						// sendWord/{str}
						mainFrame.receptionMsg(joinText("send", "sendWord", appendNewLine(str)));
						jt.setText("");

					}
				}
			} catch (Exception err) {
				System.out.println("MyKeyListener 에러 : " + err.getMessage());
			}
		}
	}

	class btnActionListener implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent e) {

			if (e.getSource() instanceof JTextField) {
				JTextField jt = (JTextField) e.getSource();
//				System.out.println(btn.getName());
				String name = jt.getName();
				String str = jt.getText();
				if (name.equals("input")) {

				}
			}
		}

	}
	class UserScorePanel extends JPanel {
		JLabel rankLabel;
		JLabel userId;
		JLabel userInfo;
	
		Font font = new Font("굴림", Font.PLAIN, 24);
		public UserScorePanel(int rank, String id, int score) {
			rankLabel = new JLabel(rank + "위");
			this.userId = new JLabel(id);
			this.userInfo = new JLabel("" + score);
			setLayout(new GridLayout(1, 2, 0, 0));

			rankLabel.setFont(font);
			userId.setFont(font);
			userInfo.setFont(font);
			
			rankLabel.setHorizontalAlignment(JLabel.CENTER);
			userId.setHorizontalAlignment(JLabel.CENTER);
			userInfo.setHorizontalAlignment(JLabel.CENTER);
			
			add(rankLabel);
			add(userId);
			add(userInfo);
		}
	}
	public class userScore {
		private String id;
		private int score;

		public userScore(String id, int score) {
			this.id = id;
			this.score = score;
		}

		public String getid() {
			return id;
		}

		public int getScore() {
			return score;
		}
	}

	class UserInfoPanel extends JPanel {

		JLabel userId;
		JLabel userInfo;
		boolean isTitle;

		public UserInfoPanel(String str) {
			this.isTitle = false;
			String[] userinfo = getText(str, ":");

			setLayout(new GridLayout(1, 2, 0, 0));
			setBackground(Color.WHITE);

			userId = new JLabel();
			setId(userinfo[0]);
			add(userId);

			userInfo = new JLabel();
			setInfo(userinfo[1]);
			add(userInfo);

		}

		public void setScore(String string) {
			setInfo(string);
		}

		public UserInfoPanel(String str, boolean isTitle) {
			this.isTitle = isTitle;
			String[] userinfo = getText(str, ":");

			setLayout(new GridLayout(1, 2, 0, 0));
			setBackground(Color.WHITE);

			userId = new JLabel();
			setId(userinfo[0]);
			add(userId);

			userInfo = new JLabel();
			setInfo(userinfo[1]);
			add(userInfo);

		}

		public void setId(String id) {
			userId.setText(id);
		}

		void setScoreMode(boolean isScore) {
			userInfo.setText("0");
			if (isScore)
				userInfo.setForeground(Color.BLACK);
		}

		public void addScore() {
			int score = value(userInfo.getText());
			if (score >= 0) {
				setInfo("" + (score++));
			}
		}

		public void setInfo(String info) {
			if (!isTitle) {
				if (!isScoreMode) {
					if (checkText(info, "f")) {
						userInfo.setForeground(Color.RED);
						userInfo.setText("준비 안됨");
					} else {
						userInfo.setForeground(Color.GREEN);
						userInfo.setText("준비");
					}
				} else {
					userInfo.setText(info);
				}
			} else {
				userInfo.setForeground(Color.BLACK);
				userInfo.setText(info);
			}
		}
	}

}