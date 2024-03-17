package Client_Package;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;

import mainPackage.CommonInterface;

public class Panel_Main_Login extends JPanel implements CommonInterface {
	Frame_Main mainFrame = null;
	private JTextField userPw_textField;
	private JTextField userId_textFiled; 
	
	Panel_Main_Login(Frame_Main mainFrame){
		this.mainFrame = mainFrame;
			
		setLayout(null);
		userId_textFiled = new JTextField();
		userId_textFiled.setToolTipText("");

		userId_textFiled.setFont(new Font("굴림", Font.PLAIN, 16));
		userId_textFiled.setBounds(122, 114, 205, 30);
		add(userId_textFiled);
		userId_textFiled.setColumns(10);
		
		JLabel login_Label = new JLabel("로그인");
		login_Label.setHorizontalAlignment(SwingConstants.CENTER);
		login_Label.setFont(new Font("굴림", Font.BOLD, 30));
		login_Label.setBounds(155, 48, 139, 41);
		add(login_Label);
		
		
		
		JLabel inputIP_Label = new JLabel("아이디");
		inputIP_Label.setHorizontalAlignment(SwingConstants.LEFT);
		inputIP_Label.setFont(new Font("굴림", Font.PLAIN, 12));
		inputIP_Label.setBounds(122, 99, 113, 15);
		add(inputIP_Label);
		
		JLabel inputIP_Label_1 = new JLabel("패스워드");
		inputIP_Label_1.setHorizontalAlignment(SwingConstants.LEFT);
		inputIP_Label_1.setFont(new Font("굴림", Font.PLAIN, 12));
		inputIP_Label_1.setBounds(122, 154, 113, 15);
		add(inputIP_Label_1);
		
		userPw_textField = new JTextField();
		userPw_textField.setToolTipText("");
		userPw_textField.setFont(new Font("굴림", Font.PLAIN, 16));
		userPw_textField.setColumns(10);
		userPw_textField.setBounds(122, 169, 205, 30);
		add(userPw_textField);
		
		JButton login_Btn = new JButton("로그인");
		login_Btn.setBounds(249, 209, 78, 30);
		login_Btn.setFont(new Font("굴림", Font.PLAIN, 12));
		add(login_Btn);
		login_Btn.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				//로그인 버튼 클릭시 해당 레이아웃으로 변경 요청
				//login/{id}/{pw}
				mainFrame.receptionMsg(joinText("send","login",userId_textFiled.getText(),userPw_textField.getText()));
				//로그인 성공여부 확인후 진행
				
				//mainFrame.receptionMsg(joinText("setLayout","main_Connect"));
			}
		});
		
		JButton signup_Btn = new JButton("회원가입");
		signup_Btn.setFont(new Font("굴림", Font.PLAIN, 12));
		signup_Btn.setBounds(122, 209, 95, 30);
		add(signup_Btn);
		signup_Btn.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				
				mainFrame.receptionMsg(joinText("setLayout","main_SignUp"));
			}
		});
		
	}
	@Override
	public void receptionMsg(String msg) {
		
	}

}
