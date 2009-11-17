Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NADzJ-0003Xs-Ka
	for kexec@lists.infradead.org; Tue, 17 Nov 2009 02:40:18 +0000
Received: by pwi12 with SMTP id 12so3943547pwi.2
	for <kexec@lists.infradead.org>; Mon, 16 Nov 2009 18:40:11 -0800 (PST)
Date: Tue, 17 Nov 2009 10:40:02 +0800
From: "fly.limin" <fly.limin@gmail.com>
Subject: Fast reboot from linux to Xen hypervisor with kexec
Message-ID: <200911171040002189644@gmail.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0893472517=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec <kexec@lists.infradead.org>


This is a multi-part message in MIME format.

--===============0893472517==
Content-Type: multipart/alternative;
	boundary="=====003_Dragon262344378088_====="


This is a multi-part message in MIME format.

--=====003_Dragon262344378088_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi:
   recently i am researching fast boot from linux kernel to Xen hypervisor, it means when linux is running on the real machine, i just want to switch to Xen hypervisor without going through bootloader. both linux and dom0 of Xen using the same filesystem. since we boot Xen with the following command in grub:

 title Xen 3.1.0 / XenLinux 2.6.18
      kernel /boot/xen-3.gz
      module /boot/vmlinuz-2.6.18-xen ro root=LABEL=/ rhgb quiet
      module /boot/initrd-2.6.18-xen.img 
it's different from linux, but i think there are something in common.
so is there any suggestions for me! 

2009-11-17 



Min Li
School of Computer Science and Technology 
Cluster and Grid Computing Lab 
Services Computing Technology and System Lab 
Huazhong University of Science and Technology 
Wuhan, 430074, China 
Tel: +86-139-8625-1431 
Email: fly.limin@gmail.com

--=====003_Dragon262344378088_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<STYLE type=text/css>@import url( C:\Documents and Settings\Administrator\Local Settings\Temporary Internet Files\scrollbar.css );
</STYLE>

<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META name=GENERATOR content="MSHTML 8.00.6001.18852"><LINK rel=stylesheet 
href="BLOCKQUOTE{margin-Top: 0px; margin-Bottom: 0px; margin-Left: 2em}"></HEAD>
<BODY style="MARGIN: 10px; FONT-FAMILY: verdana; FONT-SIZE: 10pt">
<DIV><FONT size=2 face=Verdana>Hi:<BR>&nbsp;&nbsp; recently i am researching 
fast boot from linux kernel to Xen hypervisor, it means when linux is running on 
the real machine, i just want to switch to Xen hypervisor without going through 
bootloader. both linux and dom0 of Xen using the same filesystem. since we boot 
Xen with the following command in grub:</DIV>
<DIV>
<P><BR>&nbsp;title Xen 3.1.0 / XenLinux 2.6.18<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
kernel /boot/xen-3.gz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module 
/boot/vmlinuz-2.6.18-xen ro root=LABEL=/ rhgb 
quiet<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; module /boot/initrd-2.6.18-xen.img </P>
<P>it's different from linux, but i think there are something in common.<BR>so 
is there any suggestions for me! <BR></P></FONT></DIV>
<DIV align=left><FONT color=#c0c0c0 size=2 face=Verdana>2009-11-17 
</FONT></DIV><FONT size=2 face=Verdana>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT color=#c0c0c0 size=2 face=Verdana><SPAN>
<DIV>
<DIV>Min Li<BR>School of Computer Science and Technology <BR>Cluster and Grid 
Computing Lab <BR>Services Computing Technology and System Lab <BR>Huazhong 
University of Science and Technology <BR>Wuhan, 430074, China <BR>Tel: 
+86-139-8625-1431 <BR>Email: 
fly.limin@gmail.com</DIV></DIV></SPAN></FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon262344378088_=====--



--===============0893472517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0893472517==--


