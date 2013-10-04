Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-la0-f41.google.com ([209.85.215.41])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VS5Ju-0003dT-5W
 for kexec@lists.infradead.org; Fri, 04 Oct 2013 13:21:26 +0000
Received: by mail-la0-f41.google.com with SMTP id ec20so3286398lab.28
 for <kexec@lists.infradead.org>; Fri, 04 Oct 2013 06:21:04 -0700 (PDT)
From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [PATCH] vmcore-dmesg: Read renamed printk_log parameters
Date: Fri,  4 Oct 2013 16:20:59 +0300
Message-Id: <1380892859-25699-1-git-send-email-taras.kondratiuk@linaro.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: Linaro Networking <linaro-networking@linaro.org>, kexec@lists.infradead.org

printk log structure name was changed in v3.11-rc4 by commit
62e32ac printk: rename struct log to struct printk_log

Add macros to remove hardcoded lengths and read both log name variants.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 vmcore-dmesg/vmcore-dmesg.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 0f477c0..022708d 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -255,6 +255,16 @@ static void scan_vmcoreinfo(char *start, size_t size)
 	char temp_buf[1024];
 	bool last_line = false;
 
+#define READ_INT_PARAM(name, var, converter) {				\
+	if (!memcmp(name, pos, sizeof(name) - 1))			\
+		var = converter(pos + sizeof(name) - 1, NULL, 10); }
+
+#define READ_LOG_PARAMETERS(log_name) {							  \
+	READ_INT_PARAM("SIZE("   #log_name          ")=", log_sz,              strtoull); \
+	READ_INT_PARAM("OFFSET(" #log_name  ".ts_nsec)=", log_offset_ts_nsec,  strtoull); \
+	READ_INT_PARAM("OFFSET(" #log_name      ".len)=", log_offset_len,      strtoul);  \
+	READ_INT_PARAM("OFFSET(" #log_name ".text_len)=", log_offset_text_len, strtoul); }
+
 #define SYMBOL(sym) {					\
 	.str = "SYMBOL(" #sym  ")=",			\
 	.name = #sym,					\
@@ -324,19 +334,8 @@ static void scan_vmcoreinfo(char *start, size_t size)
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
+		READ_LOG_PARAMETERS(log);
+		READ_LOG_PARAMETERS(printk_log);
 
 		if (last_line)
 			break;
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
