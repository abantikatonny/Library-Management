/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.SQLException;
import java.sql.Statement;
//import java.util.Date;

/**
 *
 * @author Abantika
 */
public class DatabaseProject {

    private Connection connect = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet rs = null;

    public void readDataBase(){

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager
                    .getConnection("jdbc:mysql://localhost/subscription_5318?" + "user=root&password=");
            statement = connect.createStatement();
            rs = statement
                    .executeQuery("select * from daily_rates");
            //writeResultSet(rs);

            System.out.println("resultset: " + rs);

            while (rs.next()) {
                System.out.println(rs.getString("Rate") + " " + rs.getString("Publication_ID"));
            }

        } catch (Exception e) {
            System.out.println("Exception Occurred");
            e.printStackTrace();
        }
    }
    
    /**
     * This method returns the address of a customer, given the name.
     * If the customer is not found, it returns a formatted error message.
     * @param customerName: String
     * @return String
     * @throws Exception 
     */
    String addressGetter(String customerName) throws Exception{
        String address = null;
        
        String query = "SELECT Address FROM customer WHERE Name=\'" + customerName + "\'";
        System.out.println(query);
        
        rs = statement.executeQuery(query);
        
        // Assuming that we do not have duplicate customer name
        try{
            rs.next();
            address = rs.getString("Address");
        } catch(Exception e){
            address = "Customer named [" + customerName + "] not found in Database.";
        }
        
        return address;
    }
    
    /**
     * Customer ID: [id] Name: [name] Address: [address]
     *
     * Customer ID: [id] Name: [name] Address: [address]
     */
    public String getAllCustomerInfo() {
        String result = "";
        try{
            String query = "SELECT * FROM customer";
            rs = statement.executeQuery(query);
            System.out.println("asidhalsdhlaksh");
            // Assuming that we do not have duplicate customer name
            try{
                while(rs.next()){
                    String c_id = rs.getString("ID");
                    String c_name = rs.getString("Name");
                    String address = rs.getString("Address");

                    String f_s = "Customer ID: " + c_id + '\n' + 
                            "Name: " + c_name + "\n" + 
                            "Address: " +address + "\n\n";
                    System.out.println(f_s);
                    result += f_s;
                }

            } catch(Exception e){
                e.printStackTrace();
            }
        } catch(Exception ex){
            result = "Operation Failed.";
        }
        System.out.println(result);
        return result;
    }
    
    /** ID: [id] Name: [name] Type_ID: [address] Frequency_ID: [Frequency_ID]
     *
     */
    public String getAllPublicationInfo(){
        String result = "";
        try{
            String query = "SELECT * FROM publication";
            rs = statement.executeQuery(query);
            System.out.println("asidhalsdhlaksh");
            // Assuming that we do not have duplicate customer name
            try{
                while(rs.next()){
                    String p_id = rs.getString("ID");
                    String p_name = rs.getString("Name");
                    String type_id = rs.getString("Type_ID");
                    String pf_id = rs.getString("Frequency_ID");
                    
                    // Get description of type_id;
                    String query2 = "SELECT Description from publication_type WHERE ID = \'"+ type_id  +"\'";
                    Statement stmnt2 = connect.createStatement();
                    ResultSet rsTemp = stmnt2.executeQuery(query2);
                    rsTemp.next();
                    type_id = rsTemp.getString("Description");
                    rsTemp.close();
                    
                    // Get description of type_id;
                    query2 = "SELECT Description from frequency WHERE ID = \'"+ pf_id  +"\'";
                    rsTemp = stmnt2.executeQuery(query2);
                    rsTemp.next();
                    pf_id = rsTemp.getString("Description");
                    rsTemp.close();
                    
                    String p_s = "ID: " + p_id + '\n' + 
                            "Name: " + p_name + "\n" + 
                            "Type_ID: " + type_id + "\n" +
                            "Frequency_ID: " + pf_id + "\n\n";
                    System.out.println(p_s);
                    result += p_s;
                }

            } catch(Exception e){
                e.printStackTrace();
            }
        } catch(Exception ex){
            result = "Operation Failed.";
        }
        System.out.println(result);
        return result;
    }
    
    
    
    
    
    /**
     * Method to insert new customer in the Database.
     * @param daily_ratesRate
     * @return
     * @throws Exception 
     */
    
    public String insertCustomer(String inputName, String inputAddress){
        String result = "Customer added Successfully.";
        
        try{
            String query = "INSERT INTO customer(name, address) Values(\"" +inputName + "\", \"" + inputAddress + "\")";
            System.out.println(query);
            statement.executeUpdate(query);
  
        } catch(Exception e){
            result = "Some error occured.";
            e.printStackTrace();
        }
        
        return result;
    }
    
    /**
     * Removes a customer from the database.
     * @param customerId
     * @return 
     */
    public String remove_customer(String customerId){
        String result = "Customer Removed Successfully";
        
        try{
            String query = "DELETE FROM CUSTOMER WHERE ID = \'"+ customerId +"\'";
            System.out.println(query);
            int k = statement.executeUpdate(query);
            if(k == 0)
                result = "Customer ID does not exist in Database.\n Remove operation Unsuccessful.";
        } catch(Exception e){
            result = "Error";
        }
        
        return result;
    }
    
    /** 
     * Method to insert publication in the Database 
     */
     public String insertPublication(String inputName1, String inputType_ID, String inputFrequency_ID){
        String result = "Publication added Successfully.";
        
        try{
            String query = "INSERT INTO publication(name, type_id, frequency_id) Values(\"" +inputName1 + "\", \"" + inputType_ID + "\", \"" + inputFrequency_ID + "\")";
            System.out.println(query);
            statement.executeUpdate(query);
  
        } catch(Exception e){
            result = "Some error occured.";
            e.printStackTrace();
        }
        
        return result;
    }
     
      /** 
     * Method to insert subscription in the Database 
     */
    
     public String insertsubscription(String inputcust1, String inputpub_ID, String inputnumofmonths, String inputbillamount, String inputrateid){
        String result = "Subscription added Successfully.";
        
        try{
            String query = "INSERT INTO subscription(customer_id, publication_id, rate_id, number_of_months, bill_amount) Values(\"" +inputcust1 + "\", \"" + inputpub_ID + "\", \"" + inputnumofmonths + "\","
                    + " \"" + inputrateid + "\", \"" + inputbillamount + "\")";
            System.out.println(query);
            statement.executeUpdate(query);
  
        } catch(Exception e){
            result = "Some error occured.";
            e.printStackTrace();
        }
        
        return result;
    }
    
    String publicationGetter(String daily_ratesRate) throws Exception{
        String address = null;
        
        String query = "SELECT Publication_ID FROM daily_rates WHERE Rate=\'" + daily_ratesRate + "\'";
        System.out.println(query);
        
        rs = statement.executeQuery(query);
        
        // Assuming that we do not have duplicate customer name
        try{
            rs.next();
            address = rs.getString("Publication_ID");
        } catch(Exception e){
            address = "Customer named [" + daily_ratesRate + "] not found in Database.";
        }
        
        return address;
    }

    
    public String changeRate(String pub_id, String freq_id, String new_rate){
        String result = "Changed successfully.";
        
        String query = "UPDATE SUBSCRIPTION_RATES SET RATE='"+ new_rate +"' "
                + "WHERE PUBLICATION_ID='"+ pub_id +"' AND "
                + "NUMBER_OF_ISSUES='"+freq_id +"'";
        System.out.println(query);
        
        try{
            int k = statement.executeUpdate(query);
            if (k == 0)
                result = "ERROR: Update Failed. \n"
                        + "Please check if Publication ID and Frequency ID exists in Database.";
        } catch(Exception e){
            e.printStackTrace();
        }
        return result;
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here

        DatabaseProject dbp = new DatabaseProject();
        try {
            dbp.readDataBase();
            
            System.out.println("Testing Functions");
            
            //System.out.println(dbp.publicationGetter("20") + '\n');
            //System.out.println(dbp.publicationGetter("100") + '\n');
            //System.out.println(dbp.publicationGetter("100") + '\n');
            
            System.out.println(dbp.getAllCustomerInfo());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
