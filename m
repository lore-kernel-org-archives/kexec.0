Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pg133-00064e-Cy
	for kexec@lists.infradead.org; Thu, 20 Jan 2011 20:24:02 +0000
Date: Thu, 20 Jan 2011 14:26:42 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: kexec: Overlapping memory segments error
Message-ID: <20110120202642.GA22671@sgi.com>
References: <201101201314.27153.junk@willeweb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201101201314.27153.junk@willeweb.com>
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
To: wille <junk@willeweb.com>
Cc: kexec@lists.infradead.org




On Thu, Jan 20, 2011 at 01:14:27PM -0700, wille wrote:
> I am running a minimal system with a stripped down x86 2.6.32 Linux kernel.  
> >From this environment I kexec to an Ubuntu Lucid i386 2.6.32 kernel.  This 
> works fine on *most* hardware, but on some machines the kexec -l fails with 
> overlapping memory segments.
> 
> First I used the kexec which comes with the Lucid i386 distro (kexec-tools 
> 2.0.1 released 13th August 2009).  Then I built kexec from the head of the 
> git tree, which includes the patch "kexec: fix /sys/firmware/memmap memory 
> range overlaps".  I was hopeful this patch would fix my problem, but it 
> still fails with an "Overlapping memory segments" error.
> 
> As a specific example, on a Dell Latitude E6410 (which uses an Intel i7 
> processor) the kexec -l fails with the following messages:
> 
>     setup_linux_vesafb: 640x480x16 @ e1000000 +12c000
>     Overlapping memory segments at 0x7ffff000
> 
> One final clue: if I do the same kexec -l, but without the --initrd option I 
> don't get the "Overlapping memory segments..." message, but of course 
> without an initrd the system doesn't boot.
> 
> Any ideas?
> 
> -wille


Does your code have this patch?
It went into the community.
http://git.kernel.org/?p=utils/kernel/kexec/kexec-tools.git;a=blob;f=kexec/arch/i386/kexec-x86-common.c


To: kexec@lists.infradead.org
Subject: [PATCH] kexec: fix /sys/firmware/memmap memory range overlaps

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


-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
