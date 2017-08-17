Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1diGEY-0008Fz-2e
 for kexec@lists.infradead.org; Thu, 17 Aug 2017 08:32:55 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 2/2] makedumpfile/ppc64: get the info of mem reserved
 for crashkernel
Date: Thu, 17 Aug 2017 08:22:35 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EFBEFA@BPXM01GP.gisp.nec.co.jp>
References: <1502781666-20987-1-git-send-email-piliu@redhat.com>
 <1502781666-20987-3-git-send-email-piliu@redhat.com>
In-Reply-To: <1502781666-20987-3-git-send-email-piliu@redhat.com>
Content-Language: ja-JP
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
To: Pingfan Liu <piliu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>

Hello Pingfan,

>In kernel, ppc64 does not export the mem layout by ioresource. So we
>need to get the mem info for crashkernel from device tree.
>
>Signed-off-by: Pingfan Liu <piliu@redhat.com>
>---
> arch/ppc64.c   | 36 ++++++++++++++++++++++++++++++++++++
> makedumpfile.c | 10 ++++++++++
> makedumpfile.h |  4 ++++
> 3 files changed, 50 insertions(+)
>
>diff --git a/arch/ppc64.c b/arch/ppc64.c
>index 3fd6002..360590e 100644
>--- a/arch/ppc64.c
>+++ b/arch/ppc64.c
>@@ -617,4 +617,40 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
> 	return ppc64_vtop_level4(vaddr);
> }
>
>+int arch_crashkernel_mem_size()
>+{
>+	const char f_crashsize[] = "/proc/device-tree/chosen/linux,crashkernel-size";
>+	const char f_crashbase[] = "/proc/device-tree/chosen/linux,crashkernel-base";
>+	unsigned long crashk_sz_be, crashk_sz;
>+	unsigned long crashk_base_be, crashk_base;
>+	uint swap;
>+	FILE *fp, *fpb;
>+
>+	fp = fopen(f_crashsize, "r");
>+	if (!fp) {
>+		ERRMSG("Cannot open %s\n", f_crashsize);
>+		return FALSE;
>+	}
>+	fpb = fopen(f_crashbase, "r");
>+	if (!fp) {
>+		ERRMSG("Cannot open %s\n", f_crashbase);
>+		fclose(fp);
>+		return FALSE;
>+	}
>+
>+	fread(&crashk_sz_be, sizeof(crashk_sz_be), 1, fp);
>+	fread(&crashk_base_be, sizeof(crashk_base_be), 1, fpb);
>+	fclose(fp);
>+	fclose(fpb);
>+	/* dev tree is always big endian */
>+	swap = !is_bigendian();
>+	crashk_sz = swap64(crashk_sz_be, swap);
>+	crashk_base = swap64(crashk_base_be, swap);
>+	crash_reserved_mem_nr = 1;
>+	crash_reserved_mem[0].start = crashk_base;
>+	crash_reserved_mem[0].end   = crashk_base + crashk_sz - 1;
>+
>+	return TRUE;
>+}
>+
> #endif /* powerpc64 */
>diff --git a/makedumpfile.c b/makedumpfile.c
>index f85003a..c599b91 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -10921,10 +10921,20 @@ static int crashkernel_mem_callback(void *data, int nr,
> 	return 0;
> }
>
>+#if !defined(HAVE_ARCH_CRASHKERNEL_MEM_SIZE)
>+int arch_crashkernel_mem_size()
>+{
>+	return FALSE;
>+}
>+#endif
>+

I hope you follow the scheme for arch dependent code like get_phys_base()
to get rid of such ifdef. Please see makedumpfile.h for details,
my idea is like below:

#ifdef __powerpc64__
#define arch_crashkernel_mem_size()         arch_crashkernel_mem_size_ppc64()

#ifdef <others>
#define arch_crashkernel_mem_size()         stub_false()


Thanks,
Atsushi Kumagai

> int is_crashkernel_mem_reserved(void)
> {
> 	int ret;
>
>+	if (arch_crashkernel_mem_size())
>+		return TRUE;
>+
> 	ret = iomem_for_each_line("Crash kernel\n",
> 					crashkernel_mem_callback, NULL);
> 	crash_reserved_mem_nr = ret;
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 8a05794..48c1423 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -987,6 +987,8 @@ unsigned long long vaddr_to_paddr_ppc64(unsigned long vaddr);
> #define get_kaslr_offset(X)	stub_false()
> #define vaddr_to_paddr(X)	vaddr_to_paddr_ppc64(X)
> #define is_phys_addr(X)		stub_true_ul(X)
>+
>+#define HAVE_ARCH_CRASHKERNEL_MEM_SIZE
> #endif          /* powerpc64 */
>
> #ifdef __powerpc32__ /* powerpc32 */
>@@ -1939,6 +1941,8 @@ int iomem_for_each_line(char *match, int (*callback)(void *data, int nr,
> 						     unsigned long base,
> 						     unsigned long length),
> 			void *data);
>+int is_bigendian(void);
>+int arch_crashkernel_mem_size(void);
>
>
> /*
>--
>2.7.4
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
