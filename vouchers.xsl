<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xhtml xsl xs">
<xsl:output method="html" indent="yes" version="4.0"/>
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="cc.css"/>
			</head>
			<body>
			<h1>paper printed vouchers</h1>
			<hr/>
			<xsl:for-each select="contract/legalIssuer/participation">
			<xsl:if test="holder/@kind= 'voucher'">
				<table border="1" cellpadding="2" cellspacing="2" width="600">
					<tr>
						<td align="center">
							<img src="{../../Insula/logo}" height="30"/>
						</td>
						<td colspan="4" align="center">
							<font class="small">
								ISSUER 								
							<b>
									<xsl:value-of select="../../legalIssuer/holder/name"/>
								</b>
								, 
								<xsl:value-of select="../../legalIssuer/holder/long_name"/>, 
								 ID 								 
									<b><xsl:value-of select="../../legalIssuer/holder/citizensID"/></b>
								<br/>
								 INSULA 								
									<b><xsl:value-of select="../../Insula/name"/></b>
								, 
								<xsl:value-of select="../../Insula/long_name"/>,
								COUNTRY 								
									<b><xsl:value-of select="../../Insula/country"/></b>
							</font>
						</td>
						<td align="center">
							<img src="{../../Insula/logo}" height="30"/>
						</td>
					</tr>
					<tr>
						<td rowspan="3" align="center">
							<img src="http://t2.gstatic.com/images?q=tbn:ANd9GcTctSmjiUX7YQ-6G7vTlfSWyYOa-a3xnIyXF4c1o0U8MEPLcQ7E5uQWcYI"/>
						</td>
						<td colspan="4" bgcolor="white" align="right">
									Serial Number 
								<b><xsl:value-of select="number"/></b>
							<br/>
							<font class="small">
								Valid from 
									<xsl:value-of select="../../ValidPeriod/start"/>
								 to 
									<xsl:value-of select="../../ValidPeriod/end"/>
							
							<br/>
							BitCoinAddress  <xsl:value-of select="holder/BitCoinAddress"/>
</font>
						</td>
						<td rowspan="3" bgcolor="white" valign="top">
							<font class="small">
							HOLDERS<br/>
							signatures<br/>
							</font>
						</td>
					</tr>
					<tr>
						<td rowspan="2">
							<img src="http://chart.apis.google.com/chart?cht=qr&amp;chs=150x150&amp;chl={share/resultingFixed}   {../../Currency/currencyName}  Nr {number} {../../contractURL} {holder/BitCoinAddress}&amp;chld=H|0" />
						</td>
						<td colspan="2" align="center" valign="middle" >
							<font class="redbold">
								<xsl:value-of select="share/resultingFixed"/> - 
								<s><xsl:value-of select="../../Currency/currencyName"/></s>
							</font>
							</td>
							<td align="center">
							<img src="{../../Currency/currencyLogo}" width="100"/>
						</td>
					</tr>
					<tr>
						<td bgcolor="white" valign="top">
							<font class="small">
								<b>Included: </b>
								<xsl:for-each select="../../Merchandise">
									<xsl:if test="@included = 'true'">
										<i>
											<xsl:value-of select="."/>|
										</i>
									</xsl:if>
								</xsl:for-each>
							</font>
						</td>
						<td bgcolor="white" valign="top">
							<font class="small">
								<b>Excluded: </b>
								<xsl:for-each select="../../Merchandise">
									<xsl:if test="@included = 'false'">
										<i>
											<xsl:value-of select="."/>|
										</i>
									</xsl:if>
								</xsl:for-each>
							</font>
						</td>
						<td bgcolor="white" valign="top">
							<font class="small">
								<b>Collectors: </b>
								<xsl:for-each select="../../Collector">
									<i>
										<xsl:value-of select="name"/>|
									</i>
								</xsl:for-each>
							</font>
						</td>
					</tr>
					<tr>
						<td>
							<img src="{../../Insula/logo}" height="30"/>
						</td>
						<td colspan="4" align="center">
							<font class="small">
							Contract: 
								<a href="{../../contractURL}">
									<xsl:value-of select="../../contractURL"/>
								</a>
								<br/>
				Issued by <b><xsl:value-of select="../../legalIssuer/holder/name"/></b> on <xsl:value-of select="../../ValidPeriod/issueDate" />
							</font>
						</td>
						<td align="center">
							<img src="{../../Insula/logo}" height="30"/>
						</td>
					</tr>
				</table>
				<hr/>
				</xsl:if>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
