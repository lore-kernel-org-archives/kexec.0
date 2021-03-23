Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOdqp-00EZ7V-UF
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 10:01:30 +0000
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/3] crashdump/x86: increase CRASH_MAX_MEMORY_RANGES to 32k
Date: Tue, 23 Mar 2021 11:01:10 +0100
Message-Id: <20210323100111.8365-4-david@redhat.com>
In-Reply-To: <20210323100111.8365-1-david@redhat.com>
References: <20210323100111.8365-1-david@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: David Hildenbrand <david@redhat.com>, Simon Horman <horms@verge.net.au>

virtio-mem in Linux adds/removes individual memory blocks (e.g., 128 MB
each). Linux merges adjacent memory blocks added by virtio-mem devices, but
we can still end up with a very sparse memory layout when unplugging
memory in corner cases.

Let's increase the maximum number of crash memory ranges from ~2k to 32k.
32k should be sufficient for a very long time.

e_phnum field in the header is 16 bits wide, so we can fit a maximum of
~64k entries in there, shared with other entries (i.e., CPU). Therefore,
using up to 32k memory ranges is fine. (if we ever need more than ~64k,
we can switch to the sh_info field)

Move the temporary xen ranges off the stack, dynamically allocating
memory for them.

Note: We don't have to increase MAX_MEMORY_RANGES, because virtio-mem
added memory is driver managed and always detected and added by a
driver in the kexec'ed kernel; for ordinary kexec, we must not expose
these ranges in the firmware-provided memmap.

Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 6 ++++--
 kexec/arch/i386/crashdump-x86.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 43e830a..df84185 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -355,8 +355,8 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 static int get_crash_memory_ranges_xen(struct memory_range **range,
 					int *ranges, unsigned long lowmem_limit)
 {
+	struct e820entry *e820entries;
 	int j, rc, ret = -1;
-	struct e820entry e820entries[CRASH_MAX_MEMORY_RANGES];
 	unsigned int i;
 	xc_interface *xc;
 
@@ -367,6 +367,8 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 		return -1;
 	}
 
+	e820entries = xmalloc(sizeof(*e820entries) * CRASH_MAX_MEMORY_RANGES);
+
 	rc = xc_get_machine_memory_map(xc, e820entries, CRASH_MAX_MEMORY_RANGES);
 
 	if (rc < 0) {
@@ -395,7 +397,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 
 err:
 	xc_interface_close(xc);
-
+	free(e820entries);
 	return ret;
 }
 #else
diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
index e4fdc82..479a549 100644
--- a/kexec/arch/i386/crashdump-x86.h
+++ b/kexec/arch/i386/crashdump-x86.h
@@ -22,7 +22,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 #define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
 
 #define CRASH_MAX_MEMMAP_NR	1024
-#define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
+
+#define CRASH_MAX_MEMORY_RANGES	32768
 
 /* Backup Region, First 640K of System RAM. */
 #define BACKUP_SRC_START	0x00000000
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
