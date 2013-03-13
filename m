Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x229.google.com ([2607:f8b0:400e:c00::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpYC-0006Xk-Le
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:33:17 +0000
Received: by mail-da0-f41.google.com with SMTP id j17so514911dan.0
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:33:14 -0700 (PDT)
Message-ID: <5140B853.2050906@gmail.com>
Date: Thu, 14 Mar 2013 01:33:07 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 10/13] kexec: ppc64: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be more clear.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |    4 ++--
 kexec/arch/ppc64/fs2dt.c           |    6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index b8a63bd..49cab12 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -298,7 +298,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		 * to the next page size boundary though, so makedumpfile can
 		 * read it safely without going south on us.
 		 */
-		cend = (cend + page_size - 1) & (~(page_size - 1));
+		cend = _ALIGN(cend, page_size);
 
 		crash_memory_range[memory_ranges].start = cstart;
 		crash_memory_range[memory_ranges++].end = cend;
@@ -400,7 +400,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	info->backup_src_start = BACKUP_SRC_START;
 	info->backup_src_size = BACKUP_SRC_SIZE;
 	/* Create a backup region segment to store backup data*/
-	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+	sz = _ALIGN(BACKUP_SRC_SIZE, align);
 	tmp = xmalloc(sz);
 	memset(tmp, 0, sz);
 	info->backup_start = add_buffer(info, tmp, sz, sz, align,
diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 9750c34..62edc93 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -698,8 +698,7 @@ int create_flatten_tree(char **bufp, off_t *sizep, char *cmdline)
 	dt_reserve(&dt, 1);
 	*dt++ = 9;
 
-	len = sizeof(bb[0]);
-	len += 7; len &= ~7;
+	len = _ALIGN(sizeof(bb[0], 8);
 
 	bb->off_mem_rsvmap = len;
 
@@ -714,8 +713,7 @@ int create_flatten_tree(char **bufp, off_t *sizep, char *cmdline)
 	len *= sizeof(unsigned);
 	bb->off_dt_strings = bb->off_dt_struct + len;
 
-	len = propnum("");
-	len +=  3; len &= ~3;
+	len = _ALIGN(propnum(""), 4);
 	bb->totalsize = bb->off_dt_strings + len;
 
 	bb->magic = 0xd00dfeed;
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
