Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOjE-0006EP-EP
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:53 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 192A33EE0BC
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:51 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0250F45DE56
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:51 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E187945DE54
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:50 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D2B171DB8042
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:50 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C61D1DB8047
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:50 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 08/10] Add page_is_buddy for PG_buddy
Date: Thu, 08 Nov 2012 18:48:50 +0900
Message-ID: <20121108094850.30421.54784.stgit@localhost6.localdomain6>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

On kernels from v2.6.18 to v2.6.37, buddy page is marked by the
PG_buddy flag.

  kernel version     | PG_buddy
  ------------------ +---------------------------------
  v2.6.17 to v2.6.26 | 19
  v2.6.27 to v2.6.37 | 19 if CONFIG_PAGEFLAGS_EXTEND=y
                     | 18 otherwise

Note for hard coding: alghouth I don't do in this patch set, it's
possible to determine whether CONFIG_PAGEFLAGS_EXTEND=yes or not by
looking at error_status array defined in mm/memory-failure.c, for
example.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 27ad3e6..838ef53 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3643,6 +3643,19 @@ exclude_free_page(void)
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
@@ -3661,13 +3674,16 @@ page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
 static void
 setup_page_is_buddy(void)
 {
-	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER
-	    && SIZE(pageflags) != NOT_FOUND_STRUCTURE
-	    && NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
-		info->page_is_buddy = page_is_buddy_v3;
-	else
-		MSG("Can't select page_is_buddy handler; "
-		    "filtering free pages is disabled.\n");
+	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
+		if (SIZE(pageflags) != NOT_FOUND_STRUCTURE
+		    && NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
+			info->page_is_buddy = page_is_buddy_v3;
+		else {
+			MSG("Can't select page_is_buddy handler; "
+			    "filtering free pages is disabled.\n");
+		}
+	} else
+		info->page_is_buddy = page_is_buddy_v2;
 }
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
