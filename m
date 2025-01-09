Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE37E77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWLLNj4Jpt+nD7oagFzGVAygPHcJROez4GbTM54vWxI=; b=zeaXggacEHwc7oLaFEHxmYgq3W
	wyuKlCwuRnDJHUC7YRvwSOJt6xp1X2x8b7lkbpOQKzSRweT6vaSl50YGMgm7U6Hw3Nh41HE0rXIB1
	K5anBx6kUzsGsrkZHfp1DYzwWl849b+DOFq43QHA40zQn3SaxtPi2kG81SKsw4vmjvrCGf7yuPxko
	V78nqaNC5ne25ass1rVHHFTO236nZgqBVHRHc+r8WKQBNSWvwASfo/TfmmI2oNqAuGxpo8fHZeMY4
	C1uM7uy3I1gQMzvrLoNJdU2xXIqV0qfmMjBKDQectzKnwiuLpCNEa9W4QjOVpUDRpWA9iTM70dUPr
	VP1njcOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvh9-0000000Ck7M-33Es;
	Thu, 09 Jan 2025 16:47:43 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVvh7-0000000Ck5c-01J3
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 16:47:42 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6dcf63155b0so6465146d6.1
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736441259; x=1737046059; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWLLNj4Jpt+nD7oagFzGVAygPHcJROez4GbTM54vWxI=;
        b=osnvNhnmyxXUZBRtODgeRDD05INNBoP5Fu15ejfzbfveKS/R9CCJVD1bTuVo78e9TE
         HENzfvt7/Yeg6hZX4kxjLe3Kp5sUJLPxfkh1HUOEurv/4fjBJDDeUwdqzi3pby/odvPn
         O7N/Nnqa3XMAsP3UWJ0Koip//Bie7q1nxGNCFCDITyOJzrHn/W4q1ieriG9ipMWfkcNp
         /qCT/1n9ykyEz8zzxStJ78dUpifScE367dypOQyGLL/2jdmgC4C/S96sRcmYvXXMIFJg
         pnDMTa8BDPhulsTfPR32xNYne7YQPgl6dbBmDXCHWgD1YYuO+jr2+E8cORyLYpFo2zYo
         buTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736441259; x=1737046059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWLLNj4Jpt+nD7oagFzGVAygPHcJROez4GbTM54vWxI=;
        b=Jd8QQrbJa5osvjhOSDv22jkrlBjHQYaKhBASZLS+8VYQyX19FcwqhUlg+QZuPPhdsX
         6jRWBqx0sYn2xTWddv0gcvRWZAxxKLwXKkOC2C3togT+3kks2ST3+0ARkvO0bSTYHuhy
         ugQQNDWAx8eF7pcLMTkro8yUT8MDs4UI+7fF0rbbAXWPNK6idvm6kIHw5DD8DNFsJCuy
         Ok1WJxZ+B4j9Oy15Nk9KAaDyjVHznjdmrKLXfGHGm2zZJ3+K4mdKorhZsenS91Pye6Q1
         +5az2HDx7KbfjsrZHeUTrVUQIFkFQ/MBNy/hVKoq8r1OJCXyRRjSJ+yaFd9IbB5wvfCY
         xkBA==
X-Forwarded-Encrypted: i=1; AJvYcCVNGTgEUO4FpP7PPQDAufIes5kLdKPcDY6SSAAMpkJoJsAO0wMOFjwmtt7VIeEDCsne4HxlcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwEySpVCdRQFYyKEG2Cz+PmJ7L1J4pAC/B5s2rBnLZ7+alAzLXc
	OtW1qE3nKckIDhLaH44R/UoaSMSfagxgS6VKmUA4+s3kUrjQmQ67ybCQ8llYwsE=
X-Gm-Gg: ASbGncs/OEiYWfPaXhfVshnR9CHRyiV1C5/INUaUjO96ol/cD4jvBEderV+qHLFJuIm
	EjxUwVFjXKUTGXgRt4ydPSYiCrGWksydJkmivFS4BLd3g2yi3ZiHzAY10xLVBATCxyAX1SD46ef
	F52hhIeo+Nj5PvMzuutOF3Ezv9YzYMdNxpnBsSvXkfEV1Fbqhv1tndTg/+iLn+yVAMl6+0BVpHl
	Dy5eQC0m7UPUzBcGzEVuEHQr0YvuvAEDDSc3xz/P/BE1TLdDQRIkIvGczPI99MveKaYOC2DeeUs
	3pggJ+R2yCxUL/Z/7/dWq5qICkalu6U6SZihLNA=
X-Google-Smtp-Source: AGHT+IEfGB7EQOEZkMT+90Rjc0IctwMlybh+WaRko0ZJ/riaoBe4SP1QGKvazsluuU8xPEQoq7TRcQ==
X-Received: by 2002:a05:6214:da5:b0:6d8:96a6:ec27 with SMTP id 6a1803df08f44-6df9b2d37abmr121742496d6.35.1736441259182;
        Thu, 09 Jan 2025 08:47:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad9b07d1sm81596d6.60.2025.01.09.08.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:47:38 -0800 (PST)
Date: Thu, 9 Jan 2025 11:47:36 -0500
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	devel@edk2.groups.io, kexec@lists.infradead.org, hannes@cmpxchg.org,
	dyoung@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	leitao@debian.org, kernel-team@meta.com
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
Message-ID: <Z3_9qDY1uTbxV5AE@gourry-fedora-PF4VCD3F>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_084741_045354_B991FDE2 
X-CRM114-Status: GOOD (  50.78  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Jan 09, 2025 at 04:32:10PM +0000, Usama Arif wrote:
> 
> 
> On 09/01/2025 16:15, Ard Biesheuvel wrote:
> > On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> When this area is not reserved, it comes up as usable in
> >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> >> to find usable memory regions, can select the region where
> >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> >>
> >> Since the patch in [1] was merged, all boots after kexec
> >> are producing the warning that it introduced.
> >>
> >> Having a fix in firmware can be difficult to get through.
> > 
> > I don't follow. I don't think there is anything wrong with the
> > firmware here. Could you elaborate?
> > 
> 
> So the problem is, kexec sees this memory as System RAM, and decides
> it can be used to place an image here.
> 
> I guess the question is (and I actually don't know the answer here),
> whose responsibility is it to mark this region as reserved so that 
> its not touched by anyone else. I would have thought it should be
> firmware?
> 
> Maybe its not the firmwares' job to mark it as reserved, but just pass
> it to kernel and the kernel is supposed to make sure it gets reserved
> in a proper way, even across kexecs.

Reservation is a kernel concept, the firmware/EFI etc give the kernel
guidance - but the actual maps here are largely informational and the
kernel can do whatever it wants (within reason).

So what you're really saying is either
  a) the hardware is mis-reporting the memory map configurations
     (e.g. some EFI_* bit is missing), or
  b) the kernel isn't doing the right thing.

I believe Ard is pointing out that the additional map abstraction is just
trying to retain a "current" versus "original" configuration - and this
is more of a headache than it is worth as it appears to be causing
confusion as to which one should be respected across kexec.

So the separate maps should just be one, and we should just smash the
"original" configuration rather than keeping a copy.

Please correct me if i'm misunderstanding anything.

> 
> I think in the end whoevers' responsibility it is, the easiest path forward
> seems to be in kernel? (and not firmware or libstub)
> 
> > 
> >> The next ideal place would be in libstub. However, it looks like
> >> InstallMemoryAttributesTable [2] is not available as a boot service
> >> call option [3], [4], and install_configuration_table does not
> >> seem to work as a valid substitute.
> >>
> > 
> > To do what, exactly?
> > 
> 
> To change the memory type from System RAM to either reserved or
> something more appropriate, i.e. any type that is not touched by
> kexec or any other userspace.
> 
> Basically the example code I attached at the end of the cover letter in 
> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
> touched by kexec.
> 
> >> As a last option for a fix, this patch marks that region as reserved in
> >> e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
> >> use it for kernel segments.
> >>
> >> [1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
> >> [2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
> >> [3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
> >> [4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327
> >>
> >> Reported-by: Breno Leitao <leitao@debian.org>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>  arch/x86/include/asm/e820/api.h | 2 ++
> >>  arch/x86/kernel/e820.c          | 6 ++++++
> >>  arch/x86/platform/efi/efi.c     | 9 +++++++++
> >>  drivers/firmware/efi/memattr.c  | 1 +
> >>  include/linux/efi.h             | 7 +++++++
> >>  5 files changed, 25 insertions(+)
> >>
> >> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> >> index 2e74a7f0e935..4e9aa24f03bd 100644
> >> --- a/arch/x86/include/asm/e820/api.h
> >> +++ b/arch/x86/include/asm/e820/api.h
> >> @@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
> >>
> >>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
> >>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> >> +extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> >> +                                       enum e820_type new_type);
> >>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
> >>  extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
> >>
> >> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >> index 82b96ed9890a..01d7d3c0d299 100644
> >> --- a/arch/x86/kernel/e820.c
> >> +++ b/arch/x86/kernel/e820.c
> >> @@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
> >>         return __e820__range_update(t, start, size, old_type, new_type);
> >>  }
> >>
> >> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
> >> +                                      enum e820_type new_type)
> >> +{
> >> +       return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
> >> +}
> >> +
> >>  /* Remove a range of memory from the E820 table: */
> >>  u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
> >>  {
> >> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> >> index a7ff189421c3..13684c5d7c05 100644
> >> --- a/arch/x86/platform/efi/efi.c
> >> +++ b/arch/x86/platform/efi/efi.c
> >> @@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
> >>         e820__update_table(e820_table);
> >>  }
> >>
> >> +/* Reserve firmware area if it was marked as RAM */
> >> +void arch_update_firmware_area(u64 addr, u64 size)
> >> +{
> >> +       if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
> >> +               e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >> +               e820__update_table(e820_table_firmware);
> >> +       }
> >> +}
> >> +
> >>  /*
> >>   * Given add_efi_memmap defaults to 0 and there is no alternative
> >>   * e820 mechanism for soft-reserved memory, import the full EFI memory
> >> diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
> >> index d3bc161361fb..d131781e2d7b 100644
> >> --- a/drivers/firmware/efi/memattr.c
> >> +++ b/drivers/firmware/efi/memattr.c
> >> @@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
> >>         size = tbl->num_entries * tbl->desc_size;
> >>         tbl_size = sizeof(*tbl) + size;
> >>         memblock_reserve(efi_mem_attr_table, tbl_size);
> >> +       arch_update_firmware_area(efi_mem_attr_table, tbl_size);
> >>         set_bit(EFI_MEM_ATTR, &efi.flags);
> >>
> >>  unmap:
> >> diff --git a/include/linux/efi.h b/include/linux/efi.h
> >> index e5815867aba9..8eb9698bd6a4 100644
> >> --- a/include/linux/efi.h
> >> +++ b/include/linux/efi.h
> >> @@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
> >>  void efivars_generic_ops_register(void);
> >>  void efivars_generic_ops_unregister(void);
> >>
> >> +#ifdef CONFIG_X86_64
> >> +void __init arch_update_firmware_area(u64 addr, u64 size);
> >> +#else
> >> +static inline void __init arch_update_firmware_area(u64 addr, u64 size)
> >> +{
> >> +}
> >> +#endif
> >>  #endif /* _LINUX_EFI_H */
> >> --
> >> 2.43.5
> >>
> 

