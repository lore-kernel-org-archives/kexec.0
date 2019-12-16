Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igfNh-0006a5-P4
 for kexec@lists.infradead.org; Mon, 16 Dec 2019 01:41:07 +0000
Received: by mail-pf1-x444.google.com with SMTP id h14so2795097pfe.10
 for <kexec@lists.infradead.org>; Sun, 15 Dec 2019 17:41:04 -0800 (PST)
Date: Mon, 16 Dec 2019 10:43:07 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 3/3] arm64: kexec_file: add crash dump support
Message-ID: <20191216014306.GG22427@linaro.org>
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
 <20191114051510.17037-4-takahiro.akashi@linaro.org>
 <679aba8b-c03d-8a15-46f1-3dc158c24fe9@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <679aba8b-c03d-8a15-46f1-3dc158c24fe9@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, frowand.list@gmail.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

I have forgot to address Bhupesh's comment below in my v3.
I'm going to repost my patch.

Thank you, Bhupesh, for your review.

-Takahiro Akashi

On Thu, Dec 05, 2019 at 02:14:14AM +0530, Bhupesh Sharma wrote:
> On 11/14/2019 10:45 AM, AKASHI Takahiro wrote:
> >Enabling crash dump (kdump) includes
> >* prepare contents of ELF header of a core dump file, /proc/vmcore,
> >   using crash_prepare_elf64_headers(), and
> >* add two device tree properties, "linux,usable-memory-range" and
> >   "linux,elfcorehdr", which represent respectively a memory range
> >   to be used by crash dump kernel and the header's location
> >
> >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >Cc: Catalin Marinas <catalin.marinas@arm.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Reviewed-by: James Morse <james.morse@arm.com>
> >---
> >  arch/arm64/include/asm/kexec.h         |   4 +
> >  arch/arm64/kernel/kexec_image.c        |   4 -
> >  arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
> >  3 files changed, 106 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> >index 12a561a54128..d24b527e8c00 100644
> >--- a/arch/arm64/include/asm/kexec.h
> >+++ b/arch/arm64/include/asm/kexec.h
> >@@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> >  struct kimage_arch {
> >  	void *dtb;
> >  	unsigned long dtb_mem;
> >+	/* Core ELF header buffer */
> >+	void *elf_headers;
> >+	unsigned long elf_headers_mem;
> >+	unsigned long elf_headers_sz;
> >  };
> >  extern const struct kexec_file_ops kexec_image_ops;
> >diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> >index 29a9428486a5..af9987c154ca 100644
> >--- a/arch/arm64/kernel/kexec_image.c
> >+++ b/arch/arm64/kernel/kexec_image.c
> >@@ -47,10 +47,6 @@ static void *image_load(struct kimage *image,
> >  	struct kexec_segment *kernel_segment;
> >  	int ret;
> >-	/* We don't support crash kernels yet. */
> >-	if (image->type == KEXEC_TYPE_CRASH)
> >-		return ERR_PTR(-EOPNOTSUPP);
> >-
> >  	/*
> >  	 * We require a kernel with an unambiguous Image header. Per
> >  	 * Documentation/arm64/booting.rst, this is the case when image_size
> >diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >index 7b08bf9499b6..f1d1bb895fd2 100644
> >--- a/arch/arm64/kernel/machine_kexec_file.c
> >+++ b/arch/arm64/kernel/machine_kexec_file.c
> >@@ -17,12 +17,15 @@
> >  #include <linux/memblock.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/random.h>
> >+#include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> >  #include <linux/vmalloc.h>
> >  #include <asm/byteorder.h>
> >  /* relevant device tree properties */
> >+#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
> >+#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
> >  #define FDT_PROP_INITRD_START	"linux,initrd-start"
> >  #define FDT_PROP_INITRD_END	"linux,initrd-end"
> >  #define FDT_PROP_BOOTARGS	"bootargs"
> >@@ -40,6 +43,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >  	vfree(image->arch.dtb);
> >  	image->arch.dtb = NULL;
> >+	vfree(image->arch.elf_headers);
> >+	image->arch.elf_headers = NULL;
> >+	image->arch.elf_headers_sz = 0;
> >+
> >  	return kexec_image_post_load_cleanup_default(image);
> >  }
> >@@ -55,6 +62,31 @@ static int setup_dtb(struct kimage *image,
> >  	off = ret;
> >+	ret = fdt_delprop(dtb, off, FDT_PROP_KEXEC_ELFHDR);
> >+	if (ret && ret != -FDT_ERR_NOTFOUND)
> >+		goto out;
> >+	ret = fdt_delprop(dtb, off, FDT_PROP_MEM_RANGE);
> >+	if (ret && ret != -FDT_ERR_NOTFOUND)
> >+		goto out;
> >+
> >+	if (image->type == KEXEC_TYPE_CRASH) {
> >+		/* add linux,elfcorehdr */
> >+		ret = fdt_appendprop_addrrange(dtb, 0, off,
> >+				FDT_PROP_KEXEC_ELFHDR,
> >+				image->arch.elf_headers_mem,
> >+				image->arch.elf_headers_sz);
> >+		if (ret)
> >+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> >+
> >+		/* add linux,usable-memory-range */
> >+		ret = fdt_appendprop_addrrange(dtb, 0, off,
> >+				FDT_PROP_MEM_RANGE,
> >+				crashk_res.start,
> >+				crashk_res.end - crashk_res.start + 1);
> >+		if (ret)
> >+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> >+	}
> >+
> >  	/* add bootargs */
> >  	if (cmdline) {
> >  		ret = fdt_setprop_string(dtb, off, FDT_PROP_BOOTARGS, cmdline);
> >@@ -125,8 +157,8 @@ static int setup_dtb(struct kimage *image,
> >  }
> >  /*
> >- * More space needed so that we can add initrd, bootargs, kaslr-seed, and
> >- * rng-seed.
> >+ * More space needed so that we can add initrd, bootargs, kaslr-seed,
> >+ * rng-seed, userable-memory-range and elfcorehdr.
> 
> nitpick:
> s/userable-memory-range/usable-memory-range
> 
> >   */
> >  #define DTB_EXTRA_SPACE 0x1000
> >@@ -174,6 +206,43 @@ static int create_dtb(struct kimage *image,
> >  	}
> >  }
> >+static int prepare_elf_headers(void **addr, unsigned long *sz)
> >+{
> >+	struct crash_mem *cmem;
> >+	unsigned int nr_ranges;
> >+	int ret;
> >+	u64 i;
> >+	phys_addr_t start, end;
> >+
> >+	nr_ranges = 1; /* for exclusion of crashkernel region */
> >+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> >+					MEMBLOCK_NONE, &start, &end, NULL)
> >+		nr_ranges++;
> >+
> >+	cmem = kmalloc(sizeof(struct crash_mem) +
> >+			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
> >+	if (!cmem)
> >+		return -ENOMEM;
> >+
> >+	cmem->max_nr_ranges = nr_ranges;
> >+	cmem->nr_ranges = 0;
> >+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> >+					MEMBLOCK_NONE, &start, &end, NULL) {
> >+		cmem->ranges[cmem->nr_ranges].start = start;
> >+		cmem->ranges[cmem->nr_ranges].end = end - 1;
> >+		cmem->nr_ranges++;
> >+	}
> >+
> >+	/* Exclude crashkernel region */
> >+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> >+
> >+	if (!ret)
> >+		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> >+
> >+	kfree(cmem);
> >+	return ret;
> >+}
> >+
> >  int load_other_segments(struct kimage *image,
> >  			unsigned long kernel_load_addr,
> >  			unsigned long kernel_size,
> >@@ -181,14 +250,43 @@ int load_other_segments(struct kimage *image,
> >  			char *cmdline)
> >  {
> >  	struct kexec_buf kbuf;
> >-	void *dtb = NULL;
> >-	unsigned long initrd_load_addr = 0, dtb_len;
> >+	void *headers, *dtb = NULL;
> >+	unsigned long headers_sz, initrd_load_addr = 0, dtb_len;
> >  	int ret = 0;
> >  	kbuf.image = image;
> >  	/* not allocate anything below the kernel */
> >  	kbuf.buf_min = kernel_load_addr + kernel_size;
> >+	/* load elf core header */
> >+	if (image->type == KEXEC_TYPE_CRASH) {
> >+		ret = prepare_elf_headers(&headers, &headers_sz);
> >+		if (ret) {
> >+			pr_err("Preparing elf core header failed\n");
> >+			goto out_err;
> >+		}
> >+
> >+		kbuf.buffer = headers;
> >+		kbuf.bufsz = headers_sz;
> >+		kbuf.mem = 0;
> 
> With commit c19d050f8088 ("arm64/kexec: Use consistent convention of
> initializing 'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN"), we are trying to
> standardize the way of setting up initial value of 'kbuf.mem'. So we can use
> the following notion (in v3?) instead:
> 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> 
> >+		kbuf.memsz = headers_sz;
> >+		kbuf.buf_align = SZ_64K; /* largest supported page size */
> >+		kbuf.buf_max = ULONG_MAX;
> >+		kbuf.top_down = true;
> >+
> >+		ret = kexec_add_buffer(&kbuf);
> >+		if (ret) {
> >+			vfree(headers);
> >+			goto out_err;
> >+		}
> >+		image->arch.elf_headers = headers;
> >+		image->arch.elf_headers_mem = kbuf.mem;
> >+		image->arch.elf_headers_sz = headers_sz;
> >+
> >+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> >+			 image->arch.elf_headers_mem, headers_sz, headers_sz);
> >+	}
> >+
> >  	/* load initrd */
> >  	if (initrd) {
> >  		kbuf.buffer = initrd;
> >
> 
> Thanks,
> Bhupesh
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
