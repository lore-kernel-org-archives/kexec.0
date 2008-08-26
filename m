Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXwT7-00071v-BZ
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 11:12:13 +0000
Received: by rv-out-0708.google.com with SMTP id b17so1911060rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 04:12:13 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2008 20:12:25 +0900
Message-Id: <20080826111225.615.32479.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
Subject: [PATCH 05/06] sh: Use dynamic zImage load address
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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

Dynamically calculate SuperH zImage load address instead of hardcoding.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/kexec-zImage-sh.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- 0005/kexec/arch/sh/kexec-zImage-sh.c
+++ work/kexec/arch/sh/kexec-zImage-sh.c	2008-08-22 13:04:13.000000000 +0900
@@ -79,7 +79,8 @@ int zImage_sh_load(int argc, char **argv
 {
         char *command_line;
 	int opt, k;
-	unsigned long empty_zero, area, zero_page_base, zero_page_size;
+	unsigned long empty_zero, zero_page_base, zero_page_size;
+	unsigned long image_base;
 	char *param;
 
 	static const struct option options[] = {
@@ -137,8 +138,12 @@ int zImage_sh_load(int argc, char **argv
 	add_segment(info, param, zero_page_size,
 		    0x80000000 | zero_page_base, zero_page_size);
 
-	area = empty_zero & 0x1c000000;
-	add_segment(info, buf,   len,  (area | 0x80210000), len);
-	info->entry = (void *)(0x80210000 | area);
+	/* load image a bit above the zero page, round up to 64k
+	 * the zImage will relocate itself, but only up seems supported.
+	 */
+
+	image_base = (empty_zero + (0x10000 - 1)) & ~(0x10000 - 1);
+	add_segment(info, buf, len, image_base, len);
+	info->entry = (void *)image_base;
 	return 0;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
