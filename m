Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PTFbV-0003p8-6T
	for kexec@lists.infradead.org; Thu, 16 Dec 2010 15:18:49 +0000
Received: by iyj21 with SMTP id 21so1704277iyj.36
	for <kexec@lists.infradead.org>; Thu, 16 Dec 2010 07:18:48 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 16 Dec 2010 20:42:47 +0530
Message-ID: <AANLkTimybQHcBZhyMGDMKehjN32bSCBNqDNwzAUBZv6t@mail.gmail.com>
Subject: 32bit kexec with x86_64 Kernel
From: Avinash Kaul <kaul.avi@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0257556057=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

--===============0257556057==
Content-Type: multipart/alternative; boundary=0003255735f2834e3c0497887cb9

--0003255735f2834e3c0497887cb9
Content-Type: text/plain; charset=ISO-8859-1

Hi

I have a setup where i am using a 64bit kernel with a 32bit userspace. Linux
Kernel version is 2.6.31.6(Fedora) and Kexec is 2.0.2. When i use 32bit
kexec to load the x86_64 kernel bzimage, that works fine, however the core
generated cannot be disassembled correctly. I get various errors regarding
access of memory. However the same kernel when compiled as 32bit everything
works fine.

I am not sure it what i am trying is a support scenario, do we need a 64bit
kexec-tools with a x86_64 kernel?

thanks,
-Avi

--0003255735f2834e3c0497887cb9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>I have a setup where i am using a 64bit kernel with a 32bit users=
pace. Linux Kernel version is 2.6.31.6(Fedora) and Kexec is 2.0.2. When i u=
se 32bit kexec to load the x86_64 kernel bzimage, that works fine, however =
the core generated cannot be disassembled correctly. I get various errors r=
egarding access of memory. However the same kernel when compiled as 32bit e=
verything works fine.<br>
<br>I am not sure it what i am trying is a support scenario, do we need a 6=
4bit kexec-tools with a x86_64 kernel?<br><br>thanks,<br>-Avi<br>

--0003255735f2834e3c0497887cb9--


--===============0257556057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0257556057==--

