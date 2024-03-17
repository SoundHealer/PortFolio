package mainPackage;

//공용 변수 및 함수용
import javax.swing.*;
import javax.swing.border.*;

import java.awt.*;
import java.awt.event.*;
import java.util.HashMap;
import java.util.Random;

public interface CommonInterface {
	
	/**서버 포트번호 */
	public static final int portNumber = 9990;
	public static final int db_under_Limit = 3;
	public static final int db_top_Limit = 20;

	/**구분자*/
	public static final String separator = "/";
	
	/**테두리 검은색 실선 1px*/
	Border border_black_line = BorderFactory.createLineBorder(Color.BLACK, 1);
	
	/**
	 * 판넬간 데이터 송수신
	 */
	public void receptionMsg(String msg);
	/** 매개변수를 포함한 랜덤값 반환
	 * @param num1 정수
	 * @param num2 정수
	 * */
	public default int rand(int num1, int num2) {	//랜덤 생성시 좌표 생성용

		Random rand = new Random();

		int min = Math.min(num1,num2);
		int max = Math.max(num1,num2);

		return rand.nextInt((max - min) + 1) + min;
	}
	public default void setLabelAutoSize(JLabel label) {
		Dimension size = label.getPreferredSize();
		label.setSize(size.width +5, size.height);
	}
	/** 라벨의 위치를 반환
	 * getLabelLocation(JLabel).get({"x"}) */
	public default HashMap<String, Integer> getLabelLocation(JLabel label) {
		HashMap<String, Integer> result = new HashMap<String, Integer>();
		int x = label.getX();
		int y = label.getY();
		int h = label.getHeight();
		int w = label.getWidth();

		result.put("left", x);
		result.put("right", x + w);
		result.put("top", y);
		result.put("bottom", y);
		
		result.put("l", x);
		result.put("r", x + w);
		result.put("t", y);
		result.put("b", y);
		
		return result;
	}
	
	public default int value(String intString) {
		int result = -9;
		try {
			result = Integer.parseInt(intString);
		} catch(Exception e) {
			result = -99;
		}
		return result;
	}
	
	/**
	 * <ul>
	 * <li>매개변수 여러개의 문자열</li>
	 * <li>반환값 : 구분자로 구분된 하나의 문자열</li>
	 * <li>사용방법 joinText("하나","둘","셋") > "하나/둘/셋" 반환</li>
	 * </ul>
	 * @param strings 하나로 합칠 연속된 문자열
	 * */
	public default String joinText(String... strings) {
		String result = strings[0];
		
		for (int i = 1; i < strings.length; i++) {
			result = result + returnSeparator(result,separator) + strings[i];
		}
		return result;
	}
	public default String returnSeparator(String str,String separator) {
		return (str.length() == 0)? "":separator;
	}
	public default String joinText(String seq,String[] strings) {
		String result = strings[0];
		for (int i = 1; i < strings.length; i++) {
			result = result + returnSeparator(result,seq) + strings[i];
		}
		return result;
	}
	/**
	 * 매개변수로 전달받은 배열중 특정 인덱스값을 제외한 배열 반환
	 * <ul>
	 * <li>매개변수: [exceptIndex]제외할 문자 위치, [strings]문자열 배열</li>
	 * <li>반환값: 문자열 배열</li>
	 * <li>사용방법 joinText(0,["하나","둘","셋"]) > ["둘","셋"] 반환</li>
	 * </ul>
	 * @param exceptIndex 제외할 항목의 index값
	 * @param strings 문자열 배열
	 * */
	public default String[] joinText(int exceptIndex, String[] strings) {
		
		String result = (exceptIndex == 0) ? "" : strings[0];
		for (int i = 0; i < strings.length; i++) {
			if (exceptIndex != i) {
				if(result.length() == 0)
					result = strings[i];
				else
					result = result + separator + strings[i];
			}
		}
		return getText(result);
	}

	/**
	 * <ul>
	 * <li>매개변수 문자열</li>
	 * <li>반환값 : 구분자로 구분된 문자열 배열</li>
	 * <li>사용방법 getText("하나/둘/셋") > {"하나","둘","셋"} 반환 배열</li>
	 * </ul>
	 */
	public default String[] getText(String str) {
		// 매개변수 문자열
		// 반환값 : 구분자로 구분된 문자열 배열
		// 사용방법 getText("하나/둘/셋") > {"하나","둘","셋"} 반환 배열
		return str.split(separator);
	}
	public default String[] getText(String str,String separator) {
		// 매개변수 문자열
		// 반환값 : 구분자로 구분된 문자열 배열
		// 사용방법 getText("하나/둘/셋") > {"하나","둘","셋"} 반환 배열
		return str.split(separator);
	}
	/**
	 * 매개변수로 입력받은 두 문자열이 같으면 true 반환
	 */
	public default boolean checkText(String str1, String str2) {
		return str1.equalsIgnoreCase(str2);
	}

	/**
	 * 매개변수로 입력받은 문자열에 개행문자를 추가(개행문자가 없을때만)
	 */
	public default String appendNewLine(String msg) {
		String result = msg;
		if (!(result.endsWith("\n") || result.endsWith("\0"))) {
			result = result + "\n";
		}
		return result;
	}
	
	public default void setFrameToCenter(JFrame frame) {
		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();

        // 프레임을 화면 중앙에 표시
		frame.setLocationRelativeTo(null);

        // 중앙에 표시하고 나서 위치 조정
		frame.setLocation(screenSize.width / 2 - frame.getWidth() / 2, screenSize.height / 2 - frame.getHeight() / 2);
	}
	

}
