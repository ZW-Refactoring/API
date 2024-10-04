package com.zero.activity;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class UserReportVO {

	private int repId; // pk
	private int stsId; // activity state no
	private String reporter; //reporter
	private String reason; // report reason
	private int repResult; // result
	private Timestamp sdate; // start report
	private Timestamp edate; // end report

}
