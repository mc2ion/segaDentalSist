package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.ReportItem;

public class CreateReport implements DatabaseCommand {
	
	private String baseQuery = "SELECT C.IDENTITY_CARD, C.LAST_NAME, C.FIRST_NAME, CP.AFFILIATION_DATE, P.NAME AS PRODUCT_NAME, P.PRICE, " +
			"U.FIRST_NAME AS SELLER_FIRST_NAME, U.LAST_NAME AS SELLER_LAST_NAME, UR.NAME AS ROOM, CA.STREET, PT.NAME AS PROPERTY_TYPE, " +
			"CA.PROPERTY_NAME, CA.TOWER, CA.FLOOR, CA.APARTMENT, CA.URBANIZATION, CA.MUNICIPALITY, CA.POSTAL_CODE, CA.REFERENCE_POINT, CA.CITY, CA.STATE, " +
			"PHONE.HOME_NUMBER, PHONE.OFFICE_NUMBER, PHONE.MOBILE_NUMBER, PHONE.FAX_NUMBER, C.EMAIL FROM CLIENT C, CLIENT_PRODUCT " +
			"CP, PRODUCT P, USER U, USER_ROOM UR, CLIENT_ADDRESS CA, PROPERTY_TYPE PT, (SELECT OPH.ID, OPH.HOME_NUMBER, OPH.OFFICE_NUMBER, " +
			"OPH.MOBILE_NUMBER, F.PHONE_NUMBER AS FAX_NUMBER FROM (SELECT HPH.ID, HPH.HOME_NUMBER, O.PHONE_NUMBER AS OFFICE_NUMBER, " +
			"HPH.MOBILE_NUMBER FROM (SELECT MPH.ID, H.PHONE_NUMBER AS HOME_NUMBER, MPH.MOBILE_NUMBER FROM (SELECT C.ID, M.PHONE_NUMBER " +
			"AS MOBILE_NUMBER FROM CLIENT C LEFT OUTER JOIN (SELECT * FROM CLIENT_PHONE WHERE PHONE_TYPE_ID = 3) M ON C.ID = M.CLIENT_ID) " +
			"MPH LEFT OUTER JOIN (SELECT * FROM CLIENT_PHONE WHERE PHONE_TYPE_ID = 1) H ON MPH.ID = H.CLIENT_ID) HPH LEFT OUTER JOIN " +
			"(SELECT * FROM CLIENT_PHONE WHERE PHONE_TYPE_ID = 2) O ON HPH.ID = O.CLIENT_ID) OPH LEFT OUTER JOIN (SELECT * FROM CLIENT_" +
			"PHONE WHERE PHONE_TYPE_ID = 5) F ON OPH.ID = F.CLIENT_ID) PHONE WHERE C.ID = CP.CLIENT_ID AND CP.PRODUCT_ID = P.ID AND " +
			"CP.SELLER_ID = U.ID AND U.ROOM_ID = UR.ID AND C.ID = CA.CLIENT_ID AND CA.IS_SHIPPING = 1 AND CA.PROPERTY_TYPE_ID = PT.ID " +
			"AND C.ID = PHONE.ID";
	
	private Integer productId = null;
	private Integer statusId = null;
	private String state = null;
	
	public CreateReport(Integer productId, Integer statusId, String state){
		
		if(productId!=null){			
			baseQuery += " AND CP.PRODUCT_ID = ?";
			setProductId(productId);
		}
		
		if(statusId!=null){
			baseQuery += " AND CP.STATUS_ID = ?";
			setStatusId(statusId);
		}
		
		if(state!=null){
			baseQuery += " AND CA.STATE = ?";
			setState(state);
		}
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<ReportItem> list = new ArrayList<ReportItem>();
		PreparedStatement sta = conn.prepareStatement(baseQuery);
		int i = 1;
		
		if(productId != null){
			sta.setInt(i, productId);
			i++;
		}
		
		if(statusId!=null){
			sta.setInt(i, statusId);
			i++;
		}
		
		if(state!=null){
			sta.setString(i, state);
		}		
				
		ResultSet rs = sta.executeQuery();
		
		while(rs.next()) {
			ReportItem reportItem = new ReportItem();
			reportItem.setIdentityCard(rs.getString(1));
			reportItem.setLastName(rs.getString(2));
			reportItem.setFirstName(rs.getString(3));
			reportItem.setAffiliationDate(rs.getDate(4));
			reportItem.setProduct(rs.getString(5));
			reportItem.setPrice(rs.getDouble(6));
			reportItem.setSeller(rs.getString(7), rs.getString(8));
			reportItem.setRoom(rs.getString(9));
			reportItem.setAddress(rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), 
					rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18));
			reportItem.setReferencePoint(rs.getString(19));
			reportItem.setCity(rs.getString(20));
			reportItem.setState(rs.getString(21));
			reportItem.setHomeNumber(rs.getString(22));
			reportItem.setOfficeNumber(rs.getString(23));
			reportItem.setMobileNumber(rs.getString(24));
			reportItem.setFaxNumber(rs.getString(25));
			reportItem.setEmail(rs.getString(26));
			
			list.add(reportItem);
		}
		
		rs.close();
		sta.close();
		
		return list;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}

	public Integer getStatusId() {
		return statusId;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState() {
		return state;
	}

}
