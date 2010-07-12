Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bay0-omc3-s19.bay0.hotmail.com ([65.54.190.157])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OYSTY-0003KN-NP
	for kexec@lists.infradead.org; Mon, 12 Jul 2010 23:31:53 +0000
Message-ID: <BAY157-w54278284B21FED4E234976D4B80@phx.gbl>
From: Brian Cockrell <bjcockrell@hotmail.com>
Subject: kexec -l could not find a free area of memory locate_hole failed
Date: Mon, 12 Jul 2010 23:31:50 +0000
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2117209176=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============2117209176==
Content-Type: multipart/alternative;
	boundary="_f9126ea9-5372-486c-8a31-e802abd2f44a_"

--_f9126ea9-5372-486c-8a31-e802abd2f44a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I received the message "Could not find a free area of memory of 21b1a000 by=
tes...Locate_hole failed" while attempting to perform a kexec-l on an image=
 file of approximately 550mb.  Hardware is x86 with 4GB memory.  Kernel is =
2.6.34 and booted via Livecd.  free is showing 3047324kb free memory availa=
ble.  Dmesg is showing nothing.  I am able to boot a 400mb image. Suggested=
 debug steps?
 		 	   		 =20
_________________________________________________________________
The New Busy is not the old busy. Search=2C chat and e-mail from your inbox=
.
http://www.windowslive.com/campaign/thenewbusy?ocid=3DPID28326::T:WLMTAGL:O=
N:WL:en-US:WM_HMP:042010_3=

--_f9126ea9-5372-486c-8a31-e802abd2f44a_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
I received the message "Could not find a free area of memory of 21b1a000 by=
tes...Locate_hole failed" while attempting to perform a kexec-l on an image=
 file of approximately 550mb.&nbsp=3B Hardware is x86 with 4GB memory.&nbsp=
=3B Kernel is 2.6.34 and booted via Livecd.&nbsp=3B free is showing 3047324=
kb free memory available.&nbsp=3B Dmesg is showing nothing.&nbsp=3B I am ab=
le to boot a 400mb image. Suggested debug steps?<br> 		 	   		  <br /><hr /=
>The New Busy is not the old busy. Search=2C chat and e-mail from your inbo=
x. <a href=3D'http://www.windowslive.com/campaign/thenewbusy?ocid=3DPID2832=
6::T:WLMTAGL:ON:WL:en-US:WM_HMP:042010_3' target=3D'_new'>Get started.</a><=
/body>
</html>=

--_f9126ea9-5372-486c-8a31-e802abd2f44a_--


--===============2117209176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2117209176==--

