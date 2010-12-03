Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1POYGq-0005SU-92
	for kexec@lists.infradead.org; Fri, 03 Dec 2010 16:14:06 +0000
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id DBDC738B86
	for <kexec@lists.infradead.org>; Fri,  3 Dec 2010 16:14:02 +0000 (UTC)
Received: from [16.17.222.159] (unknown [16.17.222.159])
	by g4t0009.houston.hp.com (Postfix) with ESMTP id 6FC7AC18B
	for <kexec@lists.infradead.org>; Fri,  3 Dec 2010 16:14:02 +0000 (UTC)
Message-ID: <4CF91748.5000401@hp.com>
Date: Fri, 03 Dec 2010 17:14:00 +0100
From: Louis Bouchard <louis.bouchard@hp.com>
MIME-Version: 1.0
Subject: kdump_post : busybox returns "Applet not found"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1916211859=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============1916211859==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>
<body text="#000000" bgcolor="#ffffff">
Hello (again)<br>
<br>
I did not think that I would come back to you so quickly, but I am
having an issue with RHEL6 implementation of kexec-tools (apparently
adapted for kexec-tools 2.0) while testing crashdc on RHEL6 (the
initial release).<br>
<br>
Everytime I trigger a crash with 'kdump_post' set to
/var/crash/scripts/kdump_post.sh I get the following from busybox :
kdump-post.sh: applet not found<br>
<br>
<blockquote><tt>Copying data&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; : [100%]</tt><br>
  <tt>Saving core complete</tt><br>
  <tt>kdump-post.sh: applet not found</tt><br>
  <tt>dropping to initramfs shell</tt><br>
  <tt>exiting this shell will reboot your system</tt><br>
</blockquote>
For a while, I thought that my crashdc calling script was in cause, but
I changed kdump_post.sh to one single "echo This is working" line and I
still get the same thing :<br>
<br>
<blockquote><tt># cat /var/crash/scripts/kdump-post.sh</tt><br>
  <tt>echo "This is working"</tt><br>
  <tt>/var/crash/scripts/kdump-post.sh</tt><br>
  <tt>kdump-post.sh: applet not found</tt><br>
  <tt>msh/ # /var/crash/scripts/kdump-post.sh</tt><br>
  <tt>This is working</tt><br>
</blockquote>
FYI, my crashdc scripts all work fine when I call them manually from
the CLI.<br>
<br>
I did not encounter this situation with SLES11, but from what I gather,
it does not rely on&nbsp; busybox.<br>
<br>
Maybe someone could suggest ways to further investigate this issue. I'm
available to test.<br>
<br>
Kind regard,<br>
<br>
...Louis<br>
<br>
<pre class="moz-signature" cols="72">-- 
Louis Bouchard
Linux Support Engineer
Team lead, EMEA Linux Competency Center,
Linux Advocate, HP

HP Technology Services - Global Competency Center
Hewlett-Packard Company

<a class="moz-txt-link-abbreviated" href="mailto:louis.bouchard@hp.com">louis.bouchard@hp.com</a>     / Email
Mon-Fri 9-17&lt;WET&gt;,&lt;GMT+2&gt; / Working Hours
Mark Fay                  / Manager
<a class="moz-txt-link-abbreviated" href="mailto:mark.fay@hp.com">mark.fay@hp.com</a>           / Manager's Email
</pre>
</body>
</html>


--===============1916211859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1916211859==--
