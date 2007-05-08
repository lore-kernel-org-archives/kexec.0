Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-blu.bigfish.com ([65.55.251.10]
	helo=mail110-blu-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlDS6-0005ZG-DJ
	for kexec@lists.infradead.org; Mon, 07 May 2007 20:21:17 -0400
Received: from mail110-blu (localhost.localdomain [127.0.0.1])
	by mail110-blu-R.bigfish.com (Postfix) with ESMTP id 1CD177E8396
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:02:59 +0000 (UTC)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail110-blu.bigfish.com (Postfix) with ESMTP id AE4629C0063
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:02:58 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id l4802vFc017717
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:02:57 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l4802vQi019339
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:02:57 GMT
Message-ID: <463FBE30.8080500@am.sony.com>
Date: Mon, 07 May 2007 17:02:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 3/5] kexec add strict-prototypes
References: <20070507235727.631477448@am.sony.com>>
In-Reply-To: <20070507235727.631477448@am.sony.com>>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Geoff Levand <geoffrey.levand@am.sony.com>

Add -Wstrict-prototypes to EXTRA_CFLAGS and fix the powerpc compiler warnings.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 configure.ac                   |    2 -
 kexec/arch/ppc64/kexec-ppc64.c |   61 +++++++++++++++++++----------------------
 2 files changed, 30 insertions(+), 33 deletions(-)

--- kexec-tools-hacked.orig/configure.ac
+++ kexec-tools-hacked/configure.ac
@@ -59,7 +59,7 @@ if test "${host_alias}" ; then
 	OBJDIR="$OBJDIR-${host_alias}"
 fi 
 
-EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
+EXTRA_CFLAGS='-Wall -g -fno-strict-aliasing -Wstrict-prototypes $(CPPFLAGS) $(EXTRA_CPPFLAGS)'
 BUILD_CFLAGS='-O2 -Wall $(CPPFLAGS)'
 
 # Check whether ppc64. Add -m64 for building 64-bit binary
--- kexec-tools-hacked.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ kexec-tools-hacked/kexec/arch/ppc64/kexec-ppc64.c
@@ -45,10 +45,7 @@ unsigned long long crash_base, crash_siz
 unsigned int rtas_base, rtas_size;
 int max_memory_ranges;
 
-static int sort_base_ranges();
-
-
-static void cleanup_memory_ranges()
+static void cleanup_memory_ranges(void)
 {
 	if (memory_range)
 		free(memory_range);
@@ -64,7 +61,7 @@ static void cleanup_memory_ranges()
  * Allocate memory for various data structures used to hold
  * values of different memory ranges
  */
-static int alloc_memory_ranges()
+static int alloc_memory_ranges(void)
 {
 	int memory_range_len;
 
@@ -105,7 +102,7 @@ err1:
  * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
  * macro used earlier.
  */
-static int count_memory_ranges()
+static int count_memory_ranges(void)
 {
 	char device_tree[256] = "/proc/device-tree/";
 	struct dirent *dentry;
@@ -132,8 +129,32 @@ static int count_memory_ranges()
 	return 0;
 }
 
+/* Sort the base ranges in memory - this is useful for ensuring that our
+ * ranges are in ascending order, even if device-tree read of memory nodes
+ * is done differently. Also, could be used for other range coalescing later
+ */
+static int sort_base_ranges(void)
+{
+	int i, j;
+	unsigned long long tstart, tend;
+
+	for (i = 0; i < nr_memory_ranges - 1; i++) {
+		for (j = 0; j < nr_memory_ranges - i - 1; j++) {
+			if (base_memory_range[j].start > base_memory_range[j+1].start) {
+				tstart = base_memory_range[j].start;
+				tend = base_memory_range[j].end;
+				base_memory_range[j].start = base_memory_range[j+1].start;
+				base_memory_range[j].end = base_memory_range[j+1].end;
+				base_memory_range[j+1].start = tstart;
+				base_memory_range[j+1].end = tend;
+			}
+		}
+	}
+	return 0;
+}
+
 /* Get base memory ranges */
-static int get_base_ranges()
+static int get_base_ranges(void)
 {
 	int local_memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
@@ -204,32 +225,8 @@ static int get_base_ranges()
 	return 0;
 }
 
-/* Sort the base ranges in memory - this is useful for ensuring that our
- * ranges are in ascending order, even if device-tree read of memory nodes
- * is done differently. Also, could be used for other range coalescing later
- */
-static int sort_base_ranges()
-{
-	int i, j;
-	unsigned long long tstart, tend;
-
-	for (i = 0; i < nr_memory_ranges - 1; i++) {
-		for (j = 0; j < nr_memory_ranges - i - 1; j++) {
-			if (base_memory_range[j].start > base_memory_range[j+1].start) {
-				tstart = base_memory_range[j].start;
-				tend = base_memory_range[j].end;
-				base_memory_range[j].start = base_memory_range[j+1].start;
-				base_memory_range[j].end = base_memory_range[j+1].end;
-				base_memory_range[j+1].start = tstart;
-				base_memory_range[j+1].end = tend;
-			}
-		}
-	}
-	return 0;
-}
-
 /* Sort the exclude ranges in memory */
-static int sort_ranges()
+static int sort_ranges(void)
 {
 	int i, j;
 	unsigned long long tstart, tend;

-- 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
