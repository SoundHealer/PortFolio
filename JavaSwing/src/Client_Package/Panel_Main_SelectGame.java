package Client_Package;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;

import mainPackage.CommonInterface;

public class Panel_Main_SelectGame extends JPanel implements CommonInterface {
	Frame_Main mainFrame = null;
	MyActionListener listener = new MyActionListener();

	Font labelFont = new Font("굴림", Font.BOLD, 30);
	Font btnFont = new Font("굴림", Font.PLAIN, 12);
	
	Panel_Main_SelectGame(Frame_Main mainFrame) {
		this.mainFrame = mainFrame;

		setLayout(null);

		JLabel selectGame_Label = new JLabel("게임 선택");
		selectGame_Label.setHorizontalAlignment(SwingConstants.CENTER);
		selectGame_Label.setFont(labelFont);
		selectGame_Label.setBounds(155, 48, 139, 41);
		add(selectGame_Label);

		JButton selectGame_Btn_1 = new JButton("초급");
		selectGame_Btn_1.setName("CCC");
		selectGame_Btn_1.setFont(btnFont);
		selectGame_Btn_1.setBounds(60, 115, 70, 70);
		selectGame_Btn_1.addActionListener(listener);
		add(selectGame_Btn_1);

		JButton selectGame_Btn_2 = new JButton("중급");
		selectGame_Btn_2.setName("BBB");
		selectGame_Btn_2.setBounds(190, 115, 70, 70);
		selectGame_Btn_2.setFont(btnFont);
		selectGame_Btn_2.addActionListener(listener);
		add(selectGame_Btn_2);

		JButton selectGame_Btn_3 = new JButton("고급");
		selectGame_Btn_3.setName("AAA");
		selectGame_Btn_3.setFont(btnFont);
		selectGame_Btn_3.setBounds(320, 115, 70, 70);
		selectGame_Btn_3.addActionListener(listener);
		add(selectGame_Btn_3);

	}

	@Override
	public void receptionMsg(String msg) {
		
	}

	class MyActionListener implements ActionListener {

		@Override
		public void actionPerformed(ActionEvent e) {
			Object obj = e.getSource();
			if (obj instanceof JButton) {
				JButton btn = (JButton) obj;
				mainFrame.receptionMsg(joinText("send", "selectGame", btn.getName()));
			}
		}
	}
}
