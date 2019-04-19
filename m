Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f67.google.com ([209.85.166.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hHPzg-0003Zi-Sx
 for kexec@lists.infradead.org; Fri, 19 Apr 2019 09:39:43 +0000
Received: by mail-io1-f67.google.com with SMTP id b6so4086006iog.0
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2019 02:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190416095209.GG27892@zn.tnic>
 <20190419083458.503-1-kasong@redhat.com>
 <20190419085804.GD11060@MiWiFi-R3L-srv>
In-Reply-To: <20190419085804.GD11060@MiWiFi-R3L-srv>
From: Kairui Song <kasong@redhat.com>
Date: Fri, 19 Apr 2019 17:39:28 +0800
Message-ID: <CACPcB9ebt2pGuyDaevehU6B9dcKduGKNTo12qsE-gFXYBpiYjg@mail.gmail.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
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
To: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Fri, Apr 19, 2019 at 4:58 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 04/19/19 at 04:34pm, Kairui Song wrote:
> >  /* Locates and clears a region for a new top level page table. */
> >  void initialize_identity_maps(void)
> >  {
> > -     /* If running as an SEV guest, the encryption mask is required. */
> > -     set_sev_encryption_mask();
> > -
> > -     /* Exclude the encryption mask from __PHYSICAL_MASK */
> > -     physical_mask &= ~sme_me_mask;
> > -
> > -     /* Init mapping_info with run-time function/buffer pointers. */
> > -     mapping_info.alloc_pgt_page = alloc_pgt_page;
> > -     mapping_info.context = &pgt_data;
> > -     mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> > -     mapping_info.kernpg_flag = _KERNPG_TABLE;
> > -
> > -     /*
> > -      * It should be impossible for this not to already be true,
> > -      * but since calling this a second time would rewind the other
> > -      * counters, let's just make sure this is reset too.
> > -      */
> > -     pgt_data.pgt_buf_offset = 0;
> > -
> > -     /*
> > -      * If we came here via startup_32(), cr3 will be _pgtable already
> > -      * and we must append to the existing area instead of entirely
> > -      * overwriting it.
> > -      *
> > -      * With 5-level paging, we use '_pgtable' to allocate the p4d page table,
> > -      * the top-level page table is allocated separately.
> > -      *
> > -      * p4d_offset(top_level_pgt, 0) would cover both the 4- and 5-level
> > -      * cases. On 4-level paging it's equal to 'top_level_pgt'.
> > -      */
> > -     top_level_pgt = read_cr3_pa();
> > -     if (p4d_offset((pgd_t *)top_level_pgt, 0) == (p4d_t *)_pgtable) {
> > -             debug_putstr("booted via startup_32()\n");
> > -             pgt_data.pgt_buf = _pgtable + BOOT_INIT_PGT_SIZE;
> > -             pgt_data.pgt_buf_size = BOOT_PGT_SIZE - BOOT_INIT_PGT_SIZE;
> > -             memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> > -     } else {
> > -             debug_putstr("booted via startup_64()\n");
> > -             pgt_data.pgt_buf = _pgtable;
> > -             pgt_data.pgt_buf_size = BOOT_PGT_SIZE;
> > -             memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> > +     top_level_pgt = early_boot_top_pgt;
> > +     if ((p4d_t *)top_level_pgt != (p4d_t *)_pgtable)
> >               top_level_pgt = (unsigned long)alloc_pgt_page(&pgt_data);
>
> Kairui, will you make a patchset to include these changes separately
> later on? I don't get the purposes of code changes. E.g here, I
> don't know why you introduce a new variable early_boot_top_pgt, and
> allocate the page table, even though they have been done in the old
> initialize_identity_maps().
>
> Thanks
> Baoquan
>

OK, right, it's not a good idea to mess up things together, I'll
resend the patch, and will sent the cleanup separately. Without clean
up it may bring in some extra burden with certain kernel config, but
that should be OK for the fix.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
