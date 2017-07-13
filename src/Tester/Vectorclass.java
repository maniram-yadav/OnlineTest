package Tester;
import java.sql.*;
import java.util.*;
public class Vectorclass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		vdataprocess db=new vdataprocess();
		try{
		Vector<Vector> vl=db.Data();
		Iterator<Vector> it=vl.iterator();
		if(it.hasNext())
		  {
			Vector<String> vl1=it.next();
			Iterator<String> it1=vl1.iterator();
			while(it1.hasNext()){
			System.out.println(it1.next());
			}
			System.out.println("_____________________________________");
		}
		
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
