Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icy4p-0003k2-5b
 for kexec@lists.infradead.org; Thu, 05 Dec 2019 20:50:21 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v4 3/4] makedumpfile/arm64: Add support for ARMv8.2-LVA
 (52-bit kernel VA support)
Date: Thu, 5 Dec 2019 20:49:28 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03597593@BPXM09GP.gisp.nec.co.jp>
References: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
 <1573556939-17803-4-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359718E@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359740C@BPXM09GP.gisp.nec.co.jp>
 <CACi5LpMHgZA6QumddL30Uzi97X7R5wshKag4gnyPs_A7xy8t0g@mail.gmail.com>
In-Reply-To: <CACi5LpMHgZA6QumddL30Uzi97X7R5wshKag4gnyPs_A7xy8t0g@mail.gmail.com>
Content-Language: en-US
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
Cc: John Donnelly <john.p.donnelly@oracle.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> > > > +/*
> > > > + * The linear kernel range starts at the bottom of the virtual address
> > > > + * space. Testing the top bit for the start of the region is a
> > > > + * sufficient check and avoids having to worry about the tag.
> > > > + */
> > > > +#define is_linear_addr(addr)       (!(((unsigned long)addr) & (1UL << (vabits_actual - 1))))
> > >
> > > Does this check cover 5.3 or earlier kernels?
> > > There is no case that vabits_actual is zero?
> 
> We can set vabits_actual as va_bits for older kernels. That shouldn't
> be a big change.
> Will add it in v5. See more below ...
> 
> > As you know, 14c127c957c1 ("arm64: mm: Flip kernel VA space") changed
> > the check for linear address:
> >
> > -#define __is_lm_address(addr)  (!!((addr) & BIT(VA_BITS - 1)))
> > +#define __is_lm_address(addr)  (!((addr) & BIT(VA_BITS - 1)))
> >
> > so if we use the same check as kernel has, I think we will need the
> > former one to support earlier kernels.
> 
> See above, we can use va_bits where vabits_actual is not present.

Yes, but it is not the problem that I wanted to say here.

The problem is that, even if we set vabits_actual to va_bits, we cannot
determine whether an address is in linear map range with just one macro
for 5.3 and 5.4 kernels.

Because the bit value to be checked by the macro changed:

5.3 VA_BITS=48
  linear map : 0xffff800000000000 to 0xffffffffffffffff
5.4 VA_BITS=48
  linear map : 0xffff000000000000 to 0xffff7fffffffffff

or I missed something?

Thanks,
Kazu

> 
> > > > +
> > > >  static unsigned long long
> > > >  __pa(unsigned long vaddr)
> > > >  {
> > > >     if (kimage_voffset == NOT_FOUND_NUMBER ||
> > > > -                   (vaddr >= PAGE_OFFSET))
> > > > -           return (vaddr - PAGE_OFFSET + info->phys_base);
> > > > +                   is_linear_addr(vaddr))
> > > > +           return (vaddr + info->phys_base - PAGE_OFFSET);
> > > >     else
> > > >             return (vaddr - kimage_voffset);
> > > >  }
> > > > @@ -253,6 +261,7 @@ static int calculate_plat_config(void)
> > > >                     (PAGESIZE() == SZ_64K && va_bits == 42)) {
> > > >             pgtable_level = 2;
> > > >     } else if ((PAGESIZE() == SZ_64K && va_bits == 48) ||
> > > > +                   (PAGESIZE() == SZ_64K && va_bits == 52) ||
> > > >                     (PAGESIZE() == SZ_4K && va_bits == 39) ||
> > > >                     (PAGESIZE() == SZ_16K && va_bits == 47)) {
> > > >             pgtable_level = 3;
> > > > @@ -287,6 +296,16 @@ get_phys_base_arm64(void)
> > > >             return TRUE;
> > > >     }
> > > >
> > > > +   /* If both vabits_actual and va_bits are now initialized, always
> > > > +    * prefer vabits_actual over va_bits to calculate PAGE_OFFSET
> > > > +    * value.
> > > > +    */
> > > > +   if (vabits_actual && va_bits && vabits_actual != va_bits) {
> > > > +           info->page_offset = (-(1UL << vabits_actual));
> > > > +           DEBUG_MSG("page_offset    : %lx (via vabits_actual)\n",
> > > > +                           info->page_offset);
> > > > +   }
> > > > +
> > >
> > > Is this for --mem-usage?
> > > If so, let's drop from this patch and think about it later because
> > > some additional base functions will be needed for the option, I think.
> 
> Ok.
> 
> > > >     if (get_num_pt_loads() && PAGE_OFFSET) {
> > > >             for (i = 0;
> > > >                 get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
> > > > @@ -406,6 +425,73 @@ get_stext_symbol(void)
> > > >     return(found ? kallsym : FALSE);
> > > >  }
> > > >
> > > > +static int
> > > > +get_va_bits_from_stext_arm64(void)
> > > > +{
> > > > +   ulong _stext;
> > > > +
> > > > +   _stext = get_stext_symbol();
> > > > +   if (!_stext) {
> > > > +           ERRMSG("Can't get the symbol of _stext.\n");
> > > > +           return FALSE;
> > > > +   }
> > > > +
> > > > +   /* Derive va_bits as per arch/arm64/Kconfig. Note that this is a
> > > > +    * best case approximation at the moment, as there can be
> > > > +    * inconsistencies in this calculation (for e.g., for
> > > > +    * 52-bit kernel VA case, even the 48th bit might be set in
> > > > +    * the _stext symbol).
> > > > +    *
> > > > +    * So, we need to rely on the actual VA_BITS symbol in the
> > > > +    * vmcoreinfo for a accurate value.
> > > > +    *
> > > > +    * TODO: Improve this further once there is a closure with arm64
> > > > +    * kernel maintainers on the same.
> > > > +    */
> > > > +   if ((_stext & PAGE_OFFSET_52) == PAGE_OFFSET_52) {
> > > > +           va_bits = 52;
> > > > +   } else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > > > +           va_bits = 48;
> > > > +   } else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > > > +           va_bits = 47;
> > > > +   } else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > > > +           va_bits = 42;
> > > > +   } else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > > > +           va_bits = 39;
> > > > +   } else if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > > > +           va_bits = 36;
> > > > +   } else {
> > > > +           ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > > > +           return FALSE;
> > > > +   }
> > > > +
> > > > +   DEBUG_MSG("va_bits    : %d (_stext) (approximation)\n", va_bits);
> > > > +
> > > > +   return TRUE;
> > > > +}
> > > > +
> > > > +static void
> > > > +get_page_offset_arm64(void)
> > > > +{
> > > > +   /* Check if 'vabits_actual' is initialized yet.
> > > > +    * If not, our best bet is to use 'va_bits' to calculate
> > > > +    * the PAGE_OFFSET value, otherwise use 'vabits_actual'
> > > > +    * for the same.
> > > > +    *
> > > > +    * See arch/arm64/include/asm/memory.h for more details.
> > > > +    */
> > > > +   if (!vabits_actual) {
> > > > +           info->page_offset = (-(1UL << va_bits));
> > > > +           DEBUG_MSG("page_offset    : %lx (approximation)\n",
> > > > +                                   info->page_offset);
> > > > +   } else {
> > > > +           info->page_offset = (-(1UL << vabits_actual));
> > > > +           DEBUG_MSG("page_offset    : %lx (accurate)\n",
> > > > +                                   info->page_offset);
> > > > +   }
> > >
> > > Does this support 5.3 or earlier kernels?
> >
> > Because I didn't see the old page_offset calculation below in this patch:
> >
> > > > -   info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> >
> > I was thinking that if there is a NUMBER(tcr_el1_t1sz) in vmcoreinfo,
> > we assume the kernel has the 'flipped' VA space.  And if there is no
> > NUMBER(tcr_el1_t1sz), then older 'non-flipped' VA [1].
> 
> Yes vabits_actual will be not found in such a case and we can use
> va_bits in such a case and similarly helper routines for page table
> walk/page_offset calculation may need modification.
> Will fix in v5.
> 
> > This might be a bit fragile against backport, but it requires less
> > vmcoreinfo, and older kernels don't need NUMBER(tcr_el1_t1sz).
> > (they might need NUMBER(MAX_USER_VA_BITS) like RHEL8 though.)
> 
> I think since this is an upstream fix, we should look at a generic fix
> (not restricted to RHEL, which anyway can contain out of tree fixes).
> I will send a v5 shortly with the suggested fixes.
> 
> Regards,
> Bhupesh
> 
> > What do you think?
> >
> > [1]
> https://github.com/k-hagio/makedumpfile/commit/fd9d86ea05b38e9edbb8c0ac3ebd612d5d485df3#diff-73f1cf659
> e8099a2f3a94f38063f97ecR400
> >
> > Thanks,
> > Kazu
> >
> >
> > >
> > > Thanks,
> > > Kazu
> > >
> > > > +
> > > > +}
> > > > +
> > > >  int
> > > >  get_machdep_info_arm64(void)
> > > >  {
> > > > @@ -420,8 +506,33 @@ get_machdep_info_arm64(void)
> > > >     /* Check if va_bits is still not initialized. If still 0, call
> > > >      * get_versiondep_info() to initialize the same.
> > > >      */
> > > > +   if (NUMBER(VA_BITS) != NOT_FOUND_NUMBER) {
> > > > +           va_bits = NUMBER(VA_BITS);
> > > > +           DEBUG_MSG("va_bits        : %d (vmcoreinfo)\n",
> > > > +                           va_bits);
> > > > +   }
> > > > +
> > > > +   /* Check if va_bits is still not initialized. If still 0, call
> > > > +    * get_versiondep_info() to initialize the same from _stext
> > > > +    * symbol.
> > > > +    */
> > > >     if (!va_bits)
> > > > -           get_versiondep_info_arm64();
> > > > +           if (get_va_bits_from_stext_arm64() == FALSE)
> > > > +                   return FALSE;
> > > > +
> > > > +   get_page_offset_arm64();
> > > > +
> > > > +   /* See TCR_EL1, Translation Control Register (EL1) register
> > > > +    * description in the ARMv8 Architecture Reference Manual.
> > > > +    * Basically, we can use the TCR_EL1.T1SZ
> > > > +    * value to determine the virtual addressing range supported
> > > > +    * in the kernel-space (i.e. vabits_actual).
> > > > +    */
> > > > +   if (NUMBER(tcr_el1_t1sz) != NOT_FOUND_NUMBER) {
> > > > +           vabits_actual = 64 - NUMBER(tcr_el1_t1sz);
> > > > +           DEBUG_MSG("vabits_actual  : %d (vmcoreinfo)\n",
> > > > +                           vabits_actual);
> > > > +   }
> > > >
> > > >     if (!calculate_plat_config()) {
> > > >             ERRMSG("Can't determine platform config values\n");
> > > > @@ -459,34 +570,11 @@ get_xen_info_arm64(void)
> > > >  int
> > > >  get_versiondep_info_arm64(void)
> > > >  {
> > > > -   ulong _stext;
> > > > -
> > > > -   _stext = get_stext_symbol();
> > > > -   if (!_stext) {
> > > > -           ERRMSG("Can't get the symbol of _stext.\n");
> > > > -           return FALSE;
> > > > -   }
> > > > -
> > > > -   /* Derive va_bits as per arch/arm64/Kconfig */
> > > > -   if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
> > > > -           va_bits = 36;
> > > > -   } else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
> > > > -           va_bits = 39;
> > > > -   } else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
> > > > -           va_bits = 42;
> > > > -   } else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
> > > > -           va_bits = 47;
> > > > -   } else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
> > > > -           va_bits = 48;
> > > > -   } else {
> > > > -           ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
> > > > -           return FALSE;
> > > > -   }
> > > > -
> > > > -   info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > > > +   if (!va_bits)
> > > > +           if (get_va_bits_from_stext_arm64() == FALSE)
> > > > +                   return FALSE;
> > > >
> > > > -   DEBUG_MSG("va_bits      : %d\n", va_bits);
> > > > -   DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
> > > > +   get_page_offset_arm64();
> > > >
> > > >     return TRUE;
> > > >  }
> > > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > > index 4a000112ba59..baf559e4d74e 100644
> > > > --- a/makedumpfile.c
> > > > +++ b/makedumpfile.c
> > > > @@ -2314,6 +2314,7 @@ write_vmcoreinfo_data(void)
> > > >     WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
> > > >  #ifdef __aarch64__
> > > >     WRITE_NUMBER("VA_BITS", VA_BITS);
> > > > +   WRITE_NUMBER_UNSIGNED("tcr_el1_t1sz", tcr_el1_t1sz);
> > > >     WRITE_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
> > > >     WRITE_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
> > > >  #endif
> > > > @@ -2720,6 +2721,7 @@ read_vmcoreinfo(void)
> > > >     READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
> > > >  #ifdef __aarch64__
> > > >     READ_NUMBER("VA_BITS", VA_BITS);
> > > > +   READ_NUMBER_UNSIGNED("tcr_el1_t1sz", tcr_el1_t1sz);
> > > >     READ_NUMBER_UNSIGNED("PHYS_OFFSET", PHYS_OFFSET);
> > > >     READ_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
> > > >  #endif
> > > > diff --git a/makedumpfile.h b/makedumpfile.h
> > > > index ac11e906b5b7..7eab6507c8df 100644
> > > > --- a/makedumpfile.h
> > > > +++ b/makedumpfile.h
> > > > @@ -974,7 +974,7 @@ int get_versiondep_info_arm64(void);
> > > >  int get_xen_basic_info_arm64(void);
> > > >  int get_xen_info_arm64(void);
> > > >  unsigned long get_kaslr_offset_arm64(unsigned long vaddr);
> > > > -#define paddr_to_vaddr_arm64(X) (((X) - info->phys_base) | PAGE_OFFSET)
> > > > +#define paddr_to_vaddr_arm64(X) (((X) - (info->phys_base - PAGE_OFFSET)))
> > > >
> > > >  #define find_vmemmap()             stub_false()
> > > >  #define vaddr_to_paddr(X)  vaddr_to_paddr_arm64(X)
> > > > @@ -1937,6 +1937,7 @@ struct number_table {
> > > >     long    KERNEL_IMAGE_SIZE;
> > > >  #ifdef __aarch64__
> > > >     long    VA_BITS;
> > > > +   unsigned long   tcr_el1_t1sz;
> > > >     unsigned long   PHYS_OFFSET;
> > > >     unsigned long   kimage_voffset;
> > > >  #endif
> > > > --
> > > > 2.7.4
> > > >
> >
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
