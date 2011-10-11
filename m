Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDe4u-0003Hd-Oz
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 15:17:13 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A7ABD3EE0B5
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:10 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F2BF45DE68
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:10 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6F25D45DE6A
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:10 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5E20E1DB802C
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:10 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 201091DB8038
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:10 +0900 (JST)
Received: from ml14.css.fujitsu.com (ml14 [127.0.0.1])
	by ml14.s.css.fujitsu.com (Postfix) with ESMTP id EBB399F7277
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:09 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by ml14.s.css.fujitsu.com (Postfix) with ESMTP id 8E1D19F726F
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:09 +0900 (JST)
Date: Wed, 12 Oct 2011 00:17:05 +0900 (   )
Message-Id: <20111012.001705.115910100.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 09/12] Estimate phys_base based on linux_banner position
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
References: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

sadump doesn't save phys_base, so we must estimate it in any way. Here
we borrow the method in crash utility that we search a certain range
of addresses for linux_banner symbol value.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |   12 ++++++++++++
 sadump_info.c  |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 sadump_info.h  |   13 +++++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e4b3b38..4e3beef 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2504,6 +2504,15 @@ initial(void)
 
 		(void) sadump_set_timestamp(&info->timestamp);
 
+		/*
+		 * NOTE: phys_base is never saved by sadump and so
+		 * must be computed in some way. We here choose the
+		 * way of looking at linux_banner. See
+		 * sadump_virt_phys_base(). The processing is
+		 * postponed until debug information becomes
+		 * available.
+		 */
+
 	} else if (!get_phys_base())
 		return FALSE;
 
@@ -2579,6 +2588,9 @@ out:
 		return FALSE;
 
 	if (debug_info) {
+		if (info->flag_sadump)
+			(void) sadump_virt_phys_base();
+
 		if (!get_machdep_info())
 			return FALSE;
 
diff --git a/sadump_info.c b/sadump_info.c
index c4806c4..fa05443 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -22,6 +22,12 @@
 #include "print_info.h"
 #include "sadump_mod.h"
 
+#ifdef __x86_64__
+
+#define MEGABYTES(x)	((x) * (1048576))
+
+#endif
+
 struct sadump_diskset_info {
 	char *name_memory;
 	int fd_memory;
@@ -666,6 +672,47 @@ sadump_get_max_mapnr(void)
 	return si->sh_memory->max_mapnr;
 }
 
+#ifdef __x86_64__
+
+int
+sadump_virt_phys_base(void)
+{
+        char buf[BUFSIZE];
+        unsigned long phys, linux_banner_phys;
+
+	if (SYMBOL(linux_banner) == NOT_FOUND_SYMBOL) {
+		DEBUG_MSG("sadump: symbol linux_banner is not found\n");
+		goto failed;
+	}
+
+        linux_banner_phys = SYMBOL(linux_banner) - __START_KERNEL_map;
+
+        if (readmem(PADDR, linux_banner_phys + info->phys_base, buf,
+		    strlen("Linux version")) && STRNEQ(buf, "Linux version"))
+                return TRUE;
+
+        for (phys = (-MEGABYTES(16)); phys != MEGABYTES(16+1);
+             phys += MEGABYTES(1)) {
+                if (readmem(PADDR, linux_banner_phys + phys, buf,
+			    strlen("Linux version")) &&
+		    STRNEQ(buf, "Linux version")) {
+                        DEBUG_MSG("sadump: phys_base: %lx %s\n", phys,
+				  info->phys_base != phys ? "override" : "");
+                        info->phys_base = phys;
+                        return TRUE;
+                }
+        }
+
+failed:
+	info->phys_base = 0;
+
+	DEBUG_MSG("sadump: failed to calculate phys_base; default to 0\n");
+
+        return FALSE;
+}
+
+#endif /* __x86_64__ */
+
 int
 readpmem_sadump(unsigned long long paddr, void *bufptr, size_t size)
 {
diff --git a/sadump_info.h b/sadump_info.h
index b6b9cdd..401b769 100644
--- a/sadump_info.h
+++ b/sadump_info.h
@@ -22,6 +22,19 @@
 
 #include "makedumpfile.h"
 
+#ifdef __x86_64__
+
+int sadump_virt_phys_base(void);
+
+#else
+
+static inline int sadump_virt_phys_base(void)
+{
+	return TRUE;
+}
+
+#endif
+
 #if defined(__x86__) || defined(__x86_64__)
 
 int check_and_get_sadump_header_info(char *filename);
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
