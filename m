Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PT3Do-0005iP-16
	for kexec@lists.infradead.org; Thu, 16 Dec 2010 02:05:34 +0000
Date: Thu, 16 Dec 2010 11:05:17 +0900
From: Simon Horman <horms@verge.net.au>
Subject: mips: elfinfo
Message-ID: <20101216020514.GJ3558@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org
Cc: Maxim Uvarov <muvarov@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Hi Maxim,

I noticed that your change "Patch adds kernel data section to final vmcore.
This forces gdb read kernel" causes the build to break as it was applied
after Eric's "crashdump: Move kern_vaddr_start from kexec_info into
crash_elf_info" patch.

I have it in mind to resolve this something along the lines of
the patch below. However, I now see the following warning:

	kexec/arch/mips/crashdump-mips.c: In function `get_kernel_vaddr_and_size':
	kexec/arch/mips/crashdump-mips.c:81: warning: integer constant is too large for "unsigned long" type

Which corresponds to this code:

        elf_info->kern_vaddr_start = elf_info->kern_paddr_start |
                                        0xffffffff80000000UL;

I am compiling for 32-bit, so at a glance that constant does
seem to large.

Also, if you have any tips on a cross-compiling environment for 64bit
on a x86_32 or x86_64 host I would be most grateful.


diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 5ea4f4f..b937ab5 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -51,7 +51,7 @@ unsigned long long saved_max_mem;
 
 /* Read kernel physical load addr from the file returned by proc_iomem()
  * (Kernel Code) and store in kexec_info */
-static int get_kernel_paddr(struct kexec_info *info)
+static int get_kernel_paddr(struct crash_elf_info *elf_info)
 {
 	uint64_t start;
 
@@ -59,7 +59,7 @@ static int get_kernel_paddr(struct kexec_info *info)
 		return 0;
 
 	if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
-		info->kern_paddr_start = start;
+		elf_info->kern_paddr_start = start;
 #ifdef DEBUG
 		printf("kernel load physical addr start = 0x%lx\n", start);
 #endif
@@ -70,21 +70,22 @@ static int get_kernel_paddr(struct kexec_info *info)
 	return -1;
 }
 
-static int get_kernel_vaddr_and_size(struct kexec_info *info)
+static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info)
 {
 	uint64_t end;
 
-	if (!info->kern_paddr_start)
+	if (!elf_info->kern_paddr_start)
 		return -1;
 
-	info->kern_vaddr_start =  info->kern_paddr_start | 0xffffffff80000000UL;
+	elf_info->kern_vaddr_start = elf_info->kern_paddr_start |
+					0xffffffff80000000UL;
 	if (parse_iomem_single("Kernel data\n", NULL, &end) == 0) {
-		info->kern_size = end - info->kern_paddr_start;
+		elf_info->kern_size = end - elf_info->kern_paddr_start;
 #ifdef DEBUG
 		printf("kernel_vaddr= 0x%llx paddr %llx\n",
-				info->kern_vaddr_start,
-				info->kern_paddr_start);
-		printf("kernel size = 0x%llx\n", info->kern_size);
+				elf_info->kern_vaddr_start,
+				elf_info->kern_paddr_start);
+		printf("kernel size = 0x%llx\n", elf_info->kern_size);
 #endif
 		return 0;
 		}
@@ -355,11 +356,20 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	unsigned long sz, elfcorehdr;
 	int nr_ranges, align = 1024;
 	struct memory_range *mem_range;
+	crash_create_elf_headers_func crash_create = crash_create_elf32_headers;
+	struct crash_elf_info *elf_info = &elf_info32;
 
-	if (get_kernel_paddr(info))
+#ifdef __mips64
+	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
+		elf_info = &elf_info64;
+		crash_create = crash_create_elf64;
+	}
+#endif
+
+	if (get_kernel_paddr(elf_info))
 		return -1;
 
-	if (get_kernel_vaddr_and_size(info))
+	if (get_kernel_vaddr_and_size(elf_info))
 		return -1;
 
 	if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
@@ -373,28 +383,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 				crash_reserved_mem.start,
 				crash_reserved_mem.end, -1);
 
-#ifdef __mips64
-	/* Create elf header segment and store crash image data. */
-	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
-		if (crash_create_elf64_headers(info, &elf_info64,
-			crash_memory_range, nr_ranges,
-			&tmp, &sz,
-			ELF_CORE_HEADER_ALIGN) < 0)
-			return -1;
-	} else {
-		if (crash_create_elf32_headers(info, &elf_info32,
-			crash_memory_range, nr_ranges,
-			&tmp, &sz,
-			ELF_CORE_HEADER_ALIGN) < 0)
-			return -1;
-	}
-#else
-	if (crash_create_elf32_headers(info, &elf_info32,
-		crash_memory_range, nr_ranges,
-		&tmp, &sz,
-		ELF_CORE_HEADER_ALIGN) < 0)
+	if (crash_create(info, elf_info, crash_memory_range, nr_ranges,
+			 &tmp, &sz, ELF_CORE_HEADER_ALIGN) < 0)
 		return -1;
-#endif
 	elfcorehdr = add_buffer(info, tmp, sz, sz, align,
 		crash_reserved_mem.start,
 		crash_reserved_mem.end, -1);
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index eccdb9f..060bb88 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -35,6 +35,13 @@ struct crash_elf_info {
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
 };
 
+typedef int(*crash_create_elf_headers_func)(struct kexec_info *info,
+					    struct crash_elf_info *elf_info,
+					    struct memory_range *range,
+					    int ranges,
+					    void **buf, unsigned long *size,
+					    unsigned long align);
+
 int crash_create_elf32_headers(struct kexec_info *info,
 			       struct crash_elf_info *elf_info,
 			       struct memory_range *range, int ranges,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
