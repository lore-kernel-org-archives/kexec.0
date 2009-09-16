Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from az33egw02.freescale.net ([192.88.158.103])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Mnkr8-0003cX-30
	for kexec@lists.infradead.org; Wed, 16 Sep 2009 03:07:00 +0000
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8G36dKS007470
	for <kexec@lists.infradead.org>; Tue, 15 Sep 2009 20:06:39 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n8G38a3a016407
	for <kexec@lists.infradead.org>; Tue, 15 Sep 2009 22:08:37 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: How to build the kexec too for ARM11 using the cross compiler.
Date: Wed, 16 Sep 2009 11:06:34 +0800
Message-ID: <E99B4DCB8B5A0241832DBF4FCB7C813A7D0280@zch01exm27.fsl.freescale.net>
From: "Lai Weilin-B04597" <B04597@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0126817631=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.

--===============0126817631==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA367A.B37D792A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA367A.B37D792A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,
I am trying to build kexec tool for ARM11.  I can't see any doc that
helps to configure. The cross compiler is used, and I tried the
following configure option,=20
./configure arm --prefix=3D/usr --build=3Darm-none-linux-gnueabi
--host=3Di686-pc-linux-gnu --target=3Darm-none-linux-gnueabi
but failed.
Anyone can help ?
=20
=20
William Lai
021-28937152
15921256383
=20

------_=_NextPart_001_01CA367A.B37D792A
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.18702"></HEAD>
<BODY>
<DIV><FONT face=3D"Bookman Old Style">Hi,</FONT></DIV>
<DIV><SPAN class=3D180365802-16092009><FONT face=3D"Bookman Old Style">I =
am trying=20
to build kexec tool for ARM11.&nbsp;&nbsp;I can't see any doc that helps =
to=20
configure. The cross compiler is used, and I tried the =
following&nbsp;configure=20
option, </FONT></SPAN></DIV>
<DIV><STRONG>./configure arm --prefix=3D/usr =
--build=3Darm-none-linux-gnueabi=20
--host=3Di686-pc-linux-gnu =
--target=3Darm-none-linux-gnueabi</STRONG></DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><SPAN class=3D180365802-16092009><FONT=20
face=3D"Bookman Old Style">but failed.</FONT></SPAN></DIV>
<DIV align=3Dleft><SPAN class=3D180365802-16092009><FONT=20
face=3D"Bookman Old Style">Anyone can help ?</FONT></SPAN></DIV>
<DIV align=3Dleft><STRONG></STRONG>&nbsp;</DIV>
<DIV align=3Dleft><STRONG></STRONG>&nbsp;</DIV>
<DIV align=3Dleft><STRONG>William Lai</STRONG></DIV>
<DIV align=3Dleft><STRONG>021-28937152</STRONG></DIV>
<DIV align=3Dleft><STRONG>15921256383</STRONG></DIV>
<DIV align=3Dleft><SPAN=20
style=3D"FONT-FAMILY: 'Albertus Extra Bold'; FONT-SIZE: 10pt; =
mso-bidi-font-size: 7.5pt; mso-bidi-font-family: Arial"><SPAN=20
style=3D"FONT-FAMILY: 'Albertus Extra Bold'; FONT-SIZE: 10pt; =
mso-bidi-font-size: 7.5pt; mso-bidi-font-family: =
Arial"></SPAN></SPAN></DIV></DIV>
<DIV><FONT face=3D"Bookman Old Style"></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01CA367A.B37D792A--


--===============0126817631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0126817631==--

