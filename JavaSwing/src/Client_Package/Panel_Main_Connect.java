package Client_Package;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;

import mainPackage.CommonInterface;

public class Panel_Main_Connect extends JPanel implements CommonInterface {
	Frame_Main mainFrame = null;

	Panel_Main_Connect(Frame_Main mainFrame) {
		this.mainFrame = mainFrame; 

		setLayout(null);
		JTextField serverIP_textFiled;
		serverIP_textFiled = new JTextField();

		serverIP_textFiled.setFont(new Font("굴림", Font.PLAIN, 16));
		serverIP_textFiled.setBounds(122, 134, 205, 30);
		add(serverIP_textFiled);
		serverIP_textFiled.setColumns(10);

		JLabel connect_Label = new JLabel("서버 접속");
		connect_Label.setHorizontalAlignment(SwingConstants.CENTER);
		connect_Label.setFont(new Font("굴림", Font.BOLD, 30));
		connect_Label.setBounds(155, 48, 139, 41);
		add(connect_Label);

		JButton connectServer_Btn = new JButton("접속");
		connectServer_Btn.setBounds(255, 174, 72, 30);
		connectServer_Btn.setFont(new Font("굴림", Font.PLAIN, 12));
		// tryServerConnect/{ip}
		connectServer_Btn.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				System.out.println("버튼 이벤트");
				mainFrame.receptionMsg(joinText("Panel_Main_Connect","tryServerConnect",serverIP_textFiled.getText()));
			}
		});
		add(connectServer_Btn);

		JLabel inputIP_Label = new JLabel("서버 주소 입력");
		inputIP_Label.setHorizontalAlignment(SwingConstants.LEFT);
		inputIP_Label.setFont(new Font("굴림", Font.PLAIN, 12));
		inputIP_Label.setBounds(122, 119, 113, 15);
		add(inputIP_Label);

	}

	@Override
	public void receptionMsg(String msg) {
		System.out.println(getText(msg)[0]);
	}

}
