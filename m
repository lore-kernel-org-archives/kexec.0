Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OdVK1-0000v0-H1
	for kexec@lists.infradead.org; Mon, 26 Jul 2010 21:34:54 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by relay3.corp.sgi.com (Postfix) with ESMTP id 1DB93AC001
	for <kexec@lists.infradead.org>; Mon, 26 Jul 2010 14:34:50 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id D5AE37000756
	for <kexec@lists.infradead.org>; Mon, 26 Jul 2010 16:34:49 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
	(envelope-from <cpw@sgi.com>) id 1OdVKg-00056N-Cd
	for kexec@lists.infradead.org; Mon, 26 Jul 2010 16:35:34 -0500
Subject: [PATCH] kexec: fix /sys/firmware/memmap memory range overlaps
Message-Id: <E1OdVKg-00056N-Cd@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Mon, 26 Jul 2010 16:35:34 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


The memory ranges derived from /sys/firmware/memmap may overlap, causing
the kexec command to fail to load the crash kernel.  The typical failure
reports 'Overlapping memory segments at 0x...'.

The preferred remedy might be to fix the BIOS or the kernel, but given
that they may at times generate overlaps, a check in the kexec command
will prevent crash dumps from being effectively disabled.

Diffed against git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 kexec/arch/i386/kexec-x86-common.c |   78 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

Index: kexec-tools/kexec/arch/i386/kexec-x86-common.c
===================================================================
--- kexec-tools.orig/kexec/arch/i386/kexec-x86-common.c
+++ kexec-tools/kexec/arch/i386/kexec-x86-common.c
@@ -129,6 +129,78 @@ static int get_memory_ranges_sysfs(struc
 	return 0;
 }
 
+static void remove_range(struct memory_range *range, int nr_ranges, int index)
+{
+	int i, j;
+
+	for (i = index; i < (nr_ranges-1); i++) {
+		j = i+1;
+		range[i] = range[j];
+	}
+}
+
+/**
+ * Verifies and corrects any overlapping ranges.
+ * The ranges array is assumed to be sorted already.
+ *
+ * @param[out] range pointer that will be set to an array that holds the
+ *             memory ranges
+ * @param[out] ranges number of ranges valid in @p range
+ *
+ * @return 0 on success, any other value on failure.
+ */
+static int fixup_memory_ranges_sysfs(struct memory_range **range, int *ranges)
+{
+	int i;
+	int j;
+	int change_made;
+	int nr_ranges = *ranges;
+	struct memory_range *rp = *range;
+
+again:
+	change_made = 0;
+	for (i = 0; i < (nr_ranges-1); i++) {
+		j = i+1;
+		if (rp[i].start > rp[j].start) {
+			fprintf(stderr, "sysfs memory out of order!!\n");
+			return 1;
+		}
+
+		if (rp[i].type != rp[j].type)
+			continue;
+
+		if (rp[i].start == rp[j].start) {
+			if (rp[i].end >= rp[j].end) {
+				remove_range(rp, nr_ranges, j);
+				nr_ranges--;
+				change_made++;
+			} else {
+				remove_range(rp, nr_ranges, i);
+				nr_ranges--;
+				change_made++;
+			}
+		} else {
+			if (rp[i].end > rp[j].start) {
+				if (rp[i].end < rp[j].end) {
+					rp[j].start = rp[i].end;
+					change_made++;
+				} else if (rp[i].end >= rp[j].end) {
+					remove_range(rp, nr_ranges, j);
+					nr_ranges--;
+					change_made++;
+				}
+			}
+		}
+	}
+
+	/* fixing/removing an entry may make it wrong relative to the next */
+	if (change_made)
+		goto again;
+
+	*ranges = nr_ranges;
+	return 0;
+}
+
 /**
  * Return a sorted list of memory ranges.
  *
@@ -155,9 +227,11 @@ int get_memory_ranges(struct memory_rang
 	 * even if we have /sys/firmware/memmap. Without that, /proc/vmcore
 	 * is empty in the kdump kernel.
 	 */
-	if (!xen_present() && have_sys_firmware_memmap())
+	if (!xen_present() && have_sys_firmware_memmap()) {
 		ret = get_memory_ranges_sysfs(range, ranges);
-	else
+		if (!ret)
+			ret = fixup_memory_ranges_sysfs(range, ranges);
+	} else
 		ret = get_memory_ranges_proc_iomem(range, ranges);
 
 	/*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
