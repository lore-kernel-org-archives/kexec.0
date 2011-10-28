Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJj2y-0003Lf-VH
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 09:48:22 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 96C563EE0BC
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:16 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 79A1245DE4E
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:16 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 61F8F45DD73
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:16 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4F14B1DB8038
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:16 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1B31AE08003
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:16 +0900 (JST)
Received: from ml13.css.fujitsu.com (ml13 [127.0.0.1])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id E032AFD001F
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:15 +0900 (JST)
Received: from localhost6.localdomain6 (unknown [10.124.63.45])
	by ml13.s.css.fujitsu.com (Postfix) with ESMTP id 9909AFD0019
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 18:48:15 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 02/14] Extend DumpInfo structure
Date: Fri, 28 Oct 2011 18:48:15 +0900
Message-ID: <20111028094815.20940.49668.stgit@localhost6.localdomain6>
In-Reply-To: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
References: <20111028094454.20940.1209.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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

Two members, flag_sadump_diskset and flag_sadump, are
introduced. flag_sadump_diskset is true if --diskset=VMCORE is
specified one or more times. flag_sadump has the corresponding value
of type enum sadump_format_type if VMCORE(s) is in sadump-related
formats.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.h |    7 +++++++
 sadump_mod.h   |   10 ++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index f0e5da8..dee0a68 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -34,6 +34,7 @@
 #include "common.h"
 #include "dwarf_info.h"
 #include "diskdump_mod.h"
+#include "sadump_mod.h"
 
 /*
  * Result of command
@@ -894,6 +895,12 @@ struct DumpInfo {
 	 */
 	unsigned long long split_start_pfn;  
 	unsigned long long split_end_pfn;  
+
+	/*
+	 * sadump info:
+	 */
+	int flag_sadump_diskset;
+	enum sadump_format_type flag_sadump;         /* sadump format type */
 };
 extern struct DumpInfo		*info;
 
diff --git a/sadump_mod.h b/sadump_mod.h
index 98f5dd1..3385123 100644
--- a/sadump_mod.h
+++ b/sadump_mod.h
@@ -171,4 +171,14 @@ struct sadump_media_header {
 
 #endif /* defined(__x86__) && defined(__x86_64__) */
 
+/*
+ * Type of sadump related formats
+ */
+enum sadump_format_type {
+	SADUMP_UNKNOWN = 0,
+	SADUMP_SINGLE_PARTITION,
+	SADUMP_DISKSET,
+	SADUMP_MEDIA_BACKUP
+};
+
 #endif /* _SADUMP_MOD_H */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
