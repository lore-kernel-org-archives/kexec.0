Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnlZd-008Upa-M4
 for kexec@lists.infradead.org; Thu, 18 Nov 2021 17:51:51 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 7/8] crash hp: Add x86 crash hotplug support for
 kexec_file_load
Date: Thu, 18 Nov 2021 12:49:47 -0500
Message-Id: <20211118174948.37435-8-eric.devolder@oracle.com>
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, eric.devolder@oracle.com

When CPU or memory is hot un/plugged, the crash elfcorehdr which
describes the CPUs and memory in the system, must also be updated.

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory, and placed into
memory. Since purgatory also does an integrity check via hash
digests of the loaded segments, purgatory must also be updated
with the new digests.

Once the new elfcorehdr and purgatory contents are fully prepared
and no errors occur, they are installed over the top of the
existing segments. As a result, no changes to boot_params are
needed as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct.)

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item. The
purgatory segment was already properly sized at load time.

NOTE that this only supports kexec_file_load. Support for
kexec_load is not possible since the userland-supplied purgatory
segment is a binary blob that can not readily be decoded so as to
be updated with the new hash digests.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 255 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 254 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..d08e112cd345 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,9 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -265,7 +268,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -397,7 +401,16 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
+	/* For marking as usable to crash kernel */
+	image->elf_headers_sz = kbuf.memsz;
+	/* Record the index of the elfcorehdr segment */
+	image->arch.hp.elf_index = image->nr_segments;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +425,243 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void *map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	/*
+	 * NOTE: The addresses and sizes passed to this routine have
+	 * already been fully aligned on page boundaries. There is no
+	 * need for massaging the address or size.
+	 */
+	void *ptr = NULL;
+
+	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap(page);
+	}
+
+	return ptr;
+}
+
+void unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+
+void arch_update_crash_elfcorehdr(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	/*
+	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
+	 * is passed to the crash kernel via the elfcorehdr= parameter)
+	 * must be updated with the new list of CPUs and memories. Due
+	 * to the change to the elfcorehdr, the loaded segment hash/digests
+	 * contained within purgatory must also be updated. Thus purgatory
+	 * also be updated. Both the elfcorehdr and purgatory are prepared
+	 * in new kernel buffers, and if all succeeds, then new elfcorehdr
+	 * and purgatory are written into the corresponding crash memory.
+	 *
+	 * Note this code currently only support the kexec_file_load syscall.
+	 * For kexec_load, all the segments are provided by userspace.
+	 * In particular, the ability to locate and then update the
+	 * purgatory blob with a proper register context and hash/digests
+	 * prevents support for kexec_load. The kexec_file_load, on the
+	 * other hand, is all contained within the kernel and all needed
+	 * pieces of information can be located.
+	 */
+	struct kexec_segment *ksegment;
+	struct kexec_entry64_regs regs64;
+	struct kexec_buf pbuf;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+	unsigned int n;
+	int ret;
+
+	/*
+	 * Invalidate the pointers left over from the initial load or
+	 * previous hotplug update operation.
+	 */
+	for (n = 0; n < image->nr_segments; ++n)
+		image->segment[n].kbuf = NULL;
+
+	/* Only support kexec_file_load */
+	if (!image->file_mode) {
+		pr_err("crash hp: support kexec_file_load only");
+		goto out;
+	}
+
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elf_index and purg_index should never be zero or the
+	 * same index.
+	 */
+	if (image->arch.hp.elf_index == image->arch.hp.purg_index) {
+		pr_err("crash hp: unable to locate elfcorehdr or purgatory segments");
+		goto out;
+	}
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources. The elfcorehdr segment memsz must be
+	 * sufficiently large to accommodate increases due to hotplug
+	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	ksegment = &image->segment[image->arch.hp.elf_index];
+	memsz = ksegment->memsz;
+	if (elfsz > memsz) {
+		pr_err("crash hp: not enough room to update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+	/* Setup for kexec_calculate_store_digests() (for hash/digest) */
+	ksegment->kbuf = elfbuf;
+	ksegment->bufsz = elfsz;
+
+	/*
+	 * To update purgatory, must initialize the purgatory ELF blob,
+	 * then record the crash kernel entry point register context, and
+	 * finally must recompute the hash/digests for the loaded segments.
+	 */
+	ksegment = &image->segment[image->arch.hp.purg_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Initialize the purgatory ELF blob. Need to initialize the
+	 * kexec_buf in order to maneuver through kexec_load_purgatory()
+	 */
+	pbuf.image = image;
+	pbuf.buffer = NULL;
+	pbuf.buf_min = mem;
+	pbuf.buf_max = mem+memsz;
+	pbuf.top_down = true;
+	pbuf.mem = mem;
+	pbuf.memsz = memsz;
+	if (kexec_load_purgatory(image, &pbuf)) {
+		pr_err("crash hp: Initializing purgatory failed\n");
+		goto out;
+	}
+	/* Setup for kexec_calculate_store_digests() (to skip this segment) */
+	ksegment->kbuf = pbuf.buffer;
+	ksegment->bufsz = pbuf.bufsz;
+
+	/*
+	 * Rebuild and patch the purgatory ELF blob with updates
+	 * to the regs64 entry point context.
+	 */
+	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+		sizeof(regs64), 1);
+	if (ret) {
+		pr_err("crash hp: can not extract entry64_regs");
+		goto out;
+	}
+	regs64.rbx = image->arch.hp.rbx;
+	regs64.rsi = image->arch.hp.rsi;
+	regs64.rip = image->arch.hp.rip;
+	regs64.rsp = image->arch.hp.rsp;
+	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
+		sizeof(regs64), 0);
+	if (ret) {
+		pr_err("crash hp: Could not set entry64_regs");
+		goto out;
+	}
+
+	/*
+	 * To compute the hash/digests, must establish valid kernel
+	 * pointers to all the image segments.  Both the elfcorehdr and
+	 * the purgatory segments already have valid pointers.
+	 */
+	for (n = 0; n < image->nr_segments; ++n) {
+		ksegment = &image->segment[n];
+		if (ksegment->kbuf == NULL) {
+			mem = ksegment->mem;
+			memsz = ksegment->memsz;
+			ksegment->kbuf = map_crash_pages(mem, memsz);
+			if (!ksegment->kbuf) {
+				pr_err("crash hp: unable to map segment %u: %lx for %lu bytes",
+					n, mem, memsz);
+				goto out;
+			}
+		}
+	}
+
+	/* Recompute the digests for the segments */
+	if (kexec_calculate_store_digests(image)) {
+		pr_err("crash hp: recompute digest failed");
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Temporarily invalidate the crash image while its new (and
+	 * accurate) segments are written to memory. A panic during
+	 * this operation will NOT generate a crash dump.
+	 */
+	xchg(&kexec_crash_image, NULL);
+
+	/* Copy new elfcorehdr into destination */
+	ksegment = &image->segment[image->arch.hp.elf_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+	ptr = map_crash_pages(mem, memsz);
+	if (ptr) {
+		/* Write the new elfcorehdr into memory */
+		memcpy((void *)ptr, elfbuf, elfsz);
+		/*
+		 * Zero the memory between bufsz and memsz to match run-time
+		 * purgatory hash calculations.
+		 */
+		memset((void *)(ptr+elfsz), 0, memsz-elfsz);
+	}
+	unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+	/* With purgatory fully updated, store into crash kernel memory */
+	ksegment = &image->segment[image->arch.hp.purg_index];
+	if (kimage_load_segment(image, ksegment)) {
+		pr_err("crash hp: reloading purgatory failed");
+		goto out;
+	}
+	pr_debug("crash hp: re-loaded purgatory at 0x%lx\n", ksegment->mem);
+
+//FIX??? somekind of cache flush perhaps?
+
+	/*
+	 * The crash image is now valid once again, panics will cause a
+	 * crash dump to occur.
+	 */
+	xchg(&kexec_crash_image, image);
+
+out:
+	/* Free/release buffers */
+	kimage_file_post_load_cleanup(image);
+	/* Free elfbuf */
+	ksegment = &image->segment[image->arch.hp.elf_index];
+	vfree(ksegment->kbuf);
+	ksegment->kbuf = NULL; /* for loop below */
+	/*
+	 * Free purgatory buffer; this ksegment->kbuf is pi->purgatory_buf
+	 * and already freed in kimage_file_post_load_cleanup().
+	 */
+	ksegment = &image->segment[image->arch.hp.purg_index];
+	ksegment->kbuf = NULL; /* for loop below */
+	/* Free/release mappings */
+	for (n = 0; n < image->nr_segments; ++n) {
+		ksegment = &image->segment[n];
+		unmap_crash_pages((void **)&ksegment->kbuf);
+	}
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
