Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gJQhw-00041k-7u
 for kexec@lists.infradead.org; Sun, 04 Nov 2018 22:17:27 +0000
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so6287680ljd.1
 for <kexec@lists.infradead.org>; Sun, 04 Nov 2018 14:17:11 -0800 (PST)
MIME-Version: 1.0
References: <1540799431-11064-1-git-send-email-bhsharma@redhat.com>
 <1540799431-11064-2-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0355EF59@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0355EF59@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 5 Nov 2018 03:46:57 +0530
Message-ID: <CACi5LpM9Eu9uderHnXELGpc9m+g_WLR1d5aUQ4sudrRDxjWTLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] makedumpfile/arm64: Use VMCOREINFO inside
 '/proc/kcore' (if available)
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

Hi Kazu,

Thanks for your email. I am travelling this week for my holidays.
I will come back with my replies on this once I return (hopefully by
the coming Friday or earlier).

Thanks for your patience.

Regards,
Bhupesh


On Sat, Nov 3, 2018 at 2:32 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> Hi Bhupesh,
>
> On 10/29/2018 3:50 AM, Bhupesh Sharma wrote:
> > makedumpfile commit 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 (arm64: Get
> > 'info->page_offset' from PT_LOAD segments to support KASLR boot cases)
> > added a method to determine 'info->page_offset' from PT_LOAD segments
> > for arm64 platforms.
> >
> > In this commit, I hardcoded the 'NOT_PADDR_ARM64' macro as
> > 0x0000000010a80000UL which was a valid value on qualcomm-amberwing
> > boards (which was the arm64 board available with me at the time).
> >
> > However, I was testing this change on several other arm64 boards
> > like apm-mustang, huawei-taishan and hp-moonshot (now that I have
> > access to them) and saw that this value can vary on the basis of
> > the "Kernel code" memory range placement.
> >
> > To fix the same, this patchset uses a new approach. Since kernel
> > version 4.19-rc5 (commit
> > 23c85094fe1895caefdd19ef624ee687ec5f4507 ["proc/kcore: add vmcoreinfo
> > note to /proc/kcore"]), '/proc/kcore' contains a new
> > PT_NOTE which carries the VMCOREINFO information.
> >
> > If the same is available, we can use it for makedumpfile
> > 'show_mem_usage()' functionality. This is especially useful
> > for architectures like arm64 as we can get kernel symbols like
> > 'VA_BITS' and 'kimage_voffset' from the '/proc/kcore' itself and use it
> > to calculate 'info->page_offset' when we make a call to
> > 'get_page_offset()'.
>
> First, in show_mem_usage(), we set info->page_offset in advance
> in order to get the offset of vmcoreinfo in /proc/kcore (not in PT_NOTE)
> from /sys/kernel/vmcoreinfo information.
>
> Since now PT_NOTE has vmcoreinfo in /proc/kcore as well, we don't
> need get_page_offset() here any longer, right?
>
> So I suggest the following patch for show_mem_usage(),
> in addition, we can remove the get_elf_loads() function.
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 91c1ab4..a02665b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -11208,17 +11208,23 @@ int show_mem_usage(void)
>         if (!open_files_for_creating_dumpfile())
>                 return FALSE;
>
> -       if (!get_elf_loads(info->fd_memory, info->name_memory))
> +       if (!get_elf_info(info->fd_memory, info->name_memory))
>                 return FALSE;
>
> -       if (!get_page_offset())
> -               return FALSE;
> +       /*
> +        * Since kernel 4.19, /proc/kcore also has vmcoreinfo in PT_NOTE,
> +        * in that case we don't need /sys/kernel/vmcoreinfo.
> +        */
> +       if (!has_vmcoreinfo()) {
> +               if (!get_page_offset())
> +                       return FALSE;
>
> -       if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> -               return FALSE;
> +               if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> +                       return FALSE;
>
> -       if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> -               return FALSE;
> +               if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> +                       return FALSE;
> +       }
>
>         if (!initial())
>                 return FALSE;
>
>
> >
> > This VMCOREINFO note provides us a standard interface which can be
> > leveraged while debugging live (or primary) kernel with makedumpfile
> > (and other user-space tools), especially to derive the machine specific
> > details (for e.g. VA_BITS, PHYS_OFFSET and kimage_voffset for arm64
> > arch). The same has been suggested by the arm64 kernel maintainers (see
> > [0]) as the standard interface exposed by kernel for sharing
> > machine specific details with the user-land via vmcoreinfo.
> >
> > [0]. https://www.mail-archive.com/kexec@lists.infradead.org/msg20300.html
> >
> > I will send a follow-up patch to read 'kaslr_offset' for arm64 cases
> > from vmcoreinfo inside '/proc/kcore' after this patchset is applied.
> >
> > Here are some details of the tests I ran:
> >
> > Testing:
> > --------
> > 1. arm64 boards tested:
> >    huawei-taishan, apm-mustang and qualcomm-amberwing boards.
> >
> > 2. Use-cases tested:
> >    a) Primary kernel ->
> >       [] --mem-usage:
> >          # makedumpfile -f --mem-usage /proc/kcore
> >
> >       [] filtering use-case:
> >          # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
> >
> >       [] dumpfile creation:
> >          # makedumpfile -d 31 -x vmlinux vmcore dumpfile
> >
> >    b) Crash kernel ->
> >       [] dumpfile creation:
> >          # makedumpfile -l --message-level 31 -d 31 /proc/vmcore dump
> >
> > 3. Kernel versions tested:
> >    a) Kernel version 4.19-rc5 and above.
> >    b) Kernel version 4.14.
> >
> > Fixes: 94c97db3fe859ca14d7b38b0ae9ee0ffb83689d2 "arm64: Get 'info->page_offset' from PT_LOAD segments to
> > support KASLR boot cases"
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/arm64.c   | 114 +++++++++++++++++++++++++++++++++++++++++++--------------
> >  makedumpfile.c |  67 ++++++++++++++++++++++++++++++---
> >  makedumpfile.h |   2 +-
> >  3 files changed, 149 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/arm64.c b/arch/arm64.c
> > index 362609668ea2..d695eff628f0 100644
> > --- a/arch/arm64.c
> > +++ b/arch/arm64.c
> > @@ -53,6 +53,7 @@ static unsigned long kimage_voffset;
> >  #define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
> >  #define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
> >  #define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
> > +#define __PAGE_OFFSET(x) ((0xffffffffffffffffUL) << (x - 1))
> >
> >  #define pgd_val(x)           ((x).pgd)
> >  #define pud_val(x)           (pgd_val((x).pgd))
> > @@ -311,45 +312,104 @@ get_versiondep_info_arm64(void)
> >       unsigned long long virt_start;
> >       ulong _stext;
> >
> > -     _stext = get_stext_symbol();
> > -     if (!_stext) {
> > -             ERRMSG("Can't get the symbol of _stext.\n");
> > -             return FALSE;
> > -     }
> > +     /* Calculate 'VA_BITS'. */
> >
> > -     /* Derive va_bits as per arch/arm64/Kconfig */
> > -     if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > -             va_bits = 36;
> > -     } else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > -             va_bits = 39;
> > -     } else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > -             va_bits = 42;
> > -     } else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > -             va_bits = 47;
> > -     } else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > -             va_bits = 48;
> > +     /* Since kernel version 4.19, '/proc/kcore' contains a new
> > +      * PT_NOTE which carries the VMCOREINFO information.
> > +      *
> > +      * If the same is available, use it as it already contains the
> > +      * value of 'VA_BITS' on the machine.
> > +      *
> > +      * Otherwise, we can read the '_stext' symbol and determine the
> > +      * 'VA_BITS' value from the same as well.
> > +      */
> > +     if (info->flag_kcore_contains_vmcoreinfo &&
> > +         (NUMBER(VA_BITS) != NOT_FOUND_NUMBER)) {
> > +             va_bits = NUMBER(VA_BITS);
> >       } else {
> > -             ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > -             return FALSE;
> > +             _stext = get_stext_symbol();
> > +             if (!_stext) {
> > +                     ERRMSG("Can't get the symbol of _stext.\n");
> > +                     return FALSE;
> > +             }
> > +
> > +             /* Derive va_bits as per arch/arm64/Kconfig */
> > +             if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > +                     va_bits = 36;
> > +             } else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > +                     va_bits = 39;
> > +             } else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > +                     va_bits = 42;
> > +             } else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > +                     va_bits = 47;
> > +             } else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > +                     va_bits = 48;
> > +             } else {
> > +                     ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > +                     return FALSE;
> > +             }
> > +     }
> > +
> > +     /* Calculate 'info->page_offset'. */
> > +
> > +     /* Since kernel version 4.19, '/proc/kcore' contains a new
> > +      * PT_NOTE which carries the VMCOREINFO information.
> > +      *
> > +      * If the same is available, use it as it already contains the
> > +      * value of 'kimage_voffset' on the machine.
> > +      */
> > +     if (info->flag_kcore_contains_vmcoreinfo &&
> > +         (NUMBER(kimage_voffset) != NOT_FOUND_NUMBER)) {
> > +             kimage_voffset = NUMBER(kimage_voffset);
> >       }
> >
> > +     /* First, lets try and calculate the 'info->page_offset' value
> > +      * from PT_LOAD segments, if they are available.
> > +      */
> >       if (get_num_pt_loads()) {
> >               for (i = 0;
> >                   get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
> >                   i++) {
> > -                     if (virt_start != NOT_KV_ADDR
> > -                         && virt_start < __START_KERNEL_map
> > -                         && phys_start != NOT_PADDR
> > -                         && phys_start != NOT_PADDR_ARM64) {
> > -                             info->page_offset = virt_start - phys_start;
> > -                             DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> > -                                             info->page_offset, va_bits);
> > -                             return TRUE;
> > +                     /* On systems where we have a valid 'kimage_voffset'
> > +                      * available by now, we should give preference to the same
> > +                      * while calculating 'info->page_offset'.
> > +                      *
> > +                      * Otherwise, we can ensure that we consider
> > +                      * only those PT_LOAD segments whose 'virt_start'
> > +                      * is greater than the PAGE_OFFSET value (as defined
> > +                      * in 'arch/arm64/include/asm/memory.h').
> > +                      */
> > +                     if (!kimage_voffset) {
> > +                             if (virt_start != NOT_KV_ADDR &&
> > +                                virt_start > __PAGE_OFFSET(va_bits) &&
> > +                                phys_start != NOT_PADDR) {
> > +                                     info->page_offset = virt_start - phys_start;
> > +                                     DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> > +                                                     info->page_offset, va_bits);
> > +                                     return TRUE;
> > +                             }
> > +                     } else {
> > +                             if (virt_start != NOT_KV_ADDR &&
> > +                                phys_start != NOT_PADDR &&
> > +                                (virt_start - phys_start) != kimage_voffset) {
> > +                                     info->page_offset = virt_start - phys_start;
> > +                                     DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
> > +                                                     info->page_offset, va_bits);
> > +                                     return TRUE;
> > +                             }
>
> If something like KCORE_REMAP are added to kcore on arm64, even with
> vmcoreinfo, this calculation can return a wrong page_offset, right?
> Can we calculate info->page_offset without PT_LOAD information?
>
> Originally, info->page_offset (PAGE_OFFSET) is used in the following
> parts on arm64.
>
> arch/arm64.c:
> __pa(unsigned long vaddr)
> {
>         if (kimage_voffset == NOT_FOUND_NUMBER ||
>                         (vaddr >= PAGE_OFFSET))
>                 return (vaddr - PAGE_OFFSET + info->phys_base);
>         else
>                 return (vaddr - kimage_voffset);
> }
>
> elf_info.c:
>         kvstart = (ulong)start + PAGE_OFFSET;
>         kvend = (ulong)end + PAGE_OFFSET;
> --
>         kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
>
> I'm wondering about its consistency.  Is it OK to set
> (virt_start - phys_start) to info->page_offset on arm64?
> In other words, on arm64 system with info->phys_base != 0, does it
> work correctly for both /proc/vmcore and --mem-usage /proc/kcore?
>
> Maybe I have some misunderstanding..
>
> Thanks,
> Kazu
>
> >                       }
> >               }
> >       }
> >
> > -     info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > +     /* Fallback to hard-coded value (equal to PAGE_OFFSET macro
> > +      * defined in 'arch/arm64/include/asm/memory.h'), as the last
> > +      * resort.
> > +      *
> > +      * Note that this will not be a valid value on KASLR enabled
> > +      * kernels as the start address of linear range is also
> > +      * randomized for KASLR boot cases.
> > +      */
> > +     info->page_offset = __PAGE_OFFSET(va_bits);
> >       DEBUG_MSG("page_offset=%lx, va_bits=%d\n", info->page_offset,
> >                       va_bits);
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 91c1ab47fca4..a1b8d8ff5a84 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -1302,6 +1302,20 @@ error:
> >       return FALSE;
> >  }
> >
> > +static int
> > +check_kcore_contains_vmcoreinfo(int fd, char *name)
> > +{
> > +     if (!get_elf_info(fd, name))
> > +             return FALSE;
> > +
> > +     if (!has_vmcoreinfo())
> > +             return FALSE;
> > +
> > +     DEBUG_MSG("VMCOREINFO PT_NOTE found in %s\n", name);
> > +
> > +     return TRUE;
> > +}
> > +
> >  int
> >  open_dump_memory(void)
> >  {
> > @@ -1314,6 +1328,23 @@ open_dump_memory(void)
> >       }
> >       info->fd_memory = fd;
> >
> > +     /* Since kernel version 4.19, '/proc/kcore' contains a new
> > +      * PT_NOTE which carries the VMCOREINFO information.
> > +      *
> > +      * If the same is available, use it for makedumpfile
> > +      * show_mem_usage() cases.
> > +      */
> > +     if (info->flag_mem_usage &&
> > +         !(strcmp(info->name_memory, "/proc/kcore")) &&
> > +         (info->kernel_version >= KERNEL_VERSION(4, 19, 0))){
> > +             status = check_kcore_contains_vmcoreinfo(fd,
> > +                                             info->name_memory);
> > +             if (status == TRUE) {
> > +                     info->flag_kcore_contains_vmcoreinfo = TRUE;
> > +                     return TRUE;
> > +             }
> > +     }
> > +
> >       status = check_kdump_compressed(info->name_memory);
> >       if (status == TRUE) {
> >               info->flag_refiltering = TRUE;
> > @@ -11195,6 +11226,8 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
> >
> >  int show_mem_usage(void)
> >  {
> > +     off_t offset;
> > +     unsigned long size;
> >       uint64_t vmcoreinfo_addr, vmcoreinfo_len;
> >       struct cycle cycle = {0};
> >
> > @@ -11208,17 +11241,39 @@ int show_mem_usage(void)
> >       if (!open_files_for_creating_dumpfile())
> >               return FALSE;
> >
> > -     if (!get_elf_loads(info->fd_memory, info->name_memory))
> > -             return FALSE;
> > +     /* Since kernel version 4.19, '/proc/kcore' contains a new
> > +      * PT_NOTE which carries the VMCOREINFO information.
> > +      *
> > +      * If the same is available, use it for makedumpfile
> > +      * show_mem_usage(). This is especially useful for architectures
> > +      * like arm64 as we can get symbols like 'VA_BITS' and
> > +      * 'kimage_voffset' before we call get_page_offset().
> > +      */
> > +
> > +     if (!info->flag_kcore_contains_vmcoreinfo) {
> > +             if (!get_elf_loads(info->fd_memory, info->name_memory))
> > +                     return FALSE;
> > +     } else {
> > +             if (has_vmcoreinfo()) {
> > +                     get_vmcoreinfo(&offset, &size);
> > +                     if (!read_vmcoreinfo_from_vmcore(offset, size, FALSE))
> > +                             return FALSE;
> > +             }
> > +     }
> >
> >       if (!get_page_offset())
> >               return FALSE;
> >
> > -     if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> > -             return FALSE;
> > +     /* If flag_kcore_contains_vmcoreinfo is TRUE when we are here,
> > +      * we don't need to read the vmcoreinfo again.
> > +      */
> > +     if (!info->flag_kcore_contains_vmcoreinfo)
> > +             if (!get_sys_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> > +                     return FALSE;
> >
> > -     if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> > -             return FALSE;
> > +     if (!info->flag_kcore_contains_vmcoreinfo)
> > +             if (!set_kcore_vmcoreinfo(vmcoreinfo_addr, vmcoreinfo_len))
> > +                     return FALSE;
> >
> >       if (!initial())
> >               return FALSE;
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index 46ebe2ee5a1f..77f7ec8e3867 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -544,7 +544,6 @@ unsigned long get_kvbase_arm64(void);
> >  #define KVBASE                       get_kvbase_arm64()
> >
> >  #define __START_KERNEL_map   (0xffffffff80000000UL)
> > -#define NOT_PADDR_ARM64              (0x0000000010a80000UL)
> >
> >  #endif /* aarch64 */
> >
> > @@ -1308,6 +1307,7 @@ struct DumpInfo {
> >       int             flag_vmemmap;        /* kernel supports vmemmap address space */
> >       int             flag_excludevm;      /* -e - excluding unused vmemmap pages */
> >       int             flag_use_count;      /* _refcount is named _count in struct page */
> > +     int             flag_kcore_contains_vmcoreinfo;    /* '/proc/kcore' contains a VMCOREINFO PT_NOTE */
> >       unsigned long   vaddr_for_vtop;      /* virtual address for debugging */
> >       long            page_size;           /* size of page */
> >       long            page_shift;
> > --
> > 2.7.4
> >
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
