Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JyTjo-0001je-An
	for kexec@lists.infradead.org; Tue, 20 May 2008 15:26:52 +0000
Date: Tue, 20 May 2008 11:26:40 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] PPC64: ensure that extra rtas segment is a multiple of
	PAGE_SIZE
Message-ID: <20080520152640.GB16652@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: nhorman@tuxdriver.com, horms@verge.net.au, ebiederm@xmission.com, vgoyal@redhat.com

kexec on ppc64 systems, include an extra PT_LOAD segment if the rtas memory hits
the stored kdump kernel image.  While the rtas area is memory mapped (implying
that it begins and ends on a page boundary), the whole of the mapped region is
not consumed by the rtas features (the remaining area just returns 0's).  This
unused area is not accounted in the rtas prom, which is used to populate the
proc files which export the size information that is used to define the mapped
memory region (/proc/device-tree/rtas/rtas-size).  Since this is the data that
kexec uses to generate the PT_LOAD segment, we wind up with a PT_LOAD segment
that incorrectly contains a partial page.  This causes things like makedumpfile
to fail, since it reads memory in page sized chunks, and fails on the inability
to read only part of a page.  This patch corrects that by rounding the extra
segment size up the next whole page size.  This is safe, since the rtas area is
mapped to a whole page range.  I've tested on both 4k and 64k configured kernels
on ppc64 and found that it works well.

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index e425346..1b88577 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -107,6 +107,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	struct dirent *dentry, *mentry;
 	int i, n, crash_rng_len = 0;
 	unsigned long long start, end, cstart, cend;
+	int page_size;
 
 	crash_max_memory_ranges = max_memory_ranges + 6;
 	crash_rng_len = sizeof(struct memory_range) * crash_max_memory_ranges;
@@ -213,12 +214,25 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	 */
 	if (crash_base < rtas_base + rtas_size &&
 		rtas_base < crash_base + crash_size) {
+		page_size = getpagesize();
 		cstart = rtas_base;
 		cend = rtas_base + rtas_size;
 		if (cstart < crash_base)
 			cstart = crash_base;
 		if (cend > crash_base + crash_size)
 			cend = crash_base + crash_size;
+		/*
+		 * The rtas section created here is formed by reading rtas-base
+		 * and rtas-size from /proc/device-tree/rtas.  Unfortunately
+		 * rtas-size is not required to be a multiple of PAGE_SIZE
+		 * The remainder of the page it ends on is just garbage, and is
+		 * safe to read, its just not accounted in rtas-size.  Since
+		 * we're creating an elf section here though, lets round it up
+		 * to the next page size boundary though, so makedumpfile can 
+		 * read it safely without going south on us.
+		 */
+		cend = (cend + page_size - 1) & (~(page_size - 1));
+
 		crash_memory_range[memory_ranges].start = cstart;
 		crash_memory_range[memory_ranges++].end = cend;
 	}
-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
