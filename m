Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIgJ-0005O7-Pd
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:39:04 +0000
Received: by mail-pb0-f49.google.com with SMTP id rq13so3656417pbb.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:39:03 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 08/10] Add page_is_buddy for recent kernels
Date: Fri, 29 Jun 2012 02:39:00 +0900
Message-ID: <20120628173900.19702.3277.stgit@fedora-machine>
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

On kernels from v2.6.38 and later kernels, buddy page is marked by
_mapcount == PAGE_BUDDY_MAPCOUNT_VALUE, which varies once as follows:

  kernel version    | PAGE_BUDDY_MAPCOUNT_VALUE
  ------------------+--------------------------
  v2.6.38           | -2
  v2.6.39 and later | -128

One more notice is that _mapcount shares its memory with other fields
for SLAB/SLUB when PG_slab is set. We need to check if PG_slab is set
or not before looking up _mapcount value.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 37c371e..aea956f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -55,6 +55,8 @@ do { \
 		*ptr_long_table = value; \
 } while (0)
 
+static void setup_page_is_buddy(void);
+
 void
 initialize_tables(void)
 {
@@ -2733,6 +2735,9 @@ out:
 	if (!get_value_for_old_linux())
 		return FALSE;
 
+	if (info->dump_level & DL_EXCLUDE_FREE_CONST)
+		setup_page_is_buddy();
+
 	return TRUE;
 }
 
@@ -3512,6 +3517,31 @@ exclude_free_page(void)
 	return TRUE;
 }
 
+static int
+page_is_buddy_v3(unsigned long flags, unsigned int _mapcount,
+		 unsigned long private, unsigned int _count)
+{
+	if (flags & (1UL << NUMBER(PG_slab)))
+		return FALSE;
+
+	if (_mapcount == (int)NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE))
+		return TRUE;
+
+	return FALSE;
+}
+
+static void
+setup_page_is_buddy(void)
+{
+	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER
+	    && SIZE(pageflags) != NOT_FOUND_STRUCTURE
+	    && NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
+		info->page_is_buddy = page_is_buddy_v3;
+
+	MSG("Can't select page_is_buddy handler; "
+	    "filtering free pages is disabled.\n");
+}
+
 /*
  * If using a dumpfile in kdump-compressed format as a source file
  * instead of /proc/vmcore, 1st-bitmap of a new dumpfile must be


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
