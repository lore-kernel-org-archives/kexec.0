Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xgate.elsag.it ([151.89.15.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JKJtP-0000Gz-W6
	for kexec@lists.infradead.org; Wed, 30 Jan 2008 20:50:54 +0000
Received: from elgasmtp01.elsag.it ([172.19.5.43])
	by xgate.elsag.it (8.13.6-Elsag/8.13.6) with ESMTP id m0UIbkUo007074
	for <kexec@lists.infradead.org>; Wed, 30 Jan 2008 19:37:46 +0100 (MET)
Received: from els00wmx04.elsag.it (localhost [127.0.0.1])
	by elgasmtp01.elsag.it (8.12.10-Elsag/8.12.10) with ESMTP id
	m0UIXm5D029725
	for <kexec@lists.infradead.org>; Wed, 30 Jan 2008 19:33:49 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: kexec problem on SH platform
Date: Wed, 30 Jan 2008 19:33:13 +0100
Message-ID: <C103D39FF74DF4469EEAE6D38AA9E0B5D529A3@els00wmx04.elsag.it>
From: "Cortesi Paolo" <Paolo.Cortesi@elsagdatamat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1012925237=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Pampolini Matteo <matteo.pampolini@elsagdatamat.com>

--===============1012925237==
Content-class: urn:content-classes:message
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>kexec problem on SH platform</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
my name is Paolo Cortesi. I'am working over one SH4 platform board =
ST71XX with linux kernel 2.6.17.<BR>
<BR>
I need to spawn a new Linux kernel over the Linux Kernel which is =
running, without the overhead of boot firmware, and I think that your =
kexec-tool could be suitable for this target.<BR>
<BR>
I try to use kexec following the steps:<BR>
<BR>
1) I select the CONFIG_KEXEC option while building the runnig =
kernel.<BR>
<BR>
2) I download your last recent version of kexec-tool which support SH4 =
platform<BR>
<BR>
&nbsp;&nbsp; I used your .gz reachable by link:&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp; <A =
HREF=3D"http://www.vergenet.net/linux/kexec/kexec-tools/">http://www.verg=
enet.net/linux/kexec/kexec-tools/</A><BR>
<BR>
3) I launch the the configure by my script:<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; export =
CC=3Dsh4-linux-uclibc-gcc<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; export =
LD=3Dsh4-linux-uclibc-ld<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; export =
AR=3Dsh4-linux-uclibc-ar<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; export =
CFLAGS=3D&quot;-DSHLINUX -D__SHLINUX__ -Wall -O2 -ml -m4 -pipe =
-fomit-frame-pointer -fno-strict-aliasing&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./configure =
--host=3Dsh4-linux<BR>
<BR>
4) I cross compile. During compilation I comment the invoke of =
/*crash_setup_regs(&amp;fixed_regs, regs);*/ procedure that's called in =
crash_kexec procedure of kernel/kexec.c file (I could not find any =
implementation of this procedure).<BR>
<BR>
5) I launch the runnig kernel, which execute:<BR>
&nbsp;&nbsp; kexec -l &lt;new_zImage&gt; --type=3DzImage-sh =
--append=3D&quot;command_line&quot;<BR>
&nbsp;&nbsp; kexec -e<BR>
<BR>
Should be the wright procedure.<BR>
<BR>
But I have one NULL pointer deferenced when it=B4s called the last =
assembler procedure reboot_code_buffer (relocate_new_kernel) which is =
invoked in the kernel C procedure arch/sh/... machine_kexec.c<BR>
<BR>
Have you got an idea of the problem? Have you ever used your tool using =
one intrd kernel running<BR>
<BR>
Thanks in advance.<BR>
<BR>
Paolo Cortesi.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>


--===============1012925237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1012925237==--
