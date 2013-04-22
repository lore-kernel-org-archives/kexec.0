Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x229.google.com ([2607:f8b0:4001:c03::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUITW-00036R-Lq
 for kexec@lists.infradead.org; Mon, 22 Apr 2013 15:16:16 +0000
Received: by mail-ie0-f169.google.com with SMTP id ar20so7315041iec.28
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 08:16:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363985646-30112-1-git-send-email-yinghai@kernel.org>
References: <1363985646-30112-1-git-send-email-yinghai@kernel.org>
Date: Mon, 22 Apr 2013 08:16:13 -0700
Message-ID: <CAE9FiQU6DhcMyfCMO9g7SmLFsbCWq1u6zav1jSEj3zFo9jgm_g@mail.gmail.com>
Subject: Re: [PATCH v2] kdump,
 x86: Process multiple Crash kernel in /proc/iomem
From: Yinghai Lu <yinghai@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, Mar 22, 2013 at 1:54 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Vivek found specical handling crashkernel low in not good.
> We should extend kexec-tools to handle multiple Crash kernel instead.
>
> Extend crash_reserved_mem to array instead and use
> kexec_iomem_for_each_line directly.  After that we can drop
> crashkernel low.
>
> -v2: fix left over calling of parse_iomem_single() found by Vivek.
>
> Suggested-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>
> ---
>  kexec/arch/i386/crashdump-x86.c    |  109 +++++++++++++++++++++----------------
>  kexec/arch/i386/kexec-x86-common.c |    4 -
>  kexec/kexec.h                      |    1
>  3 files changed, 66 insertions(+), 48 deletions(-)
>
> Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c
> @@ -188,9 +188,9 @@ static int exclude_region(int *nr_ranges
>  static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
>
>  /* Memory region reserved for storing panic kernel and other data. */
> -static struct memory_range crash_reserved_mem;
> -/* under 4G parts */
> -static struct memory_range crash_reserved_low_mem;
> +#define CRASH_RESERVED_MEM_NR  8
> +static struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
> +static int crash_reserved_mem_nr;
>
>  /* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
>   * create Elf headers. Keeping it separate from get_memory_ranges() as
> @@ -207,7 +207,7 @@ static int get_crash_memory_ranges(struc
>                                    int kexec_flags, unsigned long lowmem_limit)
>  {
>         const char *iomem = proc_iomem();
> -       int memory_ranges = 0, gart = 0;
> +       int memory_ranges = 0, gart = 0, i;
>         char line[MAX_LINE];
>         FILE *fp;
>         unsigned long long start, end;
> @@ -268,29 +268,28 @@ static int get_crash_memory_ranges(struc
>         }
>         fclose(fp);
>         if (kexec_flags & KEXEC_PRESERVE_CONTEXT) {
> -               int i;
>                 for (i = 0; i < memory_ranges; i++) {
>                         if (crash_memory_range[i].end > 0x0009ffff) {
> -                               crash_reserved_mem.start = \
> +                               crash_reserved_mem[0].start = \
>                                         crash_memory_range[i].start;
>                                 break;
>                         }
>                 }
> -               if (crash_reserved_mem.start >= mem_max) {
> +               if (crash_reserved_mem[0].start >= mem_max) {
>                         fprintf(stderr, "Too small mem_max: 0x%llx.\n",
>                                 mem_max);
>                         return -1;
>                 }
> -               crash_reserved_mem.end = mem_max;
> -               crash_reserved_mem.type = RANGE_RAM;
> +               crash_reserved_mem[0].end = mem_max;
> +               crash_reserved_mem[0].type = RANGE_RAM;
> +               crash_reserved_mem_nr = 1;
>         }
> -       if (exclude_region(&memory_ranges, crash_reserved_mem.start,
> -                               crash_reserved_mem.end) < 0)
> -               return -1;
> -       if (crash_reserved_low_mem.start &&
> -           exclude_region(&memory_ranges, crash_reserved_low_mem.start,
> -                               crash_reserved_low_mem.end) < 0)
> -               return -1;
> +
> +       for (i = 0; i < crash_reserved_mem_nr; i++)
> +               if (exclude_region(&memory_ranges, crash_reserved_mem[i].start,
> +                               crash_reserved_mem[i].end) < 0)
> +                       return -1;
> +
>         if (gart) {
>                 /* exclude GART region if the system has one */
>                 if (exclude_region(&memory_ranges, gart_start, gart_end) < 0)
> @@ -351,9 +350,10 @@ static int get_crash_memory_ranges_xen(s
>
>         qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
>
> -       if (exclude_region(ranges, crash_reserved_mem.start,
> -                                               crash_reserved_mem.end) < 0)
> -               goto err;
> +       for (i = 0; i < crash_reserved_mem_nr; i++)
> +               if (exclude_region(ranges, crash_reserved_mem[i].start,
> +                                               crash_reserved_mem[i].end) < 0)
> +                       goto err;
>
>         ret = 0;
>
> @@ -434,9 +434,10 @@ static int get_crash_memory_ranges_xen(s
>
>         qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
>
> -       if (exclude_region(ranges, crash_reserved_mem.start,
> -                                               crash_reserved_mem.end) < 0)
> -               goto err;
> +       for (i = 0; i < crash_reserved_mem_nr; i++)
> +               if (exclude_region(ranges, crash_reserved_mem[i].start,
> +                                               crash_reserved_mem[i].end) < 0)
> +                       goto err;
>
>         ret = 0;
>
> @@ -1022,15 +1023,10 @@ int load_crashdump_segments(struct kexec
>         memmap_p = xmalloc(sz);
>         memset(memmap_p, 0, sz);
>         add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
> -       sz = crash_reserved_mem.end - crash_reserved_mem.start +1;
> -       if (add_memmap(memmap_p, crash_reserved_mem.start, sz) < 0) {
> -               return ENOCRASHKERNEL;
> -       }
> -
> -       if (crash_reserved_low_mem.start) {
> -               sz = crash_reserved_low_mem.end - crash_reserved_low_mem.start
> -                                        +1;
> -               add_memmap(memmap_p, crash_reserved_low_mem.start, sz);
> +       for (i = 0; i < crash_reserved_mem_nr; i++) {
> +               sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> +               if (add_memmap(memmap_p, crash_reserved_mem[i].start, sz) < 0)
> +                       return ENOCRASHKERNEL;
>         }
>
>         /* Create a backup region segment to store backup data*/
> @@ -1101,25 +1097,46 @@ int load_crashdump_segments(struct kexec
>         return 0;
>  }
>
> -int is_crashkernel_mem_reserved(void)
> +int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
>  {
> -       uint64_t start, end;
> +       int i, idx = -1;
> +       unsigned long sz_max = 0, sz;
>
> -       if (parse_iomem_single("Crash kernel\n", &start, &end) || start == end)
> -               return 0;
> +       if (!crash_reserved_mem_nr)
> +               return -1;
>
> -       crash_reserved_mem.start = start;
> -       crash_reserved_mem.end = end;
> -       crash_reserved_mem.type = RANGE_RAM;
> -
> -       /* If there is no Crash low kernel, still can go on */
> -       if (parse_iomem_single("Crash kernel low\n", &start, &end) ||
> -                                       start == end)
> +       for (i = crash_reserved_mem_nr - 1; i >= 0; i--) {
> +               sz = crash_reserved_mem[i].end - crash_reserved_mem[i].start +1;
> +               if (sz <= sz_max)
> +                       continue;
> +               sz_max = sz;
> +               idx = i;
> +       }
> +
> +       *start = crash_reserved_mem[idx].start;
> +       *end = crash_reserved_mem[idx].end;
> +
> +       return 0;
> +}
> +
> +static int crashkernel_mem_callback(void *UNUSED(data), int nr,
> +                                          char *UNUSED(str),
> +                                          unsigned long base,
> +                                          unsigned long length)
> +{
> +       if (nr >= CRASH_RESERVED_MEM_NR)
>                 return 1;
>
> -       crash_reserved_low_mem.start = start;
> -       crash_reserved_low_mem.end = end;
> -       crash_reserved_low_mem.type = RANGE_RAM;
> +       crash_reserved_mem[nr].start = base;
> +       crash_reserved_mem[nr].end   = base + length - 1;
> +       crash_reserved_mem[nr].type  = RANGE_RAM;
> +       return 0;
> +}
> +
> +int is_crashkernel_mem_reserved(void)
> +{
> +       crash_reserved_mem_nr = kexec_iomem_for_each_line("Crash kernel\n",
> +                                       crashkernel_mem_callback, NULL);
>
> -       return 1;
> +       return !!crash_reserved_mem_nr;
>  }
> Index: kexec-tools/kexec/arch/i386/kexec-x86-common.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/i386/kexec-x86-common.c
> +++ kexec-tools/kexec/arch/i386/kexec-x86-common.c
> @@ -465,9 +465,9 @@ int get_memory_ranges(struct memory_rang
>             !(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
>                 uint64_t start, end;
>
> -               ret = parse_iomem_single("Crash kernel\n", &start, &end);
> +               ret = get_max_crash_kernel_limit(&start, &end);
>                 if (ret != 0) {
> -                       fprintf(stderr, "parse_iomem_single failed.\n");
> +                       fprintf(stderr, "get_max_crash_kernel_limit failed.\n");
>                         return -1;
>                 }
>
> Index: kexec-tools/kexec/kexec.h
> ===================================================================
> --- kexec-tools.orig/kexec/kexec.h
> +++ kexec-tools/kexec/kexec.h
> @@ -272,6 +272,7 @@ int arch_process_options(int argc, char
>  int arch_compat_trampoline(struct kexec_info *info);
>  void arch_update_purgatory(struct kexec_info *info);
>  int is_crashkernel_mem_reserved(void);
> +int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end);
>  char *get_command_line(void);
>
>  int kexec_iomem_for_each_line(char *match,

Simon,

Can you pick up this one?

Related change in kernel has been merged to upsteam via hpa.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=157752d84f5df47e01577970f9c5f61a0b9f4546


Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
