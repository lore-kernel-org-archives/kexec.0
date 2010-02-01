Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAZ-00058G-W2
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:30 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 4A4DA24665
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:02 +1100 (EST)
Message-Id: <20100201121324.691032079@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:19 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 23/27] sh: Use size_t for zero_page_size parameter of
	kexec_sh_setup_zero_page()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline; filename=sh-kexec_sh_setup_zero_page-size_t.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

This avoids comparisons between signed and unsigned integers.

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/sh/kexec-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-sh.c	2010-02-01 23:07:20.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-sh.c	2010-02-01 23:07:22.000000000 +1100
@@ -164,10 +164,10 @@ char *get_append(void)
         return append_buf;
 }
 
-void kexec_sh_setup_zero_page(char *zero_page_buf, int zero_page_size,
+void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
 			      char *cmd_line)
 {
-	int n = zero_page_size - 0x100;
+	size_t n = zero_page_size - 0x100;
 
 	memset(zero_page_buf, 0, zero_page_size);
 
Index: kexec-tools/kexec/arch/sh/kexec-sh.h
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-sh.h	2010-02-01 23:06:38.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-sh.h	2010-02-01 23:07:22.000000000 +1100
@@ -23,7 +23,7 @@ int netbsd_sh_load(int argc, char **argv
 void netbsd_sh_usage(void);
 
 char *get_append(void);
-void kexec_sh_setup_zero_page(char *zero_page_buf, int zero_page_size,
+void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
 			      char *cmd_line);
 
 #endif /* KEXEC_SH_H */
Index: kexec-tools/kexec/arch/sh/kexec-zImage-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:07:19.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:07:22.000000000 +1100
@@ -51,7 +51,7 @@ static unsigned long zImage_head32(const
  *
  * Make sure that the file image has a reasonable chance of working.
  */
-int zImage_sh_probe(const char *buf, off_t len)
+int zImage_sh_probe(const char *buf, off_t UNUSED(len))
 {
 	if (memcmp(&buf[0x202], "HdrS", 4) != 0)
 	        return -1;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
