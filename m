Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE91CCD185
	for <kexec@archiver.kernel.org>; Wed, 18 Sep 2024 07:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wpr2sKI/SfrhhXL9iJS3Q7PGBkpKOOrEFoSvjaPoiEE=; b=JuS4jDWqw/pzx3
	LZKJJQZRuxImejZHVTqYZq/6HqJ4FAboml9fWgbuhoRcO6AmwGeUlfMYDsYrzV3HYHUYA5nI/s0z1
	X+5qNdokv4PmqDY7nkjn9jL9rTXczso4K+HBzkut9dsdw7+NJb0u6Wi9wI8Oi5XZo3qUbcxrXp40r
	k5CUoz/7p5u4awpX1M14cKZQOEXKmNw3Sl5fcjgAfZxEXDLL8Ffj9vAeyTTKoVTM//Je8fb7AZQyc
	MJhfjTL/Qm7W6VCIJ0/M9eiBGDh1v+qGPuMf268SepN1qKp0kNF1Z9kdveyzhl2IMhtwx2B3wroMT
	dLO3EjAYKpDGxkQT71AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpEe-00000007fZP-1DVn;
	Wed, 18 Sep 2024 07:36:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpEb-00000007fYp-3qSR
	for kexec@lists.infradead.org;
	Wed, 18 Sep 2024 07:36:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 96DFC5C5976
	for <kexec@lists.infradead.org>; Wed, 18 Sep 2024 07:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E723FC4CECF
	for <kexec@lists.infradead.org>; Wed, 18 Sep 2024 07:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726644979;
	bh=QmWF8/w9I2mjmPpEBTl4/a8Wl8TIynzjPFu2lFi2LvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OkdBx/X02131ilLdbaNEyvVZL0PSquSw3ooU4i3ET6TlWyey9BnmZ5R0cKbetYkZt
	 YLEqtm94tD9D94wKJeYJkrgaoWP3YXJLblyUWzn+vWZQFIiKsE4SB1p5ZzikBlmMmZ
	 MTqJgM2FA6aQbcLCj3zRs0KMuU2EzmCnHqOamp2fsmymk0C1VY88/+IFLcsVOJYATf
	 pHV//E5GJVCugoqqI9nvTQRRWpWkEA5wvk3ybaPofjm0qXLrk8BylZ1tWiZPJHGjeQ
	 Ws0kmHUrUF/Z+pqzUAkNHyx50fz1s3irFktkyr4EKqqsNq4ZpuqC0QyxHjq30z1qYj
	 9xJkDZUAkvOdQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f7528f4658so47200821fa.3
        for <kexec@lists.infradead.org>; Wed, 18 Sep 2024 00:36:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJKP1XmnDBP2Uo+QwHdb3nr6O3CUe0DM83z54eHj6ZZigCwn4h6c6rhg5Yeyad1gCz/I7XeA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCo35ZZO1/LuHVE3mnObFABJ6tSw2uFP9tmpwuIMO7fsTLFjeO
	n4mdgQeav9fkHQ+RMe4YszAcVY7Za/XkltMgCu+lt8L7hoD42GaetoUW09oCFLsANm3Mlmy0Jg7
	X3rxBBFgr/gQy3aM3UJlygo3JSJc=
X-Google-Smtp-Source: AGHT+IEpWHKdL+L9Y+xhZYZC6/UQSWdrojN6ocFQBi8ZV2M4mzRjq9mYS9qvchQuooT/ISVsdHtaTqhl8nAvL7V9ePQ=
X-Received: by 2002:a05:651c:4cb:b0:2f7:4f46:8344 with SMTP id
 38308e7fff4ca-2f7a2a48ec5mr55271711fa.21.1726644978238; Wed, 18 Sep 2024
 00:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
 <20240913-careful-maroon-crab-8a0541@leitao> <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org> <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org> <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
 <87setx3b8l.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87setx3b8l.fsf@email.froward.int.ebiederm.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 18 Sep 2024 09:36:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
Message-ID: <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Breno Leitao <leitao@debian.org>, 
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com, 
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_003622_116217_236593F5 
X-CRM114-Status: GOOD (  71.35  )
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

On Wed, 18 Sept 2024 at 05:14, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Ard Biesheuvel <ardb@kernel.org> writes:
> >>
> >> > Hi Eric,
> >> >
> >> > Thanks for chiming in.
> >>
> >> It just looked like after James gave some expert input the
> >> conversation got stuck, so I am just trying to move it along.
> >>
> >> I don't think anyone knows what this whole elephant looks like,
> >> which makes solving the problem tricky.
> >>
> >> > On Mon, 16 Sept 2024 at 22:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >>
> > ...
> >> >>
> >> >> This leaves two practical questions if I have been following everything
> >> >> correctly.
> >> >>
> >> >> 1) How to get kexec to avoid picking that memory for the new kernel to
> >> >>    run in before it initializes itself. (AKA the getting stomped by
> >> >>    relocate kernel problem).
> >> >>
> >> >> 2) How to point the new kernel to preserved tpm_log.
> >> >>
> >> >>
> >> >> This recommendation is from memory so it may be a bit off but
> >> >> the general structure should work.  The idea is as follows.
> >> >>
> >> >> - Pass the information between kernels.
> >> >>
> >> >>   It is probably simplest for the kernel to have a command line option
> >> >>   that tells the kernel the address and size of the tpm_log.
> >> >>
> >> >>   We have a couple of mechanisms here.  Assuming you are loading a
> >> >>   bzImage with kexec_file_load you should be able to have the in kernel
> >> >>   loader to add those arguments to the kernel command line.
> >> >>
> >> >
> >> > This shouldn't be necessary, and I think it is actively harmful to
> >> > keep inventing special ways for the kexec kernel to learn about these
> >> > things that deviate from the methods used by the first kernel. This is
> >> > how we ended up with 5 sources of truth for the physical memory map
> >> > (EFI memory map, memblock and 3 different versions of the e820 memory
> >> > map).
> >> >
> >> > We should try very hard to make kexec idempotent, and reuse the
> >> > existing methods where possible. In this case, the EFI configuration
> >> > table is already being exposed to the kexec kernel, which describes
> >> > the base of the allocation. The size of the allocation can be derived
> >> > from the table header.
> >> >
> >> >> - Ensure that when the loader is finding an address to load the new
> >> >>   kernel it treats the address of the tpm_log as unavailable.
> >> >>
> >> >
> >> > The TPM log is a table created by the EFI stub loader, which is part
> >> > of the kernel. So if we need to tweak this for kexec's benefit, I'd
> >> > prefer changing it in a way that can accommodate the first kernel too.
> >> > However, I think the current method already has that property so I
> >> > don't think we need to do anything (modulo fixing the bug)
> >>
> >> I am fine with not inventing a new mechanism, but I think we need
> >> to reuse whatever mechanism the stub loader uses to pass it's
> >> table to the kernel.  Not the EFI table that disappears at
> >> ExitBootServices().
> >>
> >
> > Not sure what you mean here - the EFI table that gets clobbered by
> > kexec *is* the table that is created by the stub loader to pass the
> > TPM log to the kernel. Not sure what alternative you have in mind
> > here.
>
> I was referring to whatever the EFI table that James Bottomley mentioned
> that I presume the stub loader reads from when the stub loader
> constructs the tpm_log that is passed to the kernel.
>

There is no such table. The event log is exposed by the firmware via a
TCG2 protocol interface, which is no longer available after boot. So
the stub loader (which is the last kernel component that has access to
this interface) invokes this protocol and copies the output into a
table in memory which is exposed to the kernel proper as a EFI
configuration table.

So the main issue here is that EFI configuration tables are passed on
to kexec kernels, and we have to ensure (in the general case) that the
associated memory is not reused. The implication is that the stub
loader should always use EFI_ACPI_RECLAIM_MEMORY for allocations that
are referenced via EFI configuration tables, and doing so for this
table makes the bug go away.


> So I believe we are in agreement of everything except terminology.
>

Sure.

> >> > That said, I am doubtful that the kexec kernel can make meaningful use
> >> > of the TPM log to begin with, given that the TPM will be out of sync
> >> > at this point. But it is still better to keep it for symmetry, letting
> >> > the higher level kexec/kdump logic running in user space reason about
> >> > whether the TPM log has any value to it.
> >>
> >> Someone seems to think so or there would not be a complaint that it is
> >> getting corrupted.
> >>
> >
> > No. The problem is that the size of the table is *in* the table, and
> > so if it gets corrupted, the code that attempts to memblock_reserve()
> > it goes off into the weeds. But that does not imply there is a point
> > to having access to this table from a kexec kernel in the first place.
>
> If there is no point to having access to it then we should just not
> pass anything to the loaded kernel, so the kernel does not think there
> is anything there.
>
> >> This should not be the kexec-on-panic kernel as that runs in memory
> >> that is reserved solely for it's own use.  So we are talking something
> >> like using kexec as a bootloader.
> >>
> >
> > kexec as a bootloader under TPM based measured boot will need to do a
> > lot more than pass the firmware's event log to the next kernel. I'd
> > expect a properly engineered kexec to replace this table entirely, and
> > include the hashes of the assets it has loaded and measured into the
> > respective PCRs.
> >
> > But let's stick to solving the actual issue here, rather than
> > philosophize on how kexec might work in this context.
>
>
> I am fine with that.  The complaint I had seen was that the table was
> being corrupted and asking how to solve that.  It seems I haven't read
> the part of the conversation where it was made clear that no one wants
> the tpm_log after kexec.
>

It was not made clear, that is why I raised the question. I argued
that the TPM log has limited utility after a kexec, given that we will
be in one of two situations:
- the kexec boot chain cares about the TPM and measured boot, and will
therefore have extended the TPM's PCRs and the TPM log will be out of
sync;
- the kexec boot chain does not care, and so there is no point in
forwarding the TPM log.

Perhaps there is a third case where kdump wants to inspect the TPM log
that the crashed kernel accessed? But this is rather speculative.

> If someone wants the tpm_log then we need to solve this problem.
>

Agreed.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
