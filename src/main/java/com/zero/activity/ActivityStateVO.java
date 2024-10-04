package com.zero.activity;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ActivityStateVO {
	private int actId;
	private int stateId;
	private String actName;
	private String userid;
	private int state;
	private String stateName;
	private Timestamp startDate;
	private Timestamp endDate;
	private String ctfcFilename;
	private String timeLeft; //추가된 필드
}
