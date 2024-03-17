package Client_Package;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;
import java.util.regex.Pattern;

import mainPackage.CommonInterface;

public class Panel_Main_SignUp extends JPanel implements CommonInterface {
	Frame_Main mainFrame = null;

	Panel_Main_SignUp(Frame_Main mainFrame) { 
		this.mainFrame = mainFrame;
		setLayout(null);
		JTextField userId_textFiled;
		userId_textFiled = new JTextField();
		userId_textFiled.setToolTipText("");

		userId_textFiled.setFont(new Font("굴림", Font.PLAIN, 16));
		userId_textFiled.setBounds(122, 107, 205, 30);
		add(userId_textFiled);
		userId_textFiled.setColumns(10);

		JLabel login_Label = new JLabel("회원가입");
		login_Label.setHorizontalAlignment(SwingConstants.CENTER);
		login_Label.setFont(new Font("굴림", Font.BOLD, 30));
		login_Label.setBounds(155, 41, 139, 41);
		add(login_Label);

		JLabel inputIP_Label = new JLabel("아이디");
		inputIP_Label.setHorizontalAlignment(SwingConstants.LEFT);
		inputIP_Label.setFont(new Font("굴림", Font.PLAIN, 12));
		inputIP_Label.setBounds(122, 92, 113, 15);
		add(inputIP_Label);

		JLabel inputIP_Label_1 = new JLabel("패스워드");
		inputIP_Label_1.setHorizontalAlignment(SwingConstants.LEFT);
		inputIP_Label_1.setFont(new Font("굴림", Font.PLAIN, 12));
		inputIP_Label_1.setBounds(122, 147, 113, 15);
		add(inputIP_Label_1);

		JTextField userPw_textField = new JTextField();
		userPw_textField.setToolTipText("");
		userPw_textField.setFont(new Font("굴림", Font.PLAIN, 16));
		userPw_textField.setColumns(10);
		userPw_textField.setBounds(122, 162, 205, 30);
		add(userPw_textField);

		JTextField userPwCheck_textField = new JTextField();
		userPwCheck_textField.setToolTipText("");
		userPwCheck_textField.setFont(new Font("굴림", Font.PLAIN, 16));
		userPwCheck_textField.setColumns(10);
		userPwCheck_textField.setBounds(122, 202, 205, 30);
		add(userPwCheck_textField);

		JButton signup_Btn = new JButton("회원가입");
		signup_Btn.setFont(new Font("굴림", Font.PLAIN, 12));
		signup_Btn.setBounds(232, 242, 95, 30);
		add(signup_Btn);
		signup_Btn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				JButton btn = (JButton) e.getSource();
				String id = userPw_textField.getText();
				String pw = userPw_textField.getText();
				String checkPw = userPwCheck_textField.getText();
				if (checkValidity(id) && checkValidity(pw) && checkPasswordEquality(pw, checkPw)) {
					mainFrame.receptionMsg(joinText("send", "signup", id, pw));
					// signup/{id}/{pw}
				}
			}
		});
		
		JButton showMainPanel = new JButton("돌아가기");
		showMainPanel.setFont(new Font("굴림", Font.PLAIN, 12));
		showMainPanel.setBounds(122, 242, 95, 30);
		showMainPanel.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				mainFrame.receptionMsg(joinText("setLayout","main_Login"));
			}
		});
		add(showMainPanel);
		

	}

	/** 유효성 검사 */
	public boolean checkValidity(String str) {
		boolean result = true;
		String regex = "^[a-zA-Z0-9_]+$";
		if (str.length() < db_under_Limit || str.length() > db_top_Limit) { // 문자열 길이 확인
			result = false;
			mainFrame.receptionMsg(joinText("err",String.format("아이디와 패스워드는 %d~%d자 까지 입력 가능합니다.", db_under_Limit, db_top_Limit)));
		}
		
		if (!Pattern.matches(regex, str)) { // 문자열 유효성 검사
			result = false;
			mainFrame.receptionMsg(joinText("err","사용할수 없는 문자가 포함되었습니다."));
		}
		
		return result;
	}

	public boolean checkPasswordEquality(String pw1,String pw2) {
		return pw1.equals(pw2);
	}

	@Override
	public void receptionMsg(String msg) {

	}

}