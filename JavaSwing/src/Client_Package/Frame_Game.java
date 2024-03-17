package Client_Package;

import javax.swing.*;
import javax.swing.border.*;
import java.awt.*;
import java.awt.event.*;

import mainPackage.CommonInterface;

public class Frame_Game extends JFrame implements CommonInterface {
	Frame_Main mainFrame = null;
	String difficulty = "DDDD";
	Panel_Game panel_Game = null;
	
	Frame_Game(Frame_Main mainFrame){
		 
		this.mainFrame = mainFrame;
		
		setSize(730,560);
		setResizable(false);
		
		setFrameToCenter(this);

		setTitle("게임 시작하기");
		setTitle(difficulty);
		panel_Game = new Panel_Game(mainFrame,difficulty);
		add(panel_Game);
		
		setVisible(true);
	}
	
	@Override
	public void receptionMsg(String msg) {
		//서버에서 game부분 제외하고 받음
		
		if(panel_Game != null) {
			panel_Game.receptionMsg(msg);
			System.out.println("게임 패널로 전송 : " + msg);
		}
	}
	@Override
	public void setSize(int width, int height) {//판넬사이즈 입력
        super.setSize(width + 16, height + 39);
    }
}