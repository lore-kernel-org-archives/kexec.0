Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F86EEED617
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aVCU8NP9FF3zyxprhQDvSHKSm45P0XDrVSz/jhk67tU=; b=RHf2M1afMdEZGF
	wq0TGFqcan4b7YNt87rvzK26wLjGsASAOy0HvqgOmnzdUp+iMKTmLgDZK7Lu7dVbGvOypTC+ZcbGk
	vkKbXTduO54b6eMZU6/YtqKc//gjcicXBL/8PkHwkR+f38y85yvF0Ndndjo/wimuXmFSU7u2bV/kH
	oSGBA2W/FiDxfM7/8+45uuHjaC+HnIge56GUzA67zxyPAReDeGCJNBdLjKKA0yJ9jNf0ZhYxNmf85
	XD4hUEmVN/fTMZn2VkxWdVzfNfIvwFrS1+X9PHGAhoDTbLGIrL1ebYquC6sj5Eukksjfdebr+trHc
	GdKrmrnp8sCPlYubbDtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1som2J-0000000Dc5S-40Nc;
	Thu, 12 Sep 2024 15:47:11 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1som0z-0000000Dbt5-06QJ
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 15:45:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 56AFBA456F3
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 15:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61628C4CECC
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155947;
	bh=ywFiwczqxaKbUkWxJ47iW1M5pbc7iwd6Xn9eBevRoDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pDJccmdjI03IMJtcb83SC1z9FrOAtChHORsadr4dL473qvY49Ojw7AzIH/kZ+qyJd
	 HdcYp8vaTNdIVBy3FJem7f5uyj3kAnsETgKuzcOHLCbE+IxOw5YSXS+/Kzs5eluwU0
	 3PoA7LbnUgooH0Pqso3eGEXTFkYGqemxQHiH51pqx+ESnn4vrtk8IkWi1WXCUpK5Fm
	 ryACS4yQiuwt0XKNpDWBFaDILYe/2fEWSMHxM2ERC+2Tnxnnd8e62t3w8ETrKSYvOR
	 N/rKI0p4+c3TyEROfXjyKUIBb9RXT/FOZDVxLkvY9UdvMLWtJ3BSv+x+15AX8ZA6Bp
	 Z64PIgHlKm35A==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f7529203ddso21161961fa.0
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 08:45:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIpLAlwGkhAQwnerBKGdN+L5zOvcGXDSDeMPVUOqM2DzhngE1ZrZPbV9p78xwlMkwqXyQvzQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yws4ZaPoeKOmrWOVWtk/2wE6K7LUI5T5+G4mwOEOXGZ0PjIJdQG
	gBBFIQPxPhlMULWm9RAy2eY+Jm0xP1BjZW9ehA1EEYyDAvhsk4mgS1de36TB3HmI15fMex6K03h
	3Va0b9Gw7BrQYjDsYDVemovIZIl0=
X-Google-Smtp-Source: AGHT+IF+PZ6Sc/dPixZyy1JWDp50kq/OHT7HLXcUA13lJnelsHoZIUZ2S9NCa6y/9M2NhXv+XVcTtIqT2lLSeM+wrVE=
X-Received: by 2002:a05:6512:308f:b0:52e:9425:3cc8 with SMTP id
 2adb3069b0e04-5367909dc4fmr1135158e87.19.1726155945412; Thu, 12 Sep 2024
 08:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <20240912-sapphire-koala-of-focus-918cff@leitao> <CAMj1kXG842OSYu4GPm-ocyvpBDowPGaXAftqGExxjZ4=dGyt5g@mail.gmail.com>
 <9d3962f1-96b6-44a3-a7d3-10fbfbe06164@gmail.com>
In-Reply-To: <9d3962f1-96b6-44a3-a7d3-10fbfbe06164@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 17:45:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGqnVSoWUf1u6kx5zDHYhZHk_GjjUuV8TVZhXpgjaJDqg@mail.gmail.com>
Message-ID: <CAMj1kXGqnVSoWUf1u6kx5zDHYhZHk_GjjUuV8TVZhXpgjaJDqg@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_084549_220234_302FE61C 
X-CRM114-Status: GOOD (  41.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 12 Sept 2024 at 17:35, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 12/09/2024 16:21, Ard Biesheuvel wrote:
> > On Thu, 12 Sept 2024 at 16:29, Breno Leitao <leitao@debian.org> wrote:
> >>
> >> On Thu, Sep 12, 2024 at 03:10:43PM +0200, Ard Biesheuvel wrote:
> >>> On Thu, 12 Sept 2024 at 15:03, Breno Leitao <leitao@debian.org> wrote:
> >>>> On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> >>>>> I don't see how this could be an EFI bug, given that it does not deal
> >>>>> with E820 tables at all.
> >>>>
> >>>> I want to back up a little bit and make sure I am following the
> >>>> discussion.
> >>>>
> >>>> From what I understand from previous discussion, we have an EFI bug as
> >>>> the root cause of this issue.
> >>>>
> >>>> This happens because the EFI does NOT mark the EFI TPM event log memory
> >>>> region as reserved (EFI_RESERVED_TYPE).
> >>>
> >>> Why do you think EFI should use EFI_RESERVED_TYPE in this case?
> >>>
> >>> The EFI spec is very clear that EFI_RESERVED_TYPE really shouldn't be
> >>> used for anything by EFI itself. It is quite common for EFI
> >>> configuration tables to be passed as EfiRuntimeServicesData (SMBIOS),
> >>> EfiBootServicesData (ESRT) or EFiAcpiReclaim (ACPI tables).
> >>>
> >>> Reserved memory is mostly for memory that even the firmware does not
> >>> know what it is for, i.e., particular platform specific uses.
> >>>
> >>> In general, it is up to the OS to ensure that EFI configuration tables
> >>> that it cares about should be reserved in the correct way.
> >>
> >> Thanks for the explanation.
> >>
> >> So, if I understand what you meant here, the TPM event log memory range
> >> shouldn't be listed as a memory region in EFI memory map (as passed by
> >> the firmware to the OS).
> >>
> >> Hence, this is not a EFI firmware bug, but a OS/Kernel bug.
> >>
> >> Am I correct with the statements above?
> >>
> >
> > No, not entirely. But I also missed the face that this table is
> > actually created by the EFI stub in Linux, not the firmware. It is
> > *not* the same memory region that the TPM2 ACPI table describes, and
> > so what the various specs say about that is entirely irrelevant.
> >
> > The TPM event log configuration table is created by the EFI stub,
> > which uses the TCG2::GetEventLog () protocol method to obtain it. This
> > must be done by the EFI stub because these protocols will no longer be
> > available once the OS boots. But the data is not used by the EFI stub,
> > only by the OS, which is why it is passed in memory like this.
> >
> > The memory in question is allocated as EFI_LOADER_DATA, and so we are
> > relying on the OS to know that this memory is special, and needs to be
> > preserved.
> >
> > I think the solution here is to use a different memory type:
> >
> > --- a/drivers/firmware/efi/libstub/tpm.c
> > +++ b/drivers/firmware/efi/libstub/tpm.c
> > @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version,
> > efi_physical_addr_t log_loca
> >         }
> >
> >         /* Allocate space for the logs and copy them. */
> > -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> > +       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> >                              sizeof(*log_tbl) + log_size, (void **)&log_tbl);
> >
> >         if (status != EFI_SUCCESS) {
> >
> > which will be treated appropriately by the existing EFI-to-E820
> > conversion logic.
>
> I have tested above diff, and it works! No memory corruption.
>
> The region comes up as ACPI data:
> [    0.000000] BIOS-e820: [mem 0x000000007fb6d000-0x000000007fb7efff] ACPI data
>
> and kexec doesnt interfere with it.
>

Thanks, I'll take that as a tested-by

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
