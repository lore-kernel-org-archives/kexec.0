Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIgR-0005ZJ-O8
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:39:12 +0000
Received: by mail-pz0-f49.google.com with SMTP id m1so3477513dad.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:39:11 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 09/10] Add page_is_buddy for PG_buddy
Date: Fri, 29 Jun 2012 02:39:08 +0900
Message-ID: <20120628173908.19702.4363.stgit@fedora-machine>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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

Note for hard coding: it's possible to determine whether
CONFIG_PAGEFLAGS_EXTEND=yes or not by looking at error_status array
defined in mm/memory-failure.c, for example.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index aea956f..675b47e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3518,6 +3518,16 @@ exclude_free_page(void)
 }
 
 static int
+page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
+		 unsigned long private, unsigned int _count)
+{
+	if (flags & (1UL << NUMBER(PG_buddy)))
+		return TRUE;
+
+	return FALSE;
+}
+
+static int
 page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
 		 unsigned long private, unsigned int _count)
 {
@@ -3533,13 +3543,16 @@ page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
 static void
 setup_page_is_buddy(void)
 {
-	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER
-	    && SIZE(pageflags) != NOT_FOUND_STRUCTURE
-	    && NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
-		info->page_is_buddy = page_is_buddy_v3;
-
-	MSG("Can't select page_is_buddy handler; "
-	    "filtering free pages is disabled.\n");
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
