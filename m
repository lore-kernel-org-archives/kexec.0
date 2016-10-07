Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsMci-0004RW-8z
 for kexec@lists.infradead.org; Fri, 07 Oct 2016 04:19:05 +0000
Date: Fri, 7 Oct 2016 12:18:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 2/8] kexec: generalize and rename get_kernel_stext_sym()
Message-ID: <20161007041837.GC16400@dhcp-128-65.nay.redhat.com>
References: <20160907043401.6403-1-takahiro.akashi@linaro.org>
 <20160907043401.6403-3-takahiro.akashi@linaro.org>
 <b88cbd6b-923d-d0c9-ce23-b9ef99aca256@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b88cbd6b-923d-d0c9-ce23-b9ef99aca256@gmail.com>
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
To: Matthias Brugger <matthias.bgg@gmail.com>, panand@redhat.com
Cc: public-panand-H+wXaHxf7aLQT0dZR+AlfA@plane.gmane.org, public-kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@plane.gmane.org, kexec@lists.infradead.org, public-geoff-wEGCiKHe2LqWVfeAwA7xHQ@plane.gmane.org

> >  	/* Traverse through the Elf headers and find the region where
> >  	 * _stext symbol is located in. That's where kernel is mapped */
> > -	stext_sym = get_kernel_stext_sym();
> > +	stext_sym = get_kernel_sym("stext");
> 
> 
> I think this should be get_kernel_sym("_stext");
> 
> Apart from that as Simon already mentioned, due to commit
> 9f62cbd ("kexec/arch/i386: Add support for KASLR memory randomization")
> this patch does not apply cleanly.

Pratyush, I had a cleanup patch below, but I did not get time to test it
so it is not ready to send out.

The basic thought is to move the page_offset_base code to
get_kernel_page_offset(), there is also another issue is for old kernel
or kernel without kaslr built-in there will be an unnecessary error
message but I have not get any idea how to fix it.

Would you like to take below cleanup patch along with your next version?
It is also fine to leave it as a future improvement to me.

Thanks
Dave

---
 kexec/arch/i386/crashdump-x86.c |  158 ++++++++++++++++++++--------------------
 1 file changed, 82 insertions(+), 76 deletions(-)

--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -54,10 +54,59 @@
 
 extern struct arch_options_t arch_options;
 
+/* Retrieve kernel symbol virtual address from /proc/kallsyms */
+static unsigned long long get_kernel_sym(const char *symbol)
+{
+	const char *kallsyms = "/proc/kallsyms";
+	char sym[128];
+	char line[128];
+	FILE *fp;
+	unsigned long long vaddr;
+	char type;
+
+	fp = fopen(kallsyms, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s\n", kallsyms);
+		return 0;
+	}
+
+	while(fgets(line, sizeof(line), fp) != NULL) {
+		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
+			continue;
+		if (strcmp(sym, symbol) == 0) {
+			dbgprintf("kernel symbol %s vaddr = %16llx\n", symbol, vaddr);
+			return vaddr;
+		}
+	}
+
+	fprintf(stderr, "Cannot get kernel %s symbol address\n", symbol);
+
+	return 0;
+}
+
 static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
-				  struct crash_elf_info *elf_info)
+				  struct crash_elf_info *elf_info,
+				  struct mem_ehdr *ehdr)
 {
 	int kv;
+	struct mem_phdr *phdr, *end_phdr;
+	const unsigned long long pud_mask = ~((1 << 30) - 1);
+	unsigned long long vaddr, lowest_vaddr = 0;
+
+	end_phdr = &ehdr->e_phdr[ehdr->e_phnum];
+	/* Search for the real PAGE_OFFSET when KASLR memory randomization
+	 * is enabled */
+	if (get_kernel_sym("page_offset_base") != 0) {
+		for(phdr = ehdr->e_phdr; phdr != end_phdr; phdr++) {
+			if (phdr->p_type == PT_LOAD) {
+				vaddr = phdr->p_vaddr & pud_mask;
+				if (lowest_vaddr == 0 || lowest_vaddr > vaddr)
+					lowest_vaddr = vaddr;
+			}
+		}
+		if (lowest_vaddr != 0)
+			elf_info->page_offset = lowest_vaddr;
+	}
 
 	if (elf_info->machine == EM_X86_64) {
 		kv = kernel_version();
@@ -102,35 +151,6 @@ static int get_kernel_paddr(struct kexec
 	return -1;
 }
 
-/* Retrieve kernel symbol virtual address from /proc/kallsyms */
-static unsigned long long get_kernel_sym(const char *symbol)
-{
-	const char *kallsyms = "/proc/kallsyms";
-	char sym[128];
-	char line[128];
-	FILE *fp;
-	unsigned long long vaddr;
-	char type;
-
-	fp = fopen(kallsyms, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s\n", kallsyms);
-		return 0;
-	}
-
-	while(fgets(line, sizeof(line), fp) != NULL) {
-		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
-			continue;
-		if (strcmp(sym, symbol) == 0) {
-			dbgprintf("kernel symbol %s vaddr = %16llx\n", symbol, vaddr);
-			return vaddr;
-		}
-	}
-
-	fprintf(stderr, "Cannot get kernel %s symbol address\n", symbol);
-	return 0;
-}
-
 /* Retrieve info regarding virtual address kernel has been compiled for and
  * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
  * from kexec-tools fails because of malformed elf notes. A kernel patch has
@@ -139,19 +159,12 @@ static unsigned long long get_kernel_sym
  * we should get rid of backward compatible code. */
 
 static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
-				     struct crash_elf_info *elf_info)
+				     struct crash_elf_info *elf_info,
+				     struct mem_ehdr *ehdr)
 {
-	int result;
-	const char kcore[] = "/proc/kcore";
-	char *buf;
-	struct mem_ehdr ehdr;
 	struct mem_phdr *phdr, *end_phdr;
 	int align;
-	off_t size;
-	uint32_t elf_flags = 0;
 	uint64_t stext_sym;
-	const unsigned long long pud_mask = ~((1 << 30) - 1);
-	unsigned long long vaddr, lowest_vaddr = 0;
 
 	if (elf_info->machine != EM_X86_64)
 		return 0;
@@ -160,45 +173,13 @@ static int get_kernel_vaddr_and_size(str
 		return 0;
 
 	align = getpagesize();
-	buf = slurp_file_len(kcore, KCORE_ELF_HEADERS_SIZE, &size);
-	if (!buf) {
-		fprintf(stderr, "Cannot read %s: %s\n", kcore, strerror(errno));
-		return -1;
-	}
 
-	/* Don't perform checks to make sure stated phdrs and shdrs are
-	 * actually present in the core file. It is not practical
-	 * to read the GB size file into a user space buffer, Given the
-	 * fact that we don't use any info from that.
-	 */
-	elf_flags |= ELF_SKIP_FILESZ_CHECK;
-	result = build_elf_core_info(buf, size, &ehdr, elf_flags);
-	if (result < 0) {
-		/* Perhaps KCORE_ELF_HEADERS_SIZE is too small? */
-		fprintf(stderr, "ELF core (kcore) parse failed\n");
-		return -1;
-	}
-
-	end_phdr = &ehdr.e_phdr[ehdr.e_phnum];
-
-	/* Search for the real PAGE_OFFSET when KASLR memory randomization
-	 * is enabled */
-	if (get_kernel_sym("page_offset_base") != 0) {
-		for(phdr = ehdr.e_phdr; phdr != end_phdr; phdr++) {
-			if (phdr->p_type == PT_LOAD) {
-				vaddr = phdr->p_vaddr & pud_mask;
-				if (lowest_vaddr == 0 || lowest_vaddr > vaddr)
-					lowest_vaddr = vaddr;
-			}
-		}
-		if (lowest_vaddr != 0)
-			elf_info->page_offset = lowest_vaddr;
-	}
+	end_phdr = &ehdr->e_phdr[ehdr->e_phnum];
 
 	/* Traverse through the Elf headers and find the region where
 	 * _stext symbol is located in. That's where kernel is mapped */
 	stext_sym = get_kernel_sym("_stext");
-	for(phdr = ehdr.e_phdr; stext_sym && phdr != end_phdr; phdr++) {
+	for(phdr = ehdr->e_phdr; stext_sym && phdr != end_phdr; phdr++) {
 		if (phdr->p_type == PT_LOAD) {
 			unsigned long long saddr = phdr->p_vaddr;
 			unsigned long long eaddr = phdr->p_vaddr + phdr->p_memsz;
@@ -223,7 +204,7 @@ static int get_kernel_vaddr_and_size(str
 	 * /proc/kallsyms, Traverse through the Elf headers again and
 	 * find the region where kernel is mapped using hard-coded
 	 * kernel mapping boundries */
-	for(phdr = ehdr.e_phdr; phdr != end_phdr; phdr++) {
+	for(phdr = ehdr->e_phdr; phdr != end_phdr; phdr++) {
 		if (phdr->p_type == PT_LOAD) {
 			unsigned long long saddr = phdr->p_vaddr;
 			unsigned long long eaddr = phdr->p_vaddr + phdr->p_memsz;
@@ -887,6 +868,12 @@ int load_crashdump_segments(struct kexec
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
 	unsigned kexec_arch;
+	char *buf;
+	off_t size;
+	struct mem_ehdr ehdr;
+	uint32_t elf_flags = 0;
+	const char kcore[] = "/proc/kcore";
+	int result;
 
 	memset(&elf_info, 0x0, sizeof(elf_info));
 
@@ -943,13 +930,32 @@ int load_crashdump_segments(struct kexec
 		elf_info.class = ELFCLASS64;
 	}
 
-	if (get_kernel_page_offset(info, &elf_info))
+	buf = slurp_file_len(kcore, KCORE_ELF_HEADERS_SIZE, &size);
+	if (!buf) {
+		fprintf(stderr, "Cannot read %s: %s\n", kcore, strerror(errno));
+		return -1;
+	}
+
+	/* Don't perform checks to make sure stated phdrs and shdrs are
+	 * actually present in the core file. It is not practical
+	 * to read the GB size file into a user space buffer, Given the
+	 * fact that we don't use any info from that.
+	 */
+	elf_flags |= ELF_SKIP_FILESZ_CHECK;
+	result = build_elf_core_info(buf, size, &ehdr, elf_flags);
+	if (result < 0) {
+		/* Perhaps KCORE_ELF_HEADERS_SIZE is too small? */
+		fprintf(stderr, "ELF core (kcore) parse failed\n");
+		return -1;
+	}
+
+	if (get_kernel_page_offset(info, &elf_info, &ehdr))
 		return -1;
 
 	if (get_kernel_paddr(info, &elf_info))
 		return -1;
 
-	if (get_kernel_vaddr_and_size(info, &elf_info))
+	if (get_kernel_vaddr_and_size(info, &elf_info, &ehdr))
 		return -1;
 
 	/* Memory regions which panic kernel can safely use to boot into */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
