Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjH7D-00010G-2e
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 22:18:54 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v6 6/6] kexec, x86: handle Crash low kernel range
Date: Thu, 13 Dec 2012 14:18:32 -0800
Message-Id: <1355437112-9250-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1355437112-9250-1-git-send-email-yinghai@kernel.org>
References: <1355437112-9250-1-git-send-email-yinghai@kernel.org>
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
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

kernel could have that in /proc/iomem, will use it for kdump kernel
for dma32

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/arch/i386/crashdump-x86.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 245402c..83bff5e 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -188,6 +188,8 @@ static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
 
 /* Memory region reserved for storing panic kernel and other data. */
 static struct memory_range crash_reserved_mem;
+/* under 4G parts */
+static struct memory_range crash_reserved_low_mem;
 
 /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
  * create Elf headers. Keeping it separate from get_memory_ranges() as
@@ -282,6 +284,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 	if (exclude_region(&memory_ranges, crash_reserved_mem.start,
 				crash_reserved_mem.end) < 0)
 		return -1;
+	if (crash_reserved_low_mem.start &&
+	    exclude_region(&memory_ranges, crash_reserved_low_mem.start,
+				crash_reserved_low_mem.end) < 0)
+		return -1;
 	if (gart) {
 		/* exclude GART region if the system has one */
 		if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
@@ -984,6 +990,12 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		return ENOCRASHKERNEL;
 	}
 
+	if (crash_reserved_low_mem.start) {
+		sz = crash_reserved_low_mem.end - crash_reserved_low_mem.start
+					 +1;
+		add_memmap(memmap_p, crash_reserved_low_mem.start, sz);
+	}
+
 	/* Create a backup region segment to store backup data*/
 	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
 		sz = (info->backup_src_size + align) & ~(align - 1);
@@ -1059,5 +1071,14 @@ int is_crashkernel_mem_reserved(void)
 	crash_reserved_mem.end = end;
 	crash_reserved_mem.type = RANGE_RAM;
 
+	/* If there is no Crash low kernel, still can go on */
+	if (parse_iomem_single("Crash kernel low\n", &start, &end) ||
+					start == end)
+		return 1;
+
+	crash_reserved_low_mem.start = start;
+	crash_reserved_low_mem.end = end;
+	crash_reserved_low_mem.type = RANGE_RAM;
+
 	return 1;
 }
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
