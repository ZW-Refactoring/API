package com.zero.admin;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReportVO {

	private int repId; // pk
	private int stsId; // activity no
	private String reporter; //reporter
	private String reason; // report reason
	private int repResult; // result
	private Timestamp sdate; // start report
	private Timestamp edate; // end report
	private int stateId; // join stateId;
	private String userid; // join activity
	private int state;
	private String ctfcFilename; // join activity
}
