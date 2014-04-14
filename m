Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZiIq-0001Vm-Sn
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 14:56:09 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v6 1/9] x86,
 cleanup: add extra arguments to add_memmap() and delete_memmap()
Date: Mon, 14 Apr 2014 22:55:33 +0800
Message-Id: <1397487341-17287-2-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
References: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

This change will be used later:

add_memmap(.., int *nr_memmap, .., int type);
delete_memmap(.., int *nr_memmap, ..);

memmap_p[] is statically allocated for a certain amount. It will be used
later when mapping these memory maps to e820 map.

It's convenient to keep track of the count of memmap_p (nr_memmap) in
add_memmap and delete_memmap, because the counting has already been
taken care of in these two functions.

The original add_memmap() can only add memory range of RANGE_RAM type.
For adding other types of memory range, add another argument for
indicating the type.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 72bce0b..dfcce17 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -476,8 +476,8 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 
 /* Adds a segment from list of memory regions which new kernel can use to
  * boot. Segment start and end should be aligned to 1K boundary. */
-static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
-								size_t size)
+static int add_memmap(struct memory_range *memmap_p, int *nr_memmap,
+			unsigned long long addr, size_t size, int type)
 {
 	int i, j, nr_entries = 0, tidx = 0, align = 1024;
 	unsigned long long mstart, mend;
@@ -514,6 +514,8 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
 		memmap_p[j+1] = memmap_p[j];
 	memmap_p[tidx].start = addr;
 	memmap_p[tidx].end = addr + size - 1;
+	memmap_p[tidx].type = type;
+	*nr_memmap = nr_entries + 1;
 
 	dbgprintf("Memmap after adding segment\n");
 	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
@@ -530,8 +532,8 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
 
 /* Removes a segment from list of memory regions which new kernel can use to
  * boot. Segment start and end should be aligned to 1K boundary. */
-static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
-								size_t size)
+static int delete_memmap(struct memory_range *memmap_p, int *nr_memmap,
+				unsigned long long addr, size_t size)
 {
 	int i, j, nr_entries = 0, tidx = -1, operation = 0, align = 1024;
 	unsigned long long mstart, mend;
@@ -593,12 +595,14 @@ static int delete_memmap(struct memory_range *memmap_p, unsigned long long addr,
 		for (j = nr_entries-1; j > tidx; j--)
 			memmap_p[j+1] = memmap_p[j];
 		memmap_p[tidx+1] = temp_region;
+		*nr_memmap = nr_entries + 1;
 	}
 	if ((operation == -1) && tidx >=0) {
 		/* Delete the exact match memory region. */
 		for (j = i+1; j < CRASH_MAX_MEMMAP_NR; j++)
 			memmap_p[j-1] = memmap_p[j];
 		memmap_p[j-1].start = memmap_p[j-1].end = 0;
+		*nr_memmap = nr_entries - 1;
 	}
 
 	dbgprintf("Memmap after deleting segment\n");
@@ -865,7 +869,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 {
 	void *tmp;
 	unsigned long sz, bufsz, memsz, elfcorehdr;
-	int nr_ranges = 0, align = 1024, i;
+	int nr_ranges = 0, nr_memmap = 0, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 	unsigned kexec_arch;
@@ -941,10 +945,10 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	sz = (sizeof(struct memory_range) * CRASH_MAX_MEMMAP_NR);
 	memmap_p = xmalloc(sz);
 	memset(memmap_p, 0, sz);
-	add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
+	add_memmap(memmap_p, &nr_memmap, info->backup_src_start, info->backup_src_size, RANGE_RAM);
 	for (i = 0; i < crash_reserved_mem_nr; i++) {
 		sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
-		if (add_memmap(memmap_p, crash_reserved_mem[i].start, sz) < 0)
+		if (add_memmap(memmap_p, &nr_memmap, crash_reserved_mem[i].start, sz, RANGE_RAM) < 0)
 			return ENOCRASHKERNEL;
 	}
 
@@ -957,7 +961,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 						0, max_addr, -1);
 		dbgprintf("Created backup segment at 0x%lx\n",
 			  info->backup_start);
-		if (delete_memmap(memmap_p, info->backup_start, sz) < 0)
+		if (delete_memmap(memmap_p, &nr_memmap, info->backup_start, sz) < 0)
 			return EFAILED;
 	}
 
@@ -993,7 +997,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
 							max_addr, -1);
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
-	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
+	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
 		return -1;
 	cmdline_add_memmap(mod_cmdline, memmap_p);
 	if (!bzImage_support_efi_boot)
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
