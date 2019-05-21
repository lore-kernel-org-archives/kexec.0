Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hSzGc-0007Az-Ra
 for kexec@lists.infradead.org; Tue, 21 May 2019 07:33:00 +0000
Received: from EX13MTAUEB001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (8.14.7/8.14.7) with
 ESMTP id x4L7WqYp068603
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Tue, 21 May 2019 07:32:56 GMT
From: Varad Gautam <vrd@amazon.de>
Subject: [PATCH 2/3] elf: Support ELF loading with relocation
Date: Tue, 21 May 2019 09:32:27 +0200
Message-ID: <1558423948-24583-2-git-send-email-vrd@amazon.de>
In-Reply-To: <1558423948-24583-1-git-send-email-vrd@amazon.de>
References: <1558423948-24583-1-git-send-email-vrd@amazon.de>
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
Cc: Varad Gautam <vrd@amazon.de>, David Woodhouse <dwmw@amazon.co.uk>

Add a helper to allow loading an image within specified address range.
This will be used to load multiboot2 images later.

Signed-off-by: Varad Gautam <vrd@amazon.de>
---
 kexec/kexec-elf-exec.c | 199 +++++++++++++++++++++++++++++++++----------------
 kexec/kexec-elf.h      |   7 ++
 2 files changed, 141 insertions(+), 65 deletions(-)

diff --git a/kexec/kexec-elf-exec.c b/kexec/kexec-elf-exec.c
index a9329ac..bea7b3e 100644
--- a/kexec/kexec-elf-exec.c
+++ b/kexec/kexec-elf-exec.c
@@ -11,6 +11,84 @@
 
 static const int probe_debug = 0;
 
+static void load_elf_segments(struct mem_ehdr *ehdr, struct kexec_info *info, unsigned long base)
+{
+	size_t i;
+
+	/* Read in the PT_LOAD segments */
+	for(i = 0; i < ehdr->e_phnum; i++) {
+		struct mem_phdr *phdr;
+		size_t size;
+		phdr = &ehdr->e_phdr[i];
+		if (phdr->p_type != PT_LOAD) {
+			continue;
+		}
+		size = phdr->p_filesz;
+		if (size > phdr->p_memsz) {
+			size = phdr->p_memsz;
+		}
+		add_segment(info, phdr->p_data, size,
+					phdr->p_paddr + base, phdr->p_memsz);
+	}
+}
+
+static int get_elf_exec_load_base(struct mem_ehdr *ehdr, struct kexec_info *info,
+				  unsigned long min, unsigned long max,
+				  unsigned long align, unsigned long *base)
+{
+	unsigned long first, last;
+	size_t i;
+
+	/* Note on arm64:
+	 * arm64's vmlinux has virtual address in physical address
+	 * field of PT_LOAD segments. So the following validity check
+	 * and relocation makes no sense on arm64.
+	 */
+	if (ehdr->e_machine == EM_AARCH64)
+		return 0;
+
+	first = ULONG_MAX;
+	last  = 0;
+	for(i = 0; i < ehdr->e_phnum; i++) {
+		unsigned long start, stop;
+		struct mem_phdr *phdr;
+		phdr = &ehdr->e_phdr[i];
+		if ((phdr->p_type != PT_LOAD) ||
+			(phdr->p_memsz == 0))
+		{
+			continue;
+		}
+		start = phdr->p_paddr;
+		stop  = start + phdr->p_memsz;
+		if (first > start) {
+			first = start;
+		}
+		if (last < stop) {
+			last = stop;
+		}
+		if (align < phdr->p_align) {
+			align = phdr->p_align;
+		}
+	}
+
+	if ((max - min) < (last - first))
+		return -1;
+
+	if (!valid_memory_range(info, min > first ? min : first, max < last ? max : last)) {
+		unsigned long hole;
+		hole = locate_hole(info, last - first + 1, align, min, max, 1);
+		if (hole == ULONG_MAX)
+			return -1;
+
+		/* Base is the value that when added
+		 * to any virtual address in the file
+		 * yields it's load virtual address.
+		 */
+		*base = hole - first;
+	}
+	return 0;
+}
+
 int build_elf_exec_info(const char *buf, off_t len, struct mem_ehdr *ehdr,
 				uint32_t flags)
 {
@@ -53,7 +131,6 @@ int elf_exec_load(struct mem_ehdr *ehdr, struct kexec_info *info)
 {
 	unsigned long base;
 	int result;
-	size_t i;
 
 	if (!ehdr->e_phdr) {
 		fprintf(stderr, "No program header?\n");
@@ -63,75 +140,48 @@ int elf_exec_load(struct mem_ehdr *ehdr, struct kexec_info *info)
 
 	/* If I have a dynamic executable find it's size
 	 * and then find a location for it in memory.
-	 * Note on arm64:
-	 * arm64's vmlinux has virtual address in physical address
-	 * field of PT_LOAD segments. So the following validity check
-	 * and relocation makes no sense on arm64.
 	 */
 	base = 0;
-	if ((ehdr->e_machine != EM_AARCH64) && (ehdr->e_type == ET_DYN)) {
-		unsigned long first, last, align;
-		first = ULONG_MAX;
-		last  = 0;
-		align = 0;
-		for(i = 0; i < ehdr->e_phnum; i++) {
-			unsigned long start, stop;
-			struct mem_phdr *phdr;
-			phdr = &ehdr->e_phdr[i];
-			if ((phdr->p_type != PT_LOAD) ||
-				(phdr->p_memsz == 0))
-			{
-				continue;
-			}
-			start = phdr->p_paddr;
-			stop  = start + phdr->p_memsz;
-			if (first > start) {
-				first = start;
-			}
-			if (last < stop) {
-				last = stop;
-			}
-			if (align < phdr->p_align) {
-				align = phdr->p_align;
-			}
-		}
-		/* If I can't use the default paddr find a new
-		 * hole for the dynamic executable.
-		 */
-		if (!valid_memory_range(info, first, last)) {
-			unsigned long hole;
-			hole = locate_hole(info,
-				last - first + 1, align, 
-				0, elf_max_addr(ehdr), 1);
-			if (hole == ULONG_MAX) {
-				result = -1;
-				goto out;
-			}
-			/* Base is the value that when added
-			 * to any virtual address in the file
-			 * yields it's load virtual address.
-			 */
-			base = hole - first;
-		}
-
+	if (ehdr->e_type == ET_DYN) {
+		result = get_elf_exec_load_base(ehdr, info, 0, elf_max_addr(ehdr), 0 /* align */, &base);
+		if (result < 0)
+			goto out;
 	}
 
-	/* Read in the PT_LOAD segments */
-	for(i = 0; i < ehdr->e_phnum; i++) {
-		struct mem_phdr *phdr;
-		size_t size;
-		phdr = &ehdr->e_phdr[i];
-		if (phdr->p_type != PT_LOAD) {
-			continue;
-		}
-		size = phdr->p_filesz;
-		if (size > phdr->p_memsz) {
-			size = phdr->p_memsz;
-		}
-		add_segment(info,
-			phdr->p_data, size,
-			phdr->p_paddr + base, phdr->p_memsz);
+	load_elf_segments(ehdr, info, base);
+
+	/* Update entry point to reflect new load address*/
+	ehdr->e_entry += base;
+
+	result = 0;
+ out:
+	return result;
+}
+
+int elf_exec_load_relocatable(struct mem_ehdr *ehdr, struct kexec_info *info,
+			      unsigned long reloc_min, unsigned long reloc_max,
+			      unsigned long align)
+{
+	unsigned long base;
+	int result;
+
+	if (reloc_min > reloc_max) {
+		fprintf(stderr, "Bad relocation range, start=%lux > end=%lux.\n", reloc_min, reloc_max);
+		result = -1;
+		goto out;
 	}
+	if (!ehdr->e_phdr) {
+		fprintf(stderr, "No program header?\n");
+		result = -1;
+		goto out;
+	}
+
+	base = 0;
+	result = get_elf_exec_load_base(ehdr, info, reloc_min, reloc_max, align, &base);
+	if (result < 0)
+		goto out;
+
+	load_elf_segments(ehdr, info, base);
 
 	/* Update entry point to reflect new load address*/
 	ehdr->e_entry += base;
@@ -157,3 +207,22 @@ void elf_exec_build_load(struct kexec_info *info, struct mem_ehdr *ehdr,
 		die("ELF exec load failed\n");
 	}
 }
+
+void elf_exec_build_load_relocatable(struct kexec_info *info, struct mem_ehdr *ehdr,
+				     const char *buf, off_t len, uint32_t flags,
+				     unsigned long reloc_min, unsigned long reloc_max,
+				     unsigned long align)
+{
+	int result;
+	/* Parse the Elf file */
+	result = build_elf_exec_info(buf, len, ehdr, flags);
+	if (result < 0) {
+		die("%s: ELF exec parse failed\n", __func__);
+	}
+
+	/* Load the Elf data */
+	result = elf_exec_load_relocatable(ehdr, info, reloc_min, reloc_max, align);
+	if (result < 0) {
+		die("%s: ELF exec load failed\n", __func__);
+	}
+}
\ No newline at end of file
diff --git a/kexec/kexec-elf.h b/kexec/kexec-elf.h
index 1164db4..1e512c8 100644
--- a/kexec/kexec-elf.h
+++ b/kexec/kexec-elf.h
@@ -100,11 +100,18 @@ extern int build_elf_rel_info(const char *buf, off_t len, struct mem_ehdr *ehdr,
 extern int build_elf_core_info(const char *buf, off_t len,
 					struct mem_ehdr *ehdr, uint32_t flags);
 extern int elf_exec_load(struct mem_ehdr *ehdr, struct kexec_info *info);
+extern int elf_exec_load_relocatable(struct mem_ehdr *ehdr, struct kexec_info *info,
+				     unsigned long reloc_min, unsigned long reloc_max,
+				     unsigned long align);
 extern int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 	unsigned long min, unsigned long max, int end);
 
 extern void elf_exec_build_load(struct kexec_info *info, struct mem_ehdr *ehdr, 
 				const char *buf, off_t len, uint32_t flags);
+extern void elf_exec_build_load_relocatable(struct kexec_info *info, struct mem_ehdr *ehdr,
+					    const char *buf, off_t len, uint32_t flags,
+					    unsigned long reloc_min, unsigned long reloc_max,
+					    unsigned long align);
 extern void elf_rel_build_load(struct kexec_info *info, struct mem_ehdr *ehdr, 
 	const char *buf, off_t len, unsigned long min, unsigned long max, 
 	int end, uint32_t flags);
-- 
2.7.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
