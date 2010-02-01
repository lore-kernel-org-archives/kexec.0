Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbvAI-00054P-Mv
	for kexec@lists.infradead.org; Mon, 01 Feb 2010 12:14:07 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(203-206-13-190.dyn.iinet.net.au [203.206.13.190])
	by kirsty.vergenet.net (Postfix) with ESMTP id 6CDFB24067
	for <kexec@lists.infradead.org>; Mon,  1 Feb 2010 23:14:01 +1100 (EST)
Message-Id: <20100201121321.127489773@vergenet.net>
Date: Mon, 01 Feb 2010 23:12:00 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [patch 04/27] sh: Remove unused len parameter from zImage_head32()
References: <20100201121156.252909695@vergenet.net>
Content-Disposition: inline;
	filename=sh-zImage_head32-remove-unused-parameter.patch
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

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/arch/sh/kexec-zImage-sh.c
===================================================================
--- kexec-tools.orig/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:07:17.000000000 +1100
+++ kexec-tools/kexec/arch/sh/kexec-zImage-sh.c	2010-02-01 23:07:17.000000000 +1100
@@ -34,7 +34,7 @@ static const int probe_debug = 0;
 #define HEAD32_INIT_SR 3
 #define HEAD32_INIT_SR_VALUE 0x400000F0
 
-static unsigned long zImage_head32(const char *buf, off_t len, int offs)
+static unsigned long zImage_head32(const char *buf, int offs)
 {
 	unsigned long *values = (void *)buf;
 	int k;
@@ -56,7 +56,7 @@ int zImage_sh_probe(const char *buf, off
 	if (memcmp(&buf[0x202], "HdrS", 4) != 0)
 	        return -1;
 
-	if (zImage_head32(buf, len, HEAD32_INIT_SR) != HEAD32_INIT_SR_VALUE)
+	if (zImage_head32(buf, HEAD32_INIT_SR) != HEAD32_INIT_SR_VALUE)
 	        return -1;
 
 	return 0;
@@ -112,7 +112,7 @@ int zImage_sh_load(int argc, char **argv
 	 * all combinations.
 	 */
 
-	empty_zero = zImage_head32(buf, len, HEAD32_KERNEL_START_ADDR);
+	empty_zero = zImage_head32(buf, HEAD32_KERNEL_START_ADDR);
 
 	zero_page_size = 0x10000;
 	zero_page_base = virt_to_phys(empty_zero - zero_page_size);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
