Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIg4-0005O7-9r
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:38:49 +0000
Received: by mail-pb0-f49.google.com with SMTP id rq13so3656417pbb.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:38:48 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 06/10] Add command-line processing for free page filtering
 looking up mem_map array
Date: Fri, 29 Jun 2012 02:38:44 +0900
Message-ID: <20120628173844.19702.58432.stgit@fedora-machine>
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

I choose dump level 32 for free page filtering looking up mem_map
array. But I don't mean this is the final version now, I mean
experimental use for RFC, only. I prefer the setting that this logic
looking up mem_map array is automatically used if dump level 16 and
--cyclic option are specified at the same time.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |    3 ++-
 makedumpfile.h |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index bed74df..d1eded0 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3853,7 +3853,8 @@ create_2nd_bitmap(void)
 	 */
 	if (info->dump_level & DL_EXCLUDE_CACHE ||
 	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
-	    info->dump_level & DL_EXCLUDE_USER_DATA) {
+	    info->dump_level & DL_EXCLUDE_USER_DATA ||
+	    info->dump_level & DL_EXCLUDE_FREE_CONST) {
 		if (!exclude_unnecessary_pages()) {
 			ERRMSG("Can't exclude unnecessary pages.\n");
 			return FALSE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 3059a9e..404f00e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -146,7 +146,7 @@ isAnon(unsigned long mapping)
  * Dump Level
  */
 #define MIN_DUMP_LEVEL		(0)
-#define MAX_DUMP_LEVEL		(31)
+#define MAX_DUMP_LEVEL		(63)
 #define NUM_ARRAY_DUMP_LEVEL	(MAX_DUMP_LEVEL + 1) /* enough to allocate
 							all the dump_level */
 #define DL_EXCLUDE_ZERO		(0x001) /* Exclude Pages filled with Zeros */
@@ -156,6 +156,8 @@ isAnon(unsigned long mapping)
 				           with Private Pages */
 #define DL_EXCLUDE_USER_DATA	(0x008) /* Exclude UserProcessData Pages */
 #define DL_EXCLUDE_FREE		(0x010)	/* Exclude Free Pages */
+#define DL_EXCLUDE_FREE_CONST	(0x020)	/* Exclude Free Pages looking
+					   up mem_map */
 
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
