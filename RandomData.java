import java.util.Random;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class RandomData {       
    
   public static void main(String[] args) {

       ArrayList<Integer> idarr;
       idarr = new ArrayList<Integer>();
            
       ArrayList<String> grouparr;
       grouparr = new ArrayList<String>();
            
       ArrayList<Double> num1arr;
       num1arr = new ArrayList<Double>();
                      
       ArrayList<Double> num2arr;
       num2arr = new ArrayList<Double>();

       ArrayList<Boolean> boolarr;
       boolarr = new ArrayList<Boolean>();            

       ArrayList<String> datearr;
       datearr = new ArrayList<String>();

       Random rnd = new Random();
       rnd.setSeed(555);

       ArrayList<String> alpha = new ArrayList<String>();
       alpha.add("A"); alpha.add("B"); alpha.add("C"); alpha.add("D");
       alpha.add("E"); alpha.add("F"); alpha.add("G"); alpha.add("H");
       alpha.add("I"); alpha.add("J"); alpha.add("K"); alpha.add("L");
       alpha.add("M"); alpha.add("N"); alpha.add("O"); alpha.add("P");
       alpha.add("Q"); alpha.add("R"); alpha.add("S"); alpha.add("T");
       alpha.add("U"); alpha.add("V"); alpha.add("W"); alpha.add("X");
       alpha.add("Y"); alpha.add("Z");

       ArrayList<Boolean> t_f = new ArrayList<Boolean>();
       t_f.add(false); t_f.add(true);

       DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
       Date date = new Date();
       String datetimeNow = dateFormat.format(date);
       long epoch = date.getTime();

       // Populate arrays
       for(int i=1; i<=50; i++) {
           idarr.add(rnd.nextInt(15));
           grouparr.add(alpha.get(rnd.nextInt(25)));
           num1arr.add(rnd.nextGaussian()*100);
           num2arr.add(rnd.nextGaussian());
           boolarr.add(t_f.get(rnd.nextInt(2)));

           long number = (long)(rnd.nextDouble()*epoch);
           date = new Date(number);
           String rand_dt = dateFormat.format(date);
           datearr.add(rand_dt);
          
       }

       try {     

            // Output data to CSV
            String COLUMN_HEADER = "ID,GROUP,NUM1,NUM2,BOOL,DATE";
            String COMMA_DELIMITER = ",";
            String NEW_LINE_SEPARATOR = "\n";
                   
            String currentDir = new File("").getAbsolutePath();
            for(int r=1; r<=10; r++) {

                  FileWriter writer = new FileWriter(currentDir + "/RandomData_JAVA_"+r+".csv");
                
                  // Column headers
                  writer.append(COLUMN_HEADER.toString());
                  writer.append(NEW_LINE_SEPARATOR);
            
                  // Data rows
                  for (int j=0; j<(idarr.size()); j++ ) {                    
                        writer.append(idarr.get(j).toString());
                        writer.append(COMMA_DELIMITER);
                        writer.append(grouparr.get(j).toString());
                        writer.append(COMMA_DELIMITER);
                        writer.append(num1arr.get(j).toString());
                        writer.append(COMMA_DELIMITER);                    
                        writer.append(num2arr.get(j).toString());
                        writer.append(COMMA_DELIMITER);          
                        writer.append(boolarr.get(j).toString());
                        writer.append(COMMA_DELIMITER);  
                        writer.append(datearr.get(j).toString());                    
                        writer.append(NEW_LINE_SEPARATOR);                        
                  }
                
                  writer.flush();
                  writer.close();
            }

            System.out.println("Successfully outputted random data to csv!");

       }
            
       catch (IOException ioe) {
            System.err.println(ioe.getMessage());
       }
        
   }
}
