Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE4F-0006F5-Cv
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:02:16 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id F2CE93EE0AE
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:13 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DC83445DD78
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:13 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C69D445DD74
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:13 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id BAD991DB803A
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:13 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 75CC31DB802C
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:02:13 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 08/10] Add page_is_buddy for PG_buddy
Date: Fri, 16 Nov 2012 14:02:13 +0900
Message-ID: <20121116050213.8280.73020.stgit@localhost6.localdomain6>
In-Reply-To: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

On kernels from v2.6.18 to v2.6.37, buddy page is marked by the
PG_buddy flag.

  kernel version     | PG_buddy
  ------------------ +---------------------------------
  v2.6.17 to v2.6.26 | 19
  v2.6.27 to v2.6.37 | 19 if CONFIG_PAGEFLAGS_EXTEND=y
                     | 18 otherwise

We don't need to care about CONFIG_PAGEFLAGS_EXTEND because the
architectures specifying this as y are um and xtensa only. They are
not included in the supported architectures of makedumpfile.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7b13dca..4e5d4d3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3669,6 +3669,19 @@ exclude_free_page(void)
 }
 
 /*
+ * For the kernel versions from v2.6.17 to v2.6.37.
+ */
+static int
+page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
+			unsigned long private, unsigned int _count)
+{
+	if (flags & (1UL << NUMBER(PG_buddy)))
+		return TRUE;
+
+	return FALSE;
+}
+
+/*
  * For v2.6.38 and later kernel versions.
  */
 static int
@@ -3690,10 +3703,13 @@ setup_page_is_buddy(void)
 	if (OFFSET(page.private) == NOT_FOUND_STRUCTURE)
 		goto out;
 
-	if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
-		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
-			info->page_is_buddy = page_is_buddy_v3;
-	}
+	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
+		if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
+			if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
+				info->page_is_buddy = page_is_buddy_v3;
+		}
+	} else
+		info->page_is_buddy = page_is_buddy_v2;
 
 out:
 	if (!info->page_is_buddy)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
