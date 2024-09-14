Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36158C02180
	for <kexec@archiver.kernel.org>; Sat, 14 Sep 2024 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qlWYzfmgW5JAABKjTe1T2NH561Z4LZxfMQkCuBkzmM0=; b=sPWMZhLiuJrcj8
	necns1arGMttZpRjwyPhZ32zMc8pwzgkSN5RV6/JGK9CBW+yKSPO91lufIMXnWMcjUVIvweCMisXB
	0GmUo55IgpZUNlkRFgy+12h1G2wKMEB+uREFWCYh5c3xtoV7g7egmCOiQvK5oLCy/eb106Tc8LVxC
	3UYiuinJX8s/IS4rJ+X4hOHsVD/NRXFQxHunYcVfuZG06OFngBWkCaOfnG0TvQFbp456/2MQymOjl
	UquQhtZNXkf/qkkguSqEBZeCaRxnJyCDZB5HH578ZF5+W3ynV8ZckKqOvaMAAPnAWF6mVmo6+iVHq
	oGgTzWESEBSgLo9CWM/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spOBc-00000000MgT-3Zw9;
	Sat, 14 Sep 2024 08:31:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spOBZ-00000000Mfp-2X9l
	for kexec@lists.infradead.org;
	Sat, 14 Sep 2024 08:31:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2EB885C077E
	for <kexec@lists.infradead.org>; Sat, 14 Sep 2024 08:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB97C4CECC
	for <kexec@lists.infradead.org>; Sat, 14 Sep 2024 08:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726302676;
	bh=z6OpSHyEljBBz2GYwX2VAF5oOERrd1UKlQ8BaPdqpYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ROjz95TM7LP+Hvu6LkrpLidU65BWo2NV9yF9CwVi/S38MphX6UqDxhFyOnLGFcO1m
	 ovlE9ezlY9sD+XIVjixw3LodeTCJvIyKvQByzhFpq1pj5g4jxJ7JtoZesgxKksYDk7
	 fia86LA7hLUGry2bl+bZkmqwVi5leDXi/TH4fmOxCHyeToDHYSBCGXHpJueyCOz5XG
	 ExJ6IRtD8DGLkwTOrNyYbZEwYhIvDHq1HbQzUynQxkY2/SHgdp8iqTD90bH/TQkGJx
	 x5V7UNiNd7N8/lb3fVjtvARrqrvhj/a3i93D4T/eEB+1ugvZtGUZQFqxLphiBA4J8x
	 zmPnTsc/QCG4w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53661a131b4so2255337e87.1
        for <kexec@lists.infradead.org>; Sat, 14 Sep 2024 01:31:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXArj8BvLFvKXWqcR6rZVm/klvZTvDSL49fDD7vnxEWzt4AnksSK/mtGhk9KxpyduCltf/H3w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyFvB15Xzd2p4oAlvokvhY97PQf1fxRic4gVE6nKV3Gp+wWBOWV
	08Nxke0LegD9LPoomPC1/W5zfWN64v5rnQi+6f2FvJZMjp8RbF09FsFQHKuh4bSM/4d/dI048Ng
	VCDv07fSFlu1LBz0LMdxGhGe6Yqw=
X-Google-Smtp-Source: AGHT+IFej30mwd0JRuY/+RDqkCSNoFipebnwEVsOZMyMFIDB2nW1hoN7F/05QIm2Cx3HgmT7MU97zNOZYAFTrGH5Y4A=
X-Received: by 2002:a05:6512:a91:b0:535:3d08:5844 with SMTP id
 2adb3069b0e04-5367feb964fmr3403400e87.6.1726302674503; Sat, 14 Sep 2024
 01:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com> <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
In-Reply-To: <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 14 Sep 2024 10:31:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
Message-ID: <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Dave Young <dyoung@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_013117_803794_C35E7041 
X-CRM114-Status: GOOD (  25.10  )
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

On Sat, 14 Sept 2024 at 08:46, Dave Young <dyoung@redhat.com> wrote:
>
> On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > (cc Dave)
> >
> > Thanks for ccing me.
> >
> > >
> > > Full thread here:
> > > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> > >
> > > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > > Does the below help at all?
> > > > > >
> > > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > > >         }
> > > > > >
> > > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > > >
> > > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > > >                 pr_info("TPM Final Events table not present\n");
> > > > >
> > > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > > which is e820_table_firmware.
> > > > >
> > > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > > its end, just with e820_table_firmware instead of e820_table.
> > > > > i.e. efi_mem_reserve does:
> > > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > >         e820__update_table(e820_table);
> > > > >
> > > > > while arch_update_firmware_area does:
> > > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > >         e820__update_table(e820_table_firmware);
> > > > >
> > > >
> > > > Shame.
> > > >
> > > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > > table, and 3 (!) versions of the E820 table in the correct way
> > > > (e820_table, e820_table_kexec and e820_table_firmware)
> > > >
> > > > Perhaps we can put this additional logic in x86's implementation of
> > > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > > with configuration tables produced by the firmware that may not be
> > > > reserved correctly if kexec looks at e820_table_firmware[] only.
> > >
> >
> > I have not read all the conversations,  let me have a look and response later.
> >
>
> I'm still confused after reading the code about why this issue can
> still happen with a efi_mem_reserve.
> Usama, Breno, could any of you share the exact steps on how to
> reproduce this issue with a kvm guest?
>

The code does not use efi_mem_reserve() only memblock_reserve().

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
