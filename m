Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a8Sxl-0007pb-3I
 for kexec@lists.infradead.org; Mon, 14 Dec 2015 13:15:28 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [RFC PATCH] kexec: x86_64: bzImage64: Fix a potential out-of-bound
 buffer access
Date: Mon, 14 Dec 2015 21:11:56 +0800
Message-Id: <1450098716-6132-1-git-send-email-xlpang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Signed-off-by: Simon Horman" <horms@verge.net.au>
Cc: Xunlei Pang <xlpang@redhat.com>, kexec@lists.infradead.org

Currently, there is an out-of-bound memory access in do_bzImage64_load():
    strncpy(modified_cmdline, command_line, COMMAND_LINE_SIZE);

Normally this is ok because the out-of-bound memory usually has already
been allocated, but with the layer of glibc which manages their own heap
allocation and free, in theory it has a chance that this out-of-bound access
will locate at the unmapping vm area and result in SEGV.

In my opinion, we need to avoid such out-of-bound access.

There are also many other places having similar code, this patch is just 
half-baked. If there is no objection, I will make another one handling all.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 kexec/arch/x86_64/kexec-bzImage64.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index 8edb3e4..929f7af 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -150,11 +150,9 @@ static int do_bzImage64_load(struct kexec_info *info,
 	if (info->kexec_flags & (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)) {
 		modified_cmdline = xmalloc(COMMAND_LINE_SIZE);
 		memset((void *)modified_cmdline, 0, COMMAND_LINE_SIZE);
-		if (command_line) {
-			strncpy(modified_cmdline, command_line,
-					COMMAND_LINE_SIZE);
-			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
-		}
+		/* The checking above should gurantee command_line_len's validity. */
+		if (command_line)
+			strncpy(modified_cmdline, command_line, command_line_len);
 
 		/* If panic kernel is being loaded, additional segments need
 		 * to be created. load_crashdump_segments will take care of
@@ -380,6 +378,7 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 		command_line = strdup("\0");
 		command_line_len = 1;
 	}
+
 	ramdisk_buf = 0;
 	if (ramdisk)
 		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
