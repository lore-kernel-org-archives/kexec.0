Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from byebye.mdh.se ([130.243.85.101])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Nw9AQ-0004Pv-T8
	for kexec@lists.infradead.org; Mon, 29 Mar 2010 07:13:51 +0000
Received: from dahlsten.mdh.se (dahlsten.mdh.se [130.243.76.148])
	by byebye.mdh.se (8.12.11/8.12.11/Debian-5) with ESMTP id
	o2T7Dd9T008027
	for <kexec@lists.infradead.org>; Mon, 29 Mar 2010 09:13:39 +0200
Received: from f-brevik.mdh.local (f-brevik.ita.mdh.se [130.243.82.49])
	by dahlsten.mdh.se (8.14.1/8.14.1) with ESMTP id o2T7DbvN014044
	for <kexec@lists.infradead.org>;
	Mon, 29 Mar 2010 09:13:37 +0200 (MET DST)
From: =?iso-8859-1?Q?Daniel_Flemstr=F6m?= <daniel.flemstrom@mdh.se>
Date: Mon, 29 Mar 2010 09:13:36 +0200
Subject: Anyone working on kexec for embedded powerpc?
Message-ID: <C7D61FBF.6C26%daniel.flemstrom@mdh.se>
In-Reply-To: <4BABC8EC.10108@bwalle.de>
Content-Language: en
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1933293878=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

--===============1933293878==
Content-Language: en
Content-Type: multipart/alternative;
	boundary="_000_C7D61FBF6C26danielflemstrommdhse_"

--_000_C7D61FBF6C26danielflemstrommdhse_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all!
I have a mpc8641 hpcn board which i want to run kexec on and also do some r=
esearch on software restart.
I think kexec is an excellent idea for embedded systems where you want to h=
ave quick restarts, but currently I can only see ppc gamecube support.

Somewhere i saw that Benjamin Herrenschmidt had plans, but it was a rather =
old message. Have anyone done any work with this for powerpc?
Otherwise i intend do start some work to port it to the powerpc platform(if=
 possible).
I guess that the powerpc usage of device tree instead of the "blob" might b=
e the biggest issue?

Is this the correct place for these discussions?


/Daniel Flemstr=F6m
SE research department
M=E4lardalen University



--_000_C7D61FBF6C26danielflemstrommdhse_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Anyone working on kexec for embedded powerpc?</TITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:=
11pt'>Hi all!<BR>
I have a mpc8641 hpcn board which i want to run kexec on and also do some r=
esearch on software restart.<BR>
I think kexec is an excellent idea for embedded systems where you want to h=
ave quick restarts, but currently I can only see ppc gamecube support. <BR>
<BR>
Somewhere i saw that Benjamin Herrenschmidt had plans, but it was a rather =
old message. Have anyone done any work with this for powerpc?<BR>
Otherwise i intend do start some work to port it to the powerpc platform(if=
 possible).<BR>
I guess that the powerpc usage of device tree instead of the &#8220;blob&#8=
221; might be the biggest issue?<BR>
<BR>
Is this the correct place for these discussions? <BR>
<BR>
<BR>
/Daniel Flemstr&ouml;m<BR>
SE research department<BR>
M&auml;lardalen University<BR>
<BR>
&nbsp;</SPAN></FONT>
</BODY>
</HTML>


--_000_C7D61FBF6C26danielflemstrommdhse_--


--===============1933293878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1933293878==--

