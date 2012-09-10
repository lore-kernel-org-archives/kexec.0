Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d6-0001Y8-Rf
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:17 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1621323Ab2IJL5w
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:52 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 4/7] kexec: Add segregate_lowmem_region()
Date: Mon, 10 Sep 2012 13:57:48 +0200
Message-Id: <1347278271-5211-5-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1347278271-5211-4-git-send-email-daniel.kiper@oracle.com>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-3-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-4-git-send-email-daniel.kiper@oracle.com>
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
To: konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Extract code segregating lowmem region and move it to new
segregate_lowmem_region(). This function will be used by
fixed Xen kdump support, too.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index ec9432b..77a1329 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -159,6 +159,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 }
 
 /* Forward Declaration. */
+static void segregate_lowmem_region(int *nr_ranges, unsigned long lowmem_limit);
 static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end);
 
 /* Stores a sorted list of RAM memory ranges for which to create elf headers.
@@ -235,19 +236,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 		crash_memory_range[memory_ranges].start = start;
 		crash_memory_range[memory_ranges].end = end;
 		crash_memory_range[memory_ranges].type = type;
-		memory_ranges++;
 
-		/* Segregate linearly mapped region. */
-		if (lowmem_limit &&
-		    (lowmem_limit - 1) >= start && (lowmem_limit - 1) <= end) {
-			crash_memory_range[memory_ranges-1].end = lowmem_limit -1;
+		segregate_lowmem_region(&memory_ranges, lowmem_limit);
 
-			/* Add segregated region. */
-			crash_memory_range[memory_ranges].start = lowmem_limit;
-			crash_memory_range[memory_ranges].end = end;
-			crash_memory_range[memory_ranges].type = type;
-			memory_ranges++;
-		}
+		memory_ranges++;
 	}
 	fclose(fp);
 	if (kexec_flags & KEXEC_PRESERVE_CONTEXT) {
@@ -289,6 +281,30 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 	return 0;
 }
 
+static void segregate_lowmem_region(int *nr_ranges, unsigned long lowmem_limit)
+{
+	unsigned long long end, start;
+	unsigned type;
+
+	start = crash_memory_range[*nr_ranges].start;
+	end = crash_memory_range[*nr_ranges].end;
+	type = crash_memory_range[*nr_ranges].type;
+
+	if (!(lowmem_limit && lowmem_limit > start && lowmem_limit < end))
+		return;
+
+	crash_memory_range[*nr_ranges].end = lowmem_limit - 1;
+
+	if (*nr_ranges >= CRASH_MAX_MEMORY_RANGES - 1)
+		return;
+
+	++*nr_ranges;
+
+	crash_memory_range[*nr_ranges].start = lowmem_limit;
+	crash_memory_range[*nr_ranges].end = end;
+	crash_memory_range[*nr_ranges].type = type;
+}
+
 /* Removes crash reserve region from list of memory chunks for whom elf program
  * headers have to be created. Assuming crash reserve region to be a single
  * continuous area fully contained inside one of the memory chunks */
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
