<?xml version="1.0"?>
<xsl:stylesheet xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:default="http://www.w3.org/1999/xhtml" xmlns:txs="http://www.agencexml.com/txs" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:ajx="http://www.ajaxforms.net/2006/ajx" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:exslt="http://exslt.org/common" version="1.0" exclude-result-prefixes="xhtml xforms ev exslt msxsl">
	<xsl:output method="html" indent="yes" version="4.0"/>
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="cc.css"/>
			</head>
			<body>
				<h1>CONTRACT</h1>
				Ricardian <a href="http://www.systemics.com/docs/ricardo/issuer/contract.html">contract</a><br/>
				INTERNET-DRAFT Ko Fujimura XML Voucher:  <a href="http://tools.ietf.org/html/draft-ietf-trade-voucher-lang-07">Generic Voucher Language</a>
				<hr/>
				<table class="grid">
					<tbody>
						<tr>
							<th>Title</th>
							<th>Total</th>
							<th>Contract URL</th>
						</tr>
						<tr>
							<td>
								<b>
									<xsl:value-of select="contract/Title"/>
								</b>
							</td>
							<td>
								<b>
									<xsl:value-of select="contract/Total"/>
								</b>
							</td>
							<td>
								<xsl:value-of select="contract/contractURL"/>
							</td>
						</tr>
						<tr>
							<th>Currency</th>
							<th>Description</th>
							<th>Logo</th>
						</tr>
						<tr>
							<td>
								<s>
									<b>
										<xsl:value-of select="contract/Currency/currencyName"/>
									</b>
								</s>
							</td>
							<td>
								<xsl:value-of select="contract/Currency/currencyLongName"/>
							</td>
							<td>
								<img src="{contract/Currency/currencyLogo}" height="50"/>
							</td>
						</tr>
						<tr>
							<th>valid from</th>
							<th>to</th>
							<th>EAN13</th>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="contract/ValidPeriod/start"/>
							</td>
							<td>
								<xsl:value-of select="contract/ValidPeriod/end"/>
							</td>
							<td>
								<xsl:value-of select="contract/contractEan13Number"/>
							</td>
						</tr>
					</tbody>
				</table>
				<hr/>
				<h2>Insula</h2>
				<xsl:apply-templates select="contract/Insula"/>
				<hr/>
				<h2>Legal Issuer</h2>
				<xsl:apply-templates select="contract/legalIssuer/holder"/>
				<br/>
				<table class="grid">
					<tbody>
						<tr>
							<th>issue date</th><td><xsl:value-of select="contract/ValidPeriod/issueDate"/></td>
						</tr>
						<tr>
							<th>issue series number</th><td><xsl:value-of select="contract/legalIssuer/number"/></td>
						</tr>
						<tr>
							<th>shares</th><td><xsl:value-of select="contract/legalIssuer/share/percent"/></td>
						</tr>
						<tr>
							<th>total value of goods</th><td><xsl:value-of select="contract/legalIssuer/share/resultingFixed"/></td>
						</tr>
					</tbody>
				</table>
				<hr/>
				<h2>HOLDERS Participations</h2>
				<h3>Transfers to HOLDERS Electronic Accounts</h3>	
------------------- THIS PART IS NOT PUBLIC, IT IS ONLY VISIBLE AT INSULA PRIVATE ELECTRONIC WALLETS -------------------<br/>
<table class="grid">
					<tbody>
						<tr>
							<th></th><th>serial number</th><th>percent</th><th>value</th><th>currency</th><th>type</th><th>name</th><th>citizensID</th><th>BitCoin account</th>
						</tr>
	<xsl:for-each select="contract/legalIssuer/participation">
									<xsl:if test="holder/@kind= 'account'">					
						<tr>
							<td><i>From Issuer</i></td><td><xsl:value-of select="number"/></td><td><xsl:value-of select="share/percent"/></td><td><xsl:value-of select="share/resultingFixed"/></td><td><s><xsl:value-of select="../../Currency/currencyName"/></s></td><td><xsl:value-of select="holder/@kind"/></td><td><xsl:value-of select="holder/name"/></td><td><xsl:value-of select="holder/citizensID"/></td><td><xsl:value-of select="holder/BitCoinAddress"/></td>
						</tr>
						<xsl:for-each select="participation">
						<tr class="red">
							<td><i>Split level 1</i></td><td><xsl:value-of select="number"/></td><td><xsl:value-of select="share/percent"/></td><td><xsl:value-of select="share/resultingFixed"/></td><td><s><xsl:value-of select="../../../Currency/currencyName"/></s></td><td><xsl:value-of select="holder/@kind"/></td><td><xsl:value-of select="holder/name"/></td><td><xsl:value-of select="holder/citizensID"/></td><td><xsl:value-of select="holder/BitCoinAddress"/></td>
						</tr>
					<xsl:for-each select="participation">
						<tr class="brown">
							<td><i>Split level 2</i></td><td><xsl:value-of select="number"/></td><td><xsl:value-of select="share/percent"/></td><td><xsl:value-of select="share/resultingFixed"/></td><td><s><xsl:value-of select="../../../../Currency/currencyName"/></s></td><td><xsl:value-of select="holder/@kind"/></td><td><xsl:value-of select="holder/name"/></td><td><xsl:value-of select="holder/citizensID"/></td><td><xsl:value-of select="holder/BitCoinAddress"/></td>
						</tr>
						</xsl:for-each>
						</xsl:for-each>
						</xsl:if>
	</xsl:for-each>
					</tbody>
				</table>
				<br/>
				<table class="grid">
					<tbody>
						<tr>
							<th>Total transfers to accounts</th><td><xsl:value-of select="round(sum(contract/legalIssuer/participation[holder/@kind='account']/share/resultingFixed))"/></td><td><s><xsl:value-of select="contract/Currency/currencyName"/></s></td>
						</tr>
					</tbody>
				</table>
------------------- END NOT PUBLIC PART -------------------<br/>
				<h3>Transfers to Printed Vouchers as HOLDERS</h3>
				<table class="grid">
					<tbody>
						<tr>
							<th></th><th>serial number</th><th>percent</th><th>value</th><th>currency</th><th>type</th><th>name</th><th>series</th><th>BitCoin account</th>
						</tr>
	<xsl:for-each select="contract/legalIssuer/participation">
									<xsl:if test="holder/@kind= 'voucher'">					
						<tr>
							<td><i>From Issuer</i></td><td><xsl:value-of select="number"/></td><td><xsl:value-of select="share/percent"/></td><td><xsl:value-of select="share/resultingFixed"/></td><td><s><xsl:value-of select="../../Currency/currencyName"/></s></td><td><xsl:value-of select="holder/@kind"/></td><td><xsl:value-of select="holder/name"/></td><td><xsl:value-of select="holder/citizensID"/></td><td><xsl:value-of select="holder/BitCoinAddress"/></td>
						</tr>
						</xsl:if>
	</xsl:for-each>
					</tbody>
				</table>
				<br/>
				<table class="grid">
					<tbody>
						<tr>
							<th>Total transfers to vouchers</th><td><xsl:value-of select="round(sum(contract/legalIssuer/participation[holder/@kind='voucher']/share/resultingFixed))"/></td><td><s><xsl:value-of select="contract/Currency/currencyName"/></s></td>
						</tr>
						<tr>
						<th>TOTAL TRANSFERS</th><td><xsl:value-of select="round(sum(contract/legalIssuer/participation/share/resultingFixed))"/></td><td><s><xsl:value-of select="contract/Currency/currencyName"/></s></td>
						</tr>						
					</tbody>
				</table>
				<hr/>
				<h2>Definitons and Conditions</h2>
				<h3>Definitions</h3>
				<table class="grid">
					<tbody>
						<xsl:for-each select="contract/Definitions">
							<tr>
								<th>
									<xsl:value-of select="@name"/>
								</th>
								<td>
									<xsl:value-of select="."/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<h3>Conditions</h3>
				<table class="grid">
					<tbody>
						<xsl:for-each select="contract/Conditions">
							<tr>
								<th>
									<xsl:value-of select="@name"/>
								</th>
								<td>
									<xsl:value-of select="."/>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
				<hr/>
				<h2>Merchandises</h2>
				<table class="grid">
					<tbody>
						<tr>
							<td>
							<h3>Included</h3>
							<table class="grid">
								<tbody>
								<xsl:for-each select="contract/Merchandise">
									<xsl:if test="@included = 'true'">
									<tr><td><xsl:value-of select="."/></td><td><img src="{@pictureURL}" style="border:3px solid green"  height="100" /></td></tr>
									</xsl:if>
								</xsl:for-each>
								</tbody>
							</table>
							</td>
							<td>
							<h3>Excluded</h3>
														<table class="grid">
								<tbody>
								<xsl:for-each select="contract/Merchandise">
									<xsl:if test="@included = 'false'">
									<tr><td><xsl:value-of select="."/></td><td><img src="{@pictureURL}" style="border:3px solid red" height="100" /></td></tr>
									</xsl:if>
								</xsl:for-each>
								</tbody>
							</table>
							</td>
						</tr>
					</tbody>
				</table>
<hr/>
<h2>Collectors</h2>
<xsl:for-each select="contract/Collector">
<xsl:apply-templates select="."/>
</xsl:for-each>
<hr/>
				<h2>Transactions provider</h2>
				<xsl:apply-templates select="contract/vtsProvider/provider"/>
				<hr/>
				<h2>Technical issuer</h2>
				<xsl:apply-templates select="contract/techIssuer"/>

			</body>
		</html>
	</xsl:template>
	<xsl:template match="*">
		<table class="grid">
			<tbody>
				<tr>
					<td width="500px">
						<table width="495px">
							<tbody>
								<tr>
									<td>
										<b>name</b>
									</td>
									<td>
										<xsl:value-of select="name"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>long name</b>
									</td>
									<td>
										<xsl:value-of select="long_name"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>address</b>
									</td>
									<td>
										<xsl:value-of select="address"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>country</b>
									</td>
									<td>
										<xsl:value-of select="country"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>email</b>
									</td>
									<td>
										<a href="mailto:{email}">
											<xsl:value-of select="email"/>
										</a>
									</td>
								</tr>
								<tr>
									<td>
										<b>url</b>
									</td>
									<td>
										<a href="{url}">
											<xsl:value-of select="url"/>
										</a>
									</td>
								</tr>
								<tr>
									<td>
										<b>logo</b>
									</td>
									<td>
										<xsl:value-of select="logo"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>citizensID</b>
									</td>
									<td>
										<xsl:value-of select="citizensID"/>
									</td>
								</tr>
								<tr>
									<td>
										<b>BitCoinAddress</b>
									</td>
									<td>
										<xsl:value-of select="BitCoinAddress"/>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
					<td>
						<table>
							<tbody>
								<tr>
									<td>
										<img src="http://chart.apis.google.com/chart?cht=qr&amp;chs=100x100&amp;chl={BitCoinAddress}&amp;chld=H|0"/>
									</td>
									<td>
										<img src="{logo}" width="150"/>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet>
