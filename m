Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from shell.v3.sk ([195.168.3.45])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMGll-0008QC-0U
 for kexec@lists.infradead.org; Wed, 18 Sep 2013 12:22:09 +0000
From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [RESEND PATCH] vmcore-dmesg: Understand >= v3.11-rc4 dmesg
Date: Wed, 18 Sep 2013 14:21:43 +0200
Message-Id: <1379506903-24407-1-git-send-email-lkundrak@v3.sk>
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
To: kexec@lists.infradead.org
Cc: Joe Perches <joe@perches.com>, Lubomir Rintel <lkundrak@v3.sk>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>

Symbol name changed with the following commit:
62e32ac printk: rename struct log to struct printk_log

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: Simon Horman <horms@verge.net.au>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---

I believe this can now be applied, as the change went into 3.11 kernel release.
Thank you!

 vmcore-dmesg/vmcore-dmesg.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 0f477c0..bfc19e9 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -324,19 +324,27 @@ static void scan_vmcoreinfo(char *start, size_t size)
 			*symbol[i].vaddr = vaddr;
 		}
 
-		/* Check for "SIZE(log)=" */
+		/* Check for "SIZE(printk_log)" or older "SIZE(log)=" */
 		if (memcmp("SIZE(log)=", pos, 10) == 0)
 			log_sz = strtoull(pos + 10, NULL, 10);
+		if (memcmp("SIZE(printk_log)=", pos, 17) == 0)
+			log_sz = strtoull(pos + 17, NULL, 10);
 
 		/* Check for struct log field offsets */
 		if (memcmp("OFFSET(log.ts_nsec)=", pos, 20) == 0)
 			log_offset_ts_nsec = strtoull(pos + 20, NULL, 10);
+		if (memcmp("OFFSET(printk_log.ts_nsec)=", pos, 27) == 0)
+			log_offset_ts_nsec = strtoull(pos + 27, NULL, 10);
 
 		if (memcmp("OFFSET(log.len)=", pos, 16) == 0)
 			log_offset_len = strtoul(pos + 16, NULL, 10);
+		if (memcmp("OFFSET(printk_log.len)=", pos, 23) == 0)
+			log_offset_len = strtoul(pos + 23, NULL, 10);
 
 		if (memcmp("OFFSET(log.text_len)=", pos, 21) == 0)
 			log_offset_text_len = strtoul(pos + 21, NULL, 10);
+		if (memcmp("OFFSET(printk_log.text_len)=", pos, 28) == 0)
+			log_offset_text_len = strtoul(pos + 28, NULL, 10);
 
 		if (last_line)
 			break;
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
