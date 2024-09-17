Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33004CAC587
	for <kexec@archiver.kernel.org>; Tue, 17 Sep 2024 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RdtZfsgyNZ6Bd4AusRGy5yxTbBIKTtFwrpRiJ4fdUaw=; b=L8VMcxRaCVb17E
	+VgFTm2rKo2Gjft9u0AQ0/mYFuKmKxGe7mHoxVzrqSDr5anhS9iyPpy0N06lPMri/4yrwtnF1Q6rE
	muO69Qt9KTSTy9OVjVNVBa4a3+VUKnL5JO/3IY8BJ/9oWDCuyLkVvyg9skUQOP7PiML/fpT3fKHEV
	6Jv5MHa2MHsCjqctvHWFbJ8K2U104UgDyhBk3WuiiD1An87eHWtTLsHwYVlLrW3up3stOZ32W0pq8
	r47biYJXdFQdKBIB3sQD0idggWHZou/yjkm/ePLvousPCrQKMGkIawQ6cPVPqd/nuinnFkG8FYXIX
	1SPv7QaKoKZ1iPgq5Muw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqaEs-00000006Ob4-2CzM;
	Tue, 17 Sep 2024 15:35:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqaEp-00000006OZr-2SSX
	for kexec@lists.infradead.org;
	Tue, 17 Sep 2024 15:35:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C60835C40A4
	for <kexec@lists.infradead.org>; Tue, 17 Sep 2024 15:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F725C4CEC7
	for <kexec@lists.infradead.org>; Tue, 17 Sep 2024 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587334;
	bh=jJt7WnZBGuBV8L4paI1I1Es2EO1tM2i2LNNETVlvlLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D8QpCMsl4hL6URbZ0y9GOTbkwLbGidkNzrLm1OkyRJYFPfL6xa1fjlldFR0Fzh33n
	 vrYhxuly++Rq4Hge4f6PnD1FDN+6sraoPg/xbrhbAZrs2yFG4w/MO9n/sjudVgT9VI
	 J78/7dtup430/h5ym92SJBJ5uh+F6K4gtFGHz3xi1xpJnADasSvmaNdw0BLTDSo4fZ
	 MKHVluYW9UUXCF3XIWRmhMTH8EKtJcZNUz5Gd8EMn/GceO97jcBIYQCaViClbBGSJ4
	 og7dPqrPLgIm751QTNcZm3Fr3RRkyTJlGUb5lHqGgdER87ld2wRzk05pKy0eL85QqP
	 gafhFW9lu7stg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f761461150so62869171fa.0
        for <kexec@lists.infradead.org>; Tue, 17 Sep 2024 08:35:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp0/mVtjglPXrhRwZVJK9SHc9JRyk9KxFUcC3KXDYC4jZQ9hqPqFmde5hLlK0URpmErznTEQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZwAuA22xa2gg4CuAeA1AWrLkCwPYLp8qXd0zfYzcSEv0gaL/W
	ezPi2KFnOKMGN1tuMGDWNLTAz//84u5pzvgojrIGI7dCtnv2fo98XjVjxoa9CqzsImsNoaM1+aq
	wT6UuxlEyia1r6JWo7ueIU1ZG0jk=
X-Google-Smtp-Source: AGHT+IFfQJc8EcaWULN3Z+i8J/MSKeJvx5yHNWVN+ecZpADLsbwRegnU6nAb8P+zRnNC86xZWl36vWg3eoJPTQEschw=
X-Received: by 2002:a2e:b8d3:0:b0:2f7:7fe7:ca94 with SMTP id
 38308e7fff4ca-2f7918e4df3mr114333291fa.1.1726587332402; Tue, 17 Sep 2024
 08:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
 <20240913-careful-maroon-crab-8a0541@leitao> <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org> <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874j6e482p.fsf@email.froward.int.ebiederm.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Sep 2024 17:35:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
Message-ID: <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Breno Leitao <leitao@debian.org>, 
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com, 
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_083535_783861_F2445017 
X-CRM114-Status: GOOD (  57.26  )
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

On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > Hi Eric,
> >
> > Thanks for chiming in.
>
> It just looked like after James gave some expert input the
> conversation got stuck, so I am just trying to move it along.
>
> I don't think anyone knows what this whole elephant looks like,
> which makes solving the problem tricky.
>
> > On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
...
> >>
> >> This leaves two practical questions if I have been following everything
> >> correctly.
> >>
> >> 1) How to get kexec to avoid picking that memory for the new kernel to
> >>    run in before it initializes itself. (AKA the getting stomped by
> >>    relocate kernel problem).
> >>
> >> 2) How to point the new kernel to preserved tpm_log.
> >>
> >>
> >> This recommendation is from memory so it may be a bit off but
> >> the general structure should work.  The idea is as follows.
> >>
> >> - Pass the information between kernels.
> >>
> >>   It is probably simplest for the kernel to have a command line option
> >>   that tells the kernel the address and size of the tpm_log.
> >>
> >>   We have a couple of mechanisms here.  Assuming you are loading a
> >>   bzImage with kexec_file_load you should be able to have the in kernel
> >>   loader to add those arguments to the kernel command line.
> >>
> >
> > This shouldn't be necessary, and I think it is actively harmful to
> > keep inventing special ways for the kexec kernel to learn about these
> > things that deviate from the methods used by the first kernel. This is
> > how we ended up with 5 sources of truth for the physical memory map
> > (EFI memory map, memblock and 3 different versions of the e820 memory
> > map).
> >
> > We should try very hard to make kexec idempotent, and reuse the
> > existing methods where possible. In this case, the EFI configuration
> > table is already being exposed to the kexec kernel, which describes
> > the base of the allocation. The size of the allocation can be derived
> > from the table header.
> >
> >> - Ensure that when the loader is finding an address to load the new
> >>   kernel it treats the address of the tpm_log as unavailable.
> >>
> >
> > The TPM log is a table created by the EFI stub loader, which is part
> > of the kernel. So if we need to tweak this for kexec's benefit, I'd
> > prefer changing it in a way that can accommodate the first kernel too.
> > However, I think the current method already has that property so I
> > don't think we need to do anything (modulo fixing the bug)
>
> I am fine with not inventing a new mechanism, but I think we need
> to reuse whatever mechanism the stub loader uses to pass it's
> table to the kernel.  Not the EFI table that disappears at
> ExitBootServices().
>

Not sure what you mean here - the EFI table that gets clobbered by
kexec *is* the table that is created by the stub loader to pass the
TPM log to the kernel. Not sure what alternative you have in mind
here.

> > That said, I am doubtful that the kexec kernel can make meaningful use
> > of the TPM log to begin with, given that the TPM will be out of sync
> > at this point. But it is still better to keep it for symmetry, letting
> > the higher level kexec/kdump logic running in user space reason about
> > whether the TPM log has any value to it.
>
> Someone seems to think so or there would not be a complaint that it is
> getting corrupted.
>

No. The problem is that the size of the table is *in* the table, and
so if it gets corrupted, the code that attempts to memblock_reserve()
it goes off into the weeds. But that does not imply there is a point
to having access to this table from a kexec kernel in the first place.

> This should not be the kexec-on-panic kernel as that runs in memory
> that is reserved solely for it's own use.  So we are talking something
> like using kexec as a bootloader.
>

kexec as a bootloader under TPM based measured boot will need to do a
lot more than pass the firmware's event log to the next kernel. I'd
expect a properly engineered kexec to replace this table entirely, and
include the hashes of the assets it has loaded and measured into the
respective PCRs.

But let's stick to solving the actual issue here, rather than
philosophize on how kexec might work in this context.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
