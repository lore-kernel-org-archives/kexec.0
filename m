Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLtH-004vaR-MH
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:14 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 21/43] x86/KASLR: PKRAM: support physical kaslr
Date: Tue, 30 Mar 2021 14:35:56 -0700
Message-Id: <1617140178-8773-22-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

Avoid regions of memory that contain preserved pages when computing
slots used to select where to put the decompressed kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/boot/compressed/Makefile |   3 ++
 arch/x86/boot/compressed/kaslr.c  |  10 +++-
 arch/x86/boot/compressed/misc.h   |  10 ++++
 arch/x86/boot/compressed/pkram.c  | 109 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/boot/compressed/pkram.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc3988c3fa..ef27d411b641 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -93,6 +93,9 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
 	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev-es.o
+ifdef CONFIG_RANDOMIZE_BASE
+	vmlinux-objs-$(CONFIG_PKRAM) += $(obj)/pkram.o
+endif
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b92fffbe761f..a007363a7698 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -440,6 +440,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	struct setup_data *ptr;
 	u64 earliest = img->start + img->size;
 	bool is_overlapping = false;
+	struct mem_vector avoid;
 
 	for (i = 0; i < MEM_AVOID_MAX; i++) {
 		if (mem_overlaps(img, &mem_avoid[i]) &&
@@ -453,8 +454,6 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	/* Avoid all entries in the setup_data linked list. */
 	ptr = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
 	while (ptr) {
-		struct mem_vector avoid;
-
 		avoid.start = (unsigned long)ptr;
 		avoid.size = sizeof(*ptr) + ptr->len;
 
@@ -479,6 +478,12 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 		ptr = (struct setup_data *)(unsigned long)ptr->next;
 	}
 
+	if (pkram_has_overlap(img, &avoid) && (avoid.start < earliest)) {
+		*overlap = avoid;
+		earliest = overlap->start;
+		is_overlapping = true;
+	}
+
 	return is_overlapping;
 }
 
@@ -840,6 +845,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+	pkram_init();
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 901ea5ebec22..f8232ffd8141 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -116,6 +116,16 @@ static inline void console_init(void)
 { }
 #endif
 
+#ifdef CONFIG_PKRAM
+void pkram_init(void);
+int pkram_has_overlap(struct mem_vector *entry, struct mem_vector *overlap);
+#else
+static inline void pkram_init(void) { }
+static inline int pkram_has_overlap(struct mem_vector *entry,
+				    struct mem_vector *overlap);
+{ return 0; }
+#endif
+
 void set_sev_encryption_mask(void);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/boot/compressed/pkram.c b/arch/x86/boot/compressed/pkram.c
new file mode 100644
index 000000000000..60380f074c3f
--- /dev/null
+++ b/arch/x86/boot/compressed/pkram.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "misc.h"
+
+#define PKRAM_MAGIC		0x706B726D
+
+struct pkram_super_block {
+	__u32	magic;
+
+	__u64	node_pfn;
+	__u64	region_list_pfn;
+	__u64	nr_regions;
+};
+
+struct pkram_region {
+	phys_addr_t base;
+	phys_addr_t size;
+};
+
+struct pkram_region_list {
+	__u64	prev_pfn;
+	__u64	next_pfn;
+
+	struct pkram_region regions[0];
+};
+
+#define PKRAM_REGIONS_LIST_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_region_list))/sizeof(struct pkram_region))
+
+static u64 pkram_sb_pfn;
+static struct pkram_super_block *pkram_sb;
+
+void pkram_init(void)
+{
+	struct pkram_super_block *sb;
+	char arg[32];
+
+	if (cmdline_find_option("pkram", arg, sizeof(arg)) > 0) {
+		if (kstrtoull(arg, 16, &pkram_sb_pfn) != 0)
+			return;
+	} else
+		return;
+
+	sb = (struct pkram_super_block *)(pkram_sb_pfn << PAGE_SHIFT);
+	if (sb->magic != PKRAM_MAGIC) {
+		debug_putstr("PKRAM: invalid super block\n");
+		return;
+	}
+
+	pkram_sb = sb;
+}
+
+static struct pkram_region *pkram_first_region(struct pkram_super_block *sb, struct pkram_region_list **rlp, int *idx)
+{
+	if (!sb || !sb->region_list_pfn)
+		return NULL;
+
+	*rlp = (struct pkram_region_list *)(sb->region_list_pfn << PAGE_SHIFT);
+	*idx = 0;
+
+	return &(*rlp)->regions[0];
+}
+
+static struct pkram_region *pkram_next_region(struct pkram_region_list **rlp, int *idx)
+{
+	struct pkram_region_list *rl = *rlp;
+	int i = *idx;
+
+	i++;
+	if (i >= PKRAM_REGIONS_LIST_MAX) {
+		if (!rl->next_pfn) {
+			debug_putstr("PKRAM: no more pkram_region_list pages\n");
+			return NULL;
+		}
+		rl = (struct pkram_region_list *)(rl->next_pfn << PAGE_SHIFT);
+		*rlp = rl;
+		i = 0;
+	}
+	*idx = i;
+
+	if (rl->regions[i].size == 0)
+		return NULL;
+
+	return &rl->regions[i];
+}
+
+int pkram_has_overlap(struct mem_vector *entry, struct mem_vector *overlap)
+{
+	struct pkram_region_list *rl;
+	struct pkram_region *r;
+	int idx;
+
+	r = pkram_first_region(pkram_sb, &rl, &idx);
+
+	while (r) {
+		if (r->base + r->size <= entry->start) {
+			r = pkram_next_region(&rl, &idx);
+			continue;
+		}
+		if (r->base >= entry->start + entry->size)
+			return 0;
+
+		overlap->start = r->base;
+		overlap->size = r->size;
+		return 1;
+	}
+
+	return 0;
+}
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
