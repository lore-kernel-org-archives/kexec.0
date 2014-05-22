Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WnUDc-00048u-IX
 for kexec@lists.infradead.org; Thu, 22 May 2014 14:43:42 +0000
Date: Thu, 22 May 2014 10:43:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] vmcore-dmesg: Handle struct log to struct printk_log renaming
Message-ID: <20140522144314.GE13647@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>
Cc: Taras Kondratiuk <taras.kondratiuk@linaro.org>, WANG Chao <chaowang@redhat.com>, Lubomir Rintel <lkundrak@v3.sk>

vmcore-dmesg has been failing for me for quite some time as struct log
was renamed to struct printk_log.

62e32ac printk: rename struct log to struct printk_log

This patch has been sitting in mailing list for quite some time. It
is time to repost the patch.

I took original patch of Lubomir and modified a bit to take care of
concern of hardcoded string length.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---

Changes for v2:
  * Clarified printk_log vs. log in some comments.

 vmcore-dmesg/vmcore-dmesg.c |   53 +++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 15 deletions(-)

Index: kexec-tools/vmcore-dmesg/vmcore-dmesg.c
===================================================================
--- kexec-tools.orig/vmcore-dmesg/vmcore-dmesg.c	2014-05-22 10:38:50.792356739 -0400
+++ kexec-tools/vmcore-dmesg/vmcore-dmesg.c	2014-05-22 10:39:12.463355316 -0400
@@ -35,10 +35,10 @@ static loff_t logged_chars_vaddr;
 static loff_t log_first_idx_vaddr;
 static loff_t log_next_idx_vaddr;
 
-/* struct log size */
+/* struct printk_log (or older log) size */
 static uint64_t log_sz;
 
-/* struct log field offsets */
+/* struct printk_log (or older log) field offsets */
 static uint64_t log_offset_ts_nsec = UINT64_MAX;
 static uint16_t log_offset_len = UINT16_MAX;
 static uint16_t log_offset_text_len = UINT16_MAX;
@@ -255,6 +255,7 @@ static void scan_vmcoreinfo(char *start,
 	char *pos, *eol;
 	char temp_buf[1024];
 	bool last_line = false;
+	char *str;
 
 #define SYMBOL(sym) {					\
 	.str = "SYMBOL(" #sym  ")=",			\
@@ -325,19 +326,41 @@ static void scan_vmcoreinfo(char *start,
 			*symbol[i].vaddr = vaddr;
 		}
 
-		/* Check for "SIZE(log)=" */
-		if (memcmp("SIZE(log)=", pos, 10) == 0)
-			log_sz = strtoull(pos + 10, NULL, 10);
-
-		/* Check for struct log field offsets */
-		if (memcmp("OFFSET(log.ts_nsec)=", pos, 20) == 0)
-			log_offset_ts_nsec = strtoull(pos + 20, NULL, 10);
-
-		if (memcmp("OFFSET(log.len)=", pos, 16) == 0)
-			log_offset_len = strtoul(pos + 16, NULL, 10);
-
-		if (memcmp("OFFSET(log.text_len)=", pos, 21) == 0)
-			log_offset_text_len = strtoul(pos + 21, NULL, 10);
+		/* Check for "SIZE(printk_log)" or older "SIZE(log)=" */
+		str = "SIZE(log)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_sz = strtoull(pos + strlen(str), NULL, 10);
+
+		str = "SIZE(printk_log)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_sz = strtoull(pos + strlen(str), NULL, 10);
+
+		/* Check for struct printk_log (or older log) field offsets */
+		str = "OFFSET(log.ts_nsec)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_offset_ts_nsec = strtoull(pos + strlen(str), NULL,
+							10);
+		str = "OFFSET(printk_log.ts_nsec)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_offset_ts_nsec = strtoull(pos + strlen(str), NULL,
+							10);
+
+		str = "OFFSET(log.len)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_offset_len = strtoul(pos + strlen(str), NULL, 10);
+
+		str = "OFFSET(printk_log.len)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_offset_len = strtoul(pos + strlen(str), NULL, 10);
+
+		str = "OFFSET(log.text_len)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_offset_text_len = strtoul(pos + strlen(str), NULL,
+							10);
+		str = "OFFSET(printk_log.text_len)=";
+		if (memcmp(str, pos, strlen(str)) == 0)
+			log_offset_text_len = strtoul(pos + strlen(str), NULL,
+							10);
 
 		if (last_line)
 			break;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
