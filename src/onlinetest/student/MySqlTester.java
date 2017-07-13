package onlinetest.student;

/*************************************************
 *                                               *
 *        @AUTHOR   MANIRAM  YADAV               *
 *        FGIET   B TECH  CSE  Student           * 
 *                                               *
 * ***********************************************/                                            


public class MySqlTester {

	public static void main(String[] args) throws Exception {
		QuesProcess qp=new QuesProcess();
		qp.setTestid("gk1");
		int i=qp.GetMaxQno();
		System.out.println(i);

	}

}
