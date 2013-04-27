Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UVyjA-0002C9-OI
 for kexec@lists.infradead.org; Sat, 27 Apr 2013 06:35:21 +0000
Received: by mail-pa0-f51.google.com with SMTP id lj1so131028pab.38
 for <kexec@lists.infradead.org>; Fri, 26 Apr 2013 23:35:17 -0700 (PDT)
Message-ID: <517B719F.6030503@gmail.com>
Date: Sat, 27 Apr 2013 14:35:11 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: cleanup: make add_backup_segments static
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

The function add_backup_segments is only called by my_load and
they are in the same file. So unnecessary to export it. Make it
static.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec.c |    5 +++--
 kexec/kexec.h |    4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index cf3fcb9..53d6edc 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -434,8 +434,9 @@ static int find_segment_hole(struct kexec_info *info,
 	return *size;
 }
 
-int add_backup_segments(struct kexec_info *info, unsigned long backup_base,
-			unsigned long backup_size)
+static int add_backup_segments(struct kexec_info *info,
+			       unsigned long backup_base,
+			       unsigned long backup_size)
 {
 	unsigned long mem_base, mem_size, bkseg_base, bkseg_size, start, end;
 	unsigned long pagesize;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 5ded390..715b568 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -285,10 +285,6 @@ int kexec_iomem_for_each_line(char *match,
 int parse_iomem_single(char *str, uint64_t *start, uint64_t *end);
 const char * proc_iomem(void);
 
-extern int add_backup_segments(struct kexec_info *info,
-			       unsigned long backup_base,
-			       unsigned long backup_size);
-
 #define MAX_LINE	160
 
 char *concat_cmdline(const char *base, const char *append);
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
