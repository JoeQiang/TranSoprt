<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns="http://www.w3.org/TR/REC-html40">
<%
	response.setContentType("application/vnd.ms-excel");
	response.addHeader("Content-Disposition",
			"inline;filename=excel导出测试.xls");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link rel=File-List href="订单统计.files/filelist.xml">
<style id="订单统计_4616_Styles">
<!--
table {
	border: 1px solid black; mso-displayed-decimal-separator : "\.";
	mso-displayed-thousand-separator: "\,";
	mso-displayed-decimal-separator: "\.";
}

.font54616 {
	color: windowtext;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.xl154616 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: black;
	font-size: 11.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl634616 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: black;
	font-size: 11.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: "0_\)\;\\\(0\\\)";
	text-align: general;
	vertical-align: bottom;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

ruby {
	ruby-align: left;
}

rt {
	color: windowtext;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-char-type: none;
}
-->
</style>
</head>

<body>
	<!--[if !excel]>　　<![endif]-->
	<!--下列信息由 Microsoft Excel 的发布为网页向导生成。-->
	<!--如果同一条目从 Excel 中重新发布，则所有位于 DIV 标记之间的信息均将被替换。-->
	<!----------------------------->
	<!--“从 EXCEL 发布网页”向导开始-->
	<!----------------------------->

	<div id="订单统计_4616" align=center x:publishsource="Excel">

		<table border=0 cellpadding=0 cellspacing=0 width=1152
			style='border-collapse:
 collapse;table-layout:fixed;width:864pt'>
			<col width=72 style='width:54pt'>
			<col class=xl634616 width=144
				style='mso-width-source:userset;mso-width-alt:
 4608;width:108pt'>
			<col width=72 span=4 style='width:54pt'>
			<col width=144 span=2
				style='mso-width-source:userset;mso-width-alt:4608;
 width:108pt'>
			<col width=72 style='width:54pt'>
			<col width=144 span=2
				style='mso-width-source:userset;mso-width-alt:4608;
 width:108pt'>
			<tr height=18 style='height:13.5pt'>
				<td height=18 class=xl154616 width=72
					style='height:13.5pt;width:54pt'>经销商</td>
				<td class=xl634616 width=144 style='width:108pt'>电话号码</td>
				<td class=xl154616 width=72 style='width:54pt'>详细地址</td>
				<td class=xl154616 width=72 style='width:54pt'>货品数量</td>
				<td class=xl154616 width=72 style='width:54pt'>货品品类</td>
				<td class=xl154616 width=72 style='width:54pt'>货品规格</td>
				<td class=xl154616 width=144 style='width:108pt'>下单时间</td>
				<td class=xl154616 width=144 style='width:108pt'>发货时间</td>
				<td class=xl154616 width=72 style='width:54pt'>发货厂家</td>
				<td class=xl154616 width=144 style='width:108pt'>发货后规定到达时间</td>
				<td class=xl154616 width=144 style='width:108pt'>到货时间</td>
			</tr>
			<tr height=0 style='display:none'>
				<td width=72 style='width:54pt'>1</td>
				<td width=144 style='width:108pt'>2</td>
				<td width=72 style='width:54pt'>3</td>
				<td width=72 style='width:54pt'>4</td>
				<td width=72 style='width:54pt'>5</td>
				<td width=72 style='width:54pt'>9</td>
				<td width=144 style='width:108pt'>6</td>
				<td width=144 style='width:108pt'>12</td>
				<td width=72 style='width:54pt'>212</td>
				<td width=144 style='width:108pt'>21</td>
				<td width=144 style='width:108pt'>21</td>
			</tr>
		</table>

	</div>


	<!----------------------------->
	<!--“从 EXCEL 发布网页”向导结束-->
	<!----------------------------->
</body>

</html>
