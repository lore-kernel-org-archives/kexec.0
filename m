Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JuD3q-0002u2-Ev
	for kexec@lists.infradead.org; Thu, 08 May 2008 20:49:54 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 49A9C4618C
	for <kexec@lists.infradead.org>; Thu,  8 May 2008 22:49:53 +0200 (CEST)
Date: Thu, 8 May 2008 22:50:34 +0200
Subject: [PATCH] Add x86-bzImage to manpage
Message-ID: <20080508205034.GA24579@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
From: bwalle@suse.de (Bernhard Walle)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This patch just adds the "x86-bzImage" type to the manpage.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kexec/kexec.8 |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -206,6 +206,41 @@ Use
 as the kernel's initial ramdisk.
 .RE
 .PP
+.B bzImage-x86
+.RS
+.TP
+.BI \-\-append= string
+Append
+.I string
+to the kernel command line.
+.TP
+.BI \-\-command\-line= string
+Set the kernel command line to
+.IR string .
+.TP
+.BI \-\-reuse-cmdline
+Use the command line from the running system. When a panic kernel is loaded, it
+strips the
+.I
+crashkernel
+parameter automatically. The
+.I BOOT_IMAGE
+parameter is also stripped.
+.TP
+.BI \-\-initrd= file
+Use
+.I file
+as the kernel's initial ramdisk.
+.TP
+.BI \-\-ramdisk= file
+Use
+.I file
+as the kernel's initial ramdisk.
+.TP
+.BI \-\-real-mode
+Use real-mode entry point.
+.RE
+.PP
 .B multiboot-x86
 .RS
 .TP

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
