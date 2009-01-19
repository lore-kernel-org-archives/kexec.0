Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LOxNQ-0004Jk-E7
	for kexec@lists.infradead.org; Mon, 19 Jan 2009 16:53:43 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n0JGrEPY024273
	for <kexec@lists.infradead.org>; Mon, 19 Jan 2009 08:53:14 -0800
Received: from xbh-sjc-221.amer.cisco.com (xbh-sjc-221.cisco.com
	[128.107.191.63])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id n0JGrEdp002695
	for <kexec@lists.infradead.org>; Mon, 19 Jan 2009 16:53:14 GMT
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: kexec -l takes long time
Date: Mon, 19 Jan 2009 08:53:13 -0800
Message-ID: <F795765B112E7344AF36AA911279641509075A23@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0207845818=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.

--===============0207845818==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C97A56.6B48675A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C97A56.6B48675A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I have recently started using kexec in our environment. One thing that I
have noticed, the command:

"kexec -l bzImage -append=3D"`cat /proc/cmdline`"

Takes about 20 seconds to finish, is this normal? If not what might be
the issue?

=20

Many thanks in advance,

Bizhan


------_=_NextPart_001_01C97A56.6B48675A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have recently started using kexec in our =
environment. One
thing that I have noticed, the command:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&#8220;kexec &#8211;l bzImage =
&#8211;append=3D&#8221;`cat
/proc/cmdline`&#8221;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Takes about 20 seconds to finish, is this normal? If =
not
what might be the issue?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Many thanks in advance,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Bizhan<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C97A56.6B48675A--


--===============0207845818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0207845818==--

