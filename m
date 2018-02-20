Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eo5sT-0005DK-QB
 for kexec@lists.infradead.org; Tue, 20 Feb 2018 11:14:32 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH] makedumpfile/arm64: Add '--mem-usage' support
Date: Tue, 20 Feb 2018 11:12:52 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE0117D388@BPXM01GP.gisp.nec.co.jp>
References: <1518168978-11268-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpM5snjZA9zmOibeVbB9ZN650epDDy26LOvDtBL+yVpr6A@mail.gmail.com>
In-Reply-To: <CACi5LpM5snjZA9zmOibeVbB9ZN650epDDy26LOvDtBL+yVpr6A@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Bhupesh,

Sorry for the late reply.
I'll reply by the end the next week.

Thanks
tachibana

> -----Original Message-----
> From: Bhupesh Sharma [mailto:bhsharma@redhat.com]
> Sent: Tuesday, February 20, 2018 1:56 PM
> To: kexec@lists.infradead.org
> Cc: Bhupesh Sharma <bhsharma@redhat.com>; Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>; Nakayama Takuya(
> ) <tak-nakayama@tg.jp.nec.com>; Nishimura Daisuke() <dai-nishimura@rc.jp.nec.com>
> Subject: Re: [PATCH] makedumpfile/arm64: Add '--mem-usage' support
> 
> Hello,
> 
> On Fri, Feb 9, 2018 at 3:06 PM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> > Its good to have the makedumpfile '--mem-usage' support
> > for arm64 architecture as well, as it allows one to see the page numbers
> > of current system (1st kernel) in different use.
> >
> > Using this we can know how many pages are dumpable when different
> > dump_level is specified.
> >
> > Normally for x86_64, makedumpfile analyzes the 'System Ram' and
> > 'kernel text' program segment of /proc/kcore excluding
> > the crashkernel range, then calculates the page number of different
> > kind per vmcoreinfo.
> >
> > We use the similar logic for arm64, but in addition make the '--mem-usage'
> > usage dependent on the VMLINUX file being passed. This is done to allow
> > information like VA_BITS being determined from kernel symbol like
> > _stext. This allows us to get the VA_BITS before 'set_kcore_vmcoreinfo()'
> > is called.
> >
> > Also I have validated the '--mem-usage' makedumpfile option on several
> > ppc64/ppc64le and s390x machines, so update the makedumpfile.8
> > documentation to indicate that '--mem-usage' option is supported
> > not only on x86_64, but also on ppc64, s390x and arm64.
> >
> > After this patch, when using the '--mem-usage' option with makedumpfile,
> > we get the correct information about the different pages. For e.g.
> > here is an output from my arm64 board:
> >
> > TYPE            PAGES                   EXCLUDABLE      DESCRIPTION
> > ----------------------------------------------------------------------
> > ZERO            49524                   yes             Pages filled with zero
> > NON_PRI_CACHE   15143                   yes             Cache pages without private flag
> > PRI_CACHE       29147                   yes             Cache pages with private flag
> > USER            3684                    yes             User process pages
> > FREE            1450569                 yes             Free pages
> > KERN_DATA       14243                   no              Dumpable kernel data
> >
> > page size:              65536
> > Total pages on system:  1562310
> > Total size on system:   102387548160     Byte
> >
> > Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
> > Cc: Takuya Nakayama <tak-nakayama@tg.jp.nec.com>
> > Cc: Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> 
> Ping. Any review comments on this?
> 
> Regards,
> Bhupesh
> 
> > ---
> >  arch/arm64.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
> >  makedumpfile.8 | 11 +++++++++--
> >  makedumpfile.c | 25 +++++++++++++++++++++++--
> >  makedumpfile.h |  1 +
> >  4 files changed, 81 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64.c b/arch/arm64.c
> > index 25d7a1f4db98..91f113f6447c 100644
> > --- a/arch/arm64.c
> > +++ b/arch/arm64.c
> > @@ -48,6 +48,12 @@ static unsigned long kimage_voffset;
> >  #define SZ_64K                 (64 * 1024)
> >  #define SZ_128M                        (128 * 1024 * 1024)
> >
> > +#define PAGE_OFFSET_36 ((0xffffffffffffffffUL) << 36)
> > +#define PAGE_OFFSET_39 ((0xffffffffffffffffUL) << 39)
> > +#define PAGE_OFFSET_42 ((0xffffffffffffffffUL) << 42)
> > +#define PAGE_OFFSET_47 ((0xffffffffffffffffUL) << 47)
> > +#define PAGE_OFFSET_48 ((0xffffffffffffffffUL) << 48)
> > +
> >  #define pgd_val(x)             ((x).pgd)
> >  #define pud_val(x)             (pgd_val((x).pgd))
> >  #define pmd_val(x)             (pud_val((x).pud))
> > @@ -140,8 +146,6 @@ pud_offset(pgd_t *pgda, pgd_t *pgdv, unsigned long vaddr)
> >
> >  static int calculate_plat_config(void)
> >  {
> > -       va_bits = NUMBER(VA_BITS);
> > -
> >         /* derive pgtable_level as per arch/arm64/Kconfig */
> >         if ((PAGESIZE() == SZ_16K && va_bits == 36) ||
> >                         (PAGESIZE() == SZ_64K && va_bits == 42)) {
> > @@ -188,7 +192,6 @@ get_machdep_info_arm64(void)
> >         kimage_voffset = NUMBER(kimage_voffset);
> >         info->max_physmem_bits = PHYS_MASK_SHIFT;
> >         info->section_size_bits = SECTIONS_SIZE_BITS;
> > -       info->page_offset = 0xffffffffffffffffUL << (va_bits - 1);
> >
> >         DEBUG_MSG("kimage_voffset   : %lx\n", kimage_voffset);
> >         DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
> > @@ -219,6 +222,48 @@ get_xen_info_arm64(void)
> >  int
> >  get_versiondep_info_arm64(void)
> >  {
> > +       unsigned long long stext;
> > +
> > +       /* We can read the _stext symbol from vmlinux and determine the
> > +        * VA_BITS and page_offset.
> > +        */
> > +
> > +       /* Open the vmlinux file */
> > +       open_kernel_file();
> > +       set_dwarf_debuginfo("vmlinux", NULL,
> > +                       info->name_vmlinux, info->fd_vmlinux);
> > +
> > +       if (!get_symbol_info())
> > +               return FALSE;
> > +
> > +       /* Get the '_stext' symbol */
> > +       if (SYMBOL(_stext) == NOT_FOUND_SYMBOL) {
> > +               ERRMSG("Can't get the symbol of _stext.\n");
> > +               return FALSE;
> > +       } else {
> > +               stext = SYMBOL(_stext);
> > +       }
> > +
> > +       /* Derive va_bits as per arch/arm64/Kconfig */
> > +       if ((stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > +               va_bits = 36;
> > +       } else if ((stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > +               va_bits = 39;
> > +       } else if ((stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > +               va_bits = 42;
> > +       } else if ((stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > +               va_bits = 47;
> > +       } else if ((stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > +               va_bits = 48;
> > +       } else {
> > +               ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > +               return FALSE;
> > +       }
> > +
> > +       info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > +
> > +       DEBUG_MSG("page_offset=%lx, va_bits=%d\n", info->page_offset, va_bits);
> > +
> >         return TRUE;
> >  }
> >
> > diff --git a/makedumpfile.8 b/makedumpfile.8
> > index 15db7947d62f..be9620035316 100644
> > --- a/makedumpfile.8
> > +++ b/makedumpfile.8
> > @@ -593,7 +593,7 @@ last cleared on the crashed kernel, through "dmesg --clear" for example.
> >
> >  .TP
> >  \fB\-\-mem-usage\fR
> > -This option is only for x86_64.
> > +This option is currently supported on x86_64, arm64, ppc64 and s390x.
> >  This option is used to show the page numbers of current system in different
> >  use. It should be executed in 1st kernel. By the help of this, user can know
> >  how many pages is dumpable when different dump_level is specified. It analyzes
> > @@ -601,12 +601,19 @@ the 'System Ram' and 'kernel text' program segment of /proc/kcore excluding
> >  the crashkernel range, then calculates the page number of different kind per
> >  vmcoreinfo. So currently /proc/kcore need be specified explicitly.
> >
> > +For arm64, path to vmlinux file should be specified as well.
> > +
> >  .br
> > -.B Example:
> > +.B Example (for architectures other than arm64):
> >  .br
> >  # makedumpfile \-\-mem-usage /proc/kcore
> > +
> > +.br
> > +.B Example (for arm64 architecture):
> >  .br
> >
> > +# makedumpfile \-\-mem-usage vmlinux /proc/kcore
> > +.br
> >
> >  .TP
> >  \fB\-\-diskset=VMCORE\fR
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index ed138d339d9a..b38b5000aa74 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -11090,7 +11090,14 @@ static struct option longopts[] = {
> >         {"cyclic-buffer", required_argument, NULL, OPT_CYCLIC_BUFFER},
> >         {"eppic", required_argument, NULL, OPT_EPPIC},
> >         {"non-mmap", no_argument, NULL, OPT_NON_MMAP},
> > +#ifdef __aarch64__
> > +       /* VMLINUX file is required for aarch64 for get
> > +        * the symbols required to calculate va_bits.
> > +        */
> > +       {"mem-usage", required_argument, NULL, OPT_MEM_USAGE},
> > +#else
> >         {"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
> > +#endif
> >         {"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
> >         {"work-dir", required_argument, NULL, OPT_WORKING_DIR},
> >         {"num-threads", required_argument, NULL, OPT_NUM_THREADS},
> > @@ -11201,8 +11208,22 @@ main(int argc, char *argv[])
> >                         info->flag_partial_dmesg = 1;
> >                         break;
> >                 case OPT_MEM_USAGE:
> > -                      info->flag_mem_usage = 1;
> > -                      break;
> > +                       info->flag_mem_usage = 1;
> > +#ifdef __aarch64__
> > +                       /* VMLINUX file is required for aarch64 for get
> > +                        * the symbols required to calculate va_bits and
> > +                        * it should be the 1st command parameter being
> > +                        * specified.
> > +                        */
> > +                       if (strcmp(optarg, "/proc/kcore") == 0) {
> > +                               MSG("vmlinux path should be 1st commandline parameter with --mem-usage option.\n");
> > +                               goto out;
> > +                       }
> > +                       else {
> > +                               info->name_vmlinux = optarg;
> > +                       }
> > +#endif
> > +                       break;
> >                 case OPT_COMPRESS_SNAPPY:
> >                         info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
> >                         break;
> > diff --git a/makedumpfile.h b/makedumpfile.h
> > index 01eece231475..f65d91870b73 100644
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -2308,6 +2308,7 @@ struct elf_prstatus {
> >  /*
> >   * Function Prototype.
> >   */
> > +int open_kernel_file(void);
> >  mdf_pfn_t get_num_dumpable_cyclic(void);
> >  mdf_pfn_t get_num_dumpable_cyclic_withsplit(void);
> >  int get_loads_dumpfile_cyclic(void);
> > --
> > 2.7.4
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
