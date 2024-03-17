package Server_word;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Vector;
import java.util.Scanner;
import java.util.Random;

public class Words {
	
	Vector<String> wordVector = new Vector<String>();
	
	public Words(String file) {
		//파일로부터 단어 읽어오기
		try {
		FileReader readFile = new FileReader(file);
		Scanner scan = new Scanner(readFile);
		
		while(scan.hasNext()) {
			String word=scan.nextLine();
			wordVector.add(word);
			
		}
		scan.close();
		
		
		}catch(FileNotFoundException e){
			e.printStackTrace();
			System.out.println("파일이 없습니다.");
			System.exit(0);
		}
	}
	
	public void printWordAll() {
		
		for(String word : wordVector) {
			System.out.println(word);
		}
	}
	
	//임의의 단어 반환하기
	public String getRandomWord() {
        String randWord;
        Random rand = new Random();

        if (!wordVector.isEmpty()) {
            int index = rand.nextInt(wordVector.size());
            randWord = wordVector.remove(index); // 선택된 단어를 리스트에서 삭제
        } else {
            randWord = "No words available"; // 리스트가 비어있을 경우 처리
        }

        return randWord;
    }

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
	}

}
