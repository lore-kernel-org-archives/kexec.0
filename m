Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f161.google.com ([209.85.217.161])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Ljttj-0005I8-7H
	for kexec@lists.infradead.org; Wed, 18 Mar 2009 11:25:31 +0000
Received: by gxk5 with SMTP id 5so26182gxk.18
	for <kexec@lists.infradead.org>; Wed, 18 Mar 2009 04:25:22 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Mar 2009 20:22:51 +0900
Message-Id: <20090318112251.13413.30984.sendpatchset@rx1.opensource.se>
Subject: [PATCH] sh: use physical address for zImage entry
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Use a physical address for the SuperH zImage entry point.
This makes the zImage loader behave as the elf loader.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/kexec-zImage-sh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/kexec/arch/sh/kexec-zImage-sh.c
+++ work/kexec/arch/sh/kexec-zImage-sh.c	2009-03-18 20:09:56.000000000 +0900
@@ -140,6 +140,6 @@ int zImage_sh_load(int argc, char **argv
 
 	image_base = (empty_zero + (0x10000 - 1)) & ~(0x10000 - 1);
 	add_segment(info, buf, len, image_base, len);
-	info->entry = (void *)image_base;
+	info->entry = (void *)virt_to_phys(image_base);
 	return 0;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
