package kr.or.ddit.vo.member;

import lombok.Data;

@Data
public class PeopleAdminVO {

	private String username;
	private String password;
	private String peoEnabled;
	private String userTypeCode;
	private String peoFirstNm;
	private String peoLastNm;
	private String peoEmail;
	private String peoGender;
	private String peoPhone;
	private String fullName;
	private String peoName;

	public String getFullName() {
        StringBuilder fullNameBuilder = new StringBuilder();
        boolean hasLastName = (this.peoLastNm != null && !this.peoLastNm.trim().isEmpty());
        boolean hasFirstName = (this.peoFirstNm != null && !this.peoFirstNm.trim().isEmpty());

        if (hasLastName) {
            fullNameBuilder.append(this.peoLastNm.trim());
        }

        if (hasFirstName) {
            fullNameBuilder.append(this.peoFirstNm.trim());
        }

        return fullNameBuilder.toString();
    }
	
	public String getPeoName() {
		
		boolean hasLastName = (this.peoLastNm != null && !this.peoLastNm.trim().isEmpty());
        boolean hasFirstName = (this.peoFirstNm != null && !this.peoFirstNm.trim().isEmpty());
		
        String name = "";
        
        if(hasLastName && hasFirstName) {
        	name = this.peoLastNm + this.peoFirstNm;
        }
        
		return name;
	}
	
	

}

