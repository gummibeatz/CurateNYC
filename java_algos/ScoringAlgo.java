import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;


public class ScoringAlgo {
	
	static ScoringMatrix bottomFirstScores;
	static ScoringMatrix topFirstScores;
	static String [][] scores;
	
	static int MAXCLOTHESCATEGORIES = 2;
	static int MAXOUTFITS = 5;
	static int TOPINDEX = 0;
	static int BOTTOMINDEX = 1;
	
	
	final static int SCOREIDX = 0;
	final static int BCOLORIDX = 1;
	final static int L1COLORIDX = 2;
	final static int L2COLORIDX = 3;
	final static int L3COLORIDX = 4;
	
	final static String[] COLORINDICES = {"black","light blue","blue","dark blue","white","light brown","brown","dark brown","light gray","gray","dark gray","light red","red","dark red","light green","green","dark green","light orange","orange","dark orange","light purple","purple","dark purple","light yellow","yellow","dark yellow"};
	
	public static void main(String[] args) throws IOException {
		//getting command line arguments
		//should be in format
		// [temperatureClassification, category/layer#, colorOfBaseLayer, #bottoms, bottomColors, #L1, L1Colors, 
		//   #L2, L2Colors, #L3, L3Colors]
		String tempClass = args[0].toLowerCase();
		String category = args[1].toLowerCase();
		String origColor = args[2];
		int bottomCount = Integer.parseInt(args[3]);
		String[] bottomColors = new String[bottomCount];
		fillColorArray(4,bottomCount,args,bottomColors);
		int L1Count = Integer.parseInt(args[4+bottomCount]);
		String[] L1Colors = new String[L1Count];
		fillColorArray(5+bottomCount,L1Count,args,L1Colors);
		int L2Count = Integer.parseInt(args[4+bottomCount+1+L1Count]);
		String[] L2Colors = new String[L2Count];
		fillColorArray(6+bottomCount+L1Count,L2Count,args,L2Colors);
		int L3Count = Integer.parseInt(args[4+bottomCount+1+L1Count+1+L2Count]);
		String[] L3Colors = new String[L3Count];
		fillColorArray(7+bottomCount+L1Count+L2Count,L3Count,args,L3Colors);
		
//		System.out.printf("bottomCount = %d\n L1Count = %d\n L2Count = %d\n L3Count = %d\n", bottomCount, L1Count, L2Count, L3Count);
		
		//generating score matrices
		bottomFirstScores = new ScoringMatrix("./scoringCSVs/Algorithm_Scoring_System_Bottom_First.csv");
		topFirstScores = new ScoringMatrix("./scoringCSVs/Algorithm_Scoring_System_Top_First.csv");
				
		// picking match algo depending on temp
		switch(tempClass) {
		case "hot":
			if(category.equals("bottoms")) {
				scores = match2(category, origColor, L1Colors);
			} else {
				scores = match2(category, origColor, bottomColors);
			}
			break;
		case "warm":
			scores = match3(category, origColor, bottomColors, L1Colors, L2Colors);
			break;
		case "brisk":
		case "cold":
		}
//		System.out.println("\n\n\n");
		printScores();
	}
	
	public static void printScores() {
		for(int row=0; row<scores.length; row++) {
			for(int col=0; col<scores[row].length; col++) {
				String x = scores[row][col];
				if(x==null || x.isEmpty()) {
					System.out.print("NA ");
				} else {
					System.out.print(scores[row][col] + " ");
				}
			}
			System.out.println("");
		}
	}
	
	public static void fillColorArray(int startIdx, int arrLength, String[] args, String[] arr) {
//		System.out.println("in fill color array");
		for(int i = 0; i < arrLength; i++) {
			arr[i] = args[startIdx+i];
//			System.out.println(arr[i]);
		}
//		System.out.println("out of fill color array");
	}
	
	public static String[][] match2(String category, String origColor, String[] colorArr){
		String[][] scores = new String[colorArr.length][5];
		String[] score = new String[5];
		for(int i=0; i<colorArr.length; i++){
			int colorIdx1 = Arrays.asList(COLORINDICES).indexOf(origColor);
			int colorIdx2 = Arrays.asList(COLORINDICES).indexOf(colorArr[i]);
			if(category.equals("bottoms")){
				score[BCOLORIDX] = origColor;
				score[L1COLORIDX] = colorArr[i];
				score[SCOREIDX] = String.valueOf(bottomFirstScores.mat[colorIdx1][colorIdx2]); 
			}else{
				score[L1COLORIDX] = origColor;
				score[BCOLORIDX] = colorArr[i];
//				System.out.println(colorIdx1);
//				System.out.println(colorIdx2);
				score[SCOREIDX] = String.valueOf(topFirstScores.mat[colorIdx1][colorIdx2]);
			}
			scores[i] = score;
		}
		return scores;
	}
	
	public static String[][] match3(String category, String origColor, String[] bottomColors,
			String[] colorArr1, String[] colorArr2) {
		String[][] scores = new String[0][0];
		int bottomColorIdx, l1ColorIdx, l2ColorIdx;
		int ct = 0;
		switch(category) {
		case "bottoms":
			scores = new String[colorArr1.length*colorArr2.length][5];
			bottomColorIdx = Arrays.asList(COLORINDICES).indexOf(origColor);
			for(int i=0; i<colorArr1.length; i++) {
				l1ColorIdx = Arrays.asList(COLORINDICES).indexOf(colorArr1[i]);
				String[][] tempScores = match2("bottoms",origColor,colorArr2);
				// copy tempScores to scores and add in other scores
				for(int j=0; j<colorArr2.length; j++) {
					l2ColorIdx = Arrays.asList(COLORINDICES).indexOf(colorArr2[j]);
					scores[ct][SCOREIDX] = String.valueOf(Integer.parseInt(tempScores[j][SCOREIDX]) 
												+ bottomFirstScores.mat[bottomColorIdx][l1ColorIdx]
												+ topFirstScores.mat[l1ColorIdx][l2ColorIdx]); 
					scores[ct][BCOLORIDX] = origColor;
					scores[ct][L1COLORIDX] = colorArr1[i];
					scores[ct][L2COLORIDX] = colorArr2[j];
					ct++;
				}
			}
			break;
		case "l1":
//			System.out.println("in l1 case for match 3");
			scores = new String[bottomColors.length*colorArr2.length][5];
			l1ColorIdx = Arrays.asList(COLORINDICES).indexOf(origColor);
			for(int i=0; i<bottomColors.length; i++) {
				bottomColorIdx = Arrays.asList(COLORINDICES).indexOf(bottomColors[i]);
				String[][] tempScores = match2("bottoms", bottomColors[i], colorArr2);
				for(int j=0; j<colorArr2.length; j++) {	
					l2ColorIdx = Arrays.asList(COLORINDICES).indexOf(colorArr2[j]);
					scores[ct][SCOREIDX] = String.valueOf(Integer.parseInt(tempScores[j][SCOREIDX]) 
												+ bottomFirstScores.mat[bottomColorIdx][l1ColorIdx]
												+ topFirstScores.mat[l1ColorIdx][l2ColorIdx]); 
					scores[ct][BCOLORIDX] = bottomColors[i];
					scores[ct][L1COLORIDX] = origColor;
					scores[ct][L2COLORIDX] = colorArr2[j];
					ct++;
				}
			}
			break;
		case "l2":
//			System.out.println("in l2 case for match 3");
			scores = new String[bottomColors.length*colorArr1.length][5];
			l2ColorIdx = Arrays.asList(COLORINDICES).indexOf(origColor);
			for(int i=0; i<bottomColors.length; i++) {
				bottomColorIdx = Arrays.asList(COLORINDICES).indexOf(bottomColors[i]);
				String[][] tempScores = match2("bottoms", bottomColors[i], colorArr1);
				for(int j=0; j<colorArr1.length; j++) {	
					l1ColorIdx = Arrays.asList(COLORINDICES).indexOf(colorArr1[j]);
					scores[ct][SCOREIDX] = String.valueOf(Integer.parseInt(tempScores[j][SCOREIDX]) 
												+ bottomFirstScores.mat[bottomColorIdx][l2ColorIdx]
												+ topFirstScores.mat[l1ColorIdx][l2ColorIdx]); 
					scores[ct][BCOLORIDX] = bottomColors[i];
					scores[ct][L1COLORIDX] = colorArr1[j];
					scores[ct][L2COLORIDX] = origColor;
					ct++;
				}
			}
			break;
		}
		
		return scores;
	}
	
}
