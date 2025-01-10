Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93DAE7719D
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LgNlM5UDL6ChRle2mp0Np/L6evW51T2Zb82b3nCV2U=; b=2UQO5q9yH/QngnG+onpqzP3Oao
	qeAXkTI51GOTl0iMd1ZpyN1Ceq6kFAKE+GGpfEnrGogCOfqyOVYdAy6mM2IEmA6yqSxyI6cOlf3vv
	NIMV3c9YXX+in6wZbclD1GcEb5pWFhAXY2/MUJrda+qz+k6hn8eDdvw01pn4k1oHyZHgfLw9CpCbI
	47I1T5oDQeqJE2iqTiSVlLsIBOOnxgMVP494lUMCwMXrYz2f97aadvsHU1waKwZDK6yWaFNr+Sas6
	t4alLU1j+I6rNJJBZhuCuY9kqbU2T0rs4z+rXmeoul5/Md1AQCiYKYmcrg78jMOk75q64L8pqn7nn
	KzEszgbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWItO-0000000GRx0-2GgG;
	Fri, 10 Jan 2025 17:33:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWItB-0000000GRsv-2tUR
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 17:33:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6E058A42755
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 17:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B66EC4AF0B
	for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530420;
	bh=2LgNlM5UDL6ChRle2mp0Np/L6evW51T2Zb82b3nCV2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j8xJR0kIkN4IsONbSKw4WLRCqit1GiDdwWWEqOgpHFI7p0Dx2/Gs7+CQMNpDpiCKW
	 XL4grZ2YsobUcMRGAYh4Yo0fwW3Vsjuqs14GlMtc8B7ITUcP2trVwBDqz6JfFY/WUp
	 7gZtdcuEj0nff2KmH4741MJj+fslpo2joPvL7AwgB6aR9I4vBgpwzYK0ZsgiwLun2H
	 Mkj2bDezF9nLGPevq/hZeqfcC0CRe2vfSeoWiJTvrolC39IZVNMXrSnICGaKyzknWH
	 27Tc058QMe3oKoK70u9ZEG2nE9nrZGE7IbZZcjq/YvyMBUQnorl2ntq7AYBW3xmggV
	 hi5Qk1ubs4MYQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-305f529a987so16367831fa.2
        for <kexec@lists.infradead.org>; Fri, 10 Jan 2025 09:33:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW416+0NJclui19W7xoBulPkgGNC11E73HrJwT5mxLPRlB5SUuHQNRV3d58Fpp0j1/oaDB3qQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPFd1k79jz2PPWPwS2wVt29iQLVSCmqsxjxMRGz+r4c5mySeZ+
	EKfb0iUKtPPJt1Mwm+YcO1stpqJzQyrMneqPz3NBPv2hYuteybhPkAuZXWQDXvkrHwogrSvONxy
	kgax6/SC2TyL1IWQOPMM8VNCA7eQ=
X-Google-Smtp-Source: AGHT+IEuxGh8/T/s4PRuzCDPZjJ30Nh6MVT+V5a4g3NgK4duCm/rvIxWbI/taLS4BGyAZZsJuYhCJRUHs5tmVT5suFI=
X-Received: by 2002:a05:6512:3f12:b0:542:6366:762a with SMTP id
 2adb3069b0e04-54284545e1bmr3182431e87.25.1736530418923; Fri, 10 Jan 2025
 09:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com> <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
 <20250110-tricky-grasshopper-of-maturity-21771f@leitao>
In-Reply-To: <20250110-tricky-grasshopper-of-maturity-21771f@leitao>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 18:33:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFjJZKGS1VDcUw3Uw9xB0R5+Q3q-21hojw4NMbr__XmgA@mail.gmail.com>
X-Gm-Features: AbW1kvZLYSGGczVN_3S8j4nI__QcdSl-X1qZVWuLdX8pTn1lTfcnMroSAbHPcAM
Message-ID: <CAMj1kXFjJZKGS1VDcUw3Uw9xB0R5+Q3q-21hojw4NMbr__XmgA@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org, devel@edk2.groups.io, 
	kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_093341_855466_C183AD94 
X-CRM114-Status: GOOD (  26.00  )
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

On Fri, 10 Jan 2025 at 12:36, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Ard,
>
> On Fri, Jan 10, 2025 at 08:32:08AM +0100, Ard Biesheuvel wrote:
> > On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>
> > > I think in the end whoevers' responsibility it is, the easiest path forward
> > > seems to be in kernel? (and not firmware or libstub)
> > >
> >
> > Agreed. But as I pointed out in the other thread, the memory
> > attributes table only augments the memory map with permission
> > information, and can be disregarded, and given how badly we mangle the
> > memory map on x86, maybe this is the right choice here.
>
> If this augmented memory is not preserved accross kexec, then the next
> kexec'ed kernel will be able to find the original table?
>
> I understand that the memattr region(s) need to be always (in each kexec
> instances) `memblocked_reserved` to protect it from being used as a
> System RAM, right?
>
> Thus, if it is not passed throught e820, kexec'ed kernel needs to fetch
> it again from original EFI table at kexec/boot time.
>

Not sure what 'fetching' means here.

> This brings me another question.
>
> If the kexec'ed kernel sees the original memory, why can't it
> augment/update the RX permissions *again*, instead of passing the
> previous augmented version from previous kernel in this crazy dance.
>

I don't understand what original memory means. I think we're talking
past each other tbh.

> > This is a kexec problem (on x86 only) so let's fix it there.
>
> Would you mind explaining what kexec needs to be done differently?
> Should it preserve the augmented memattr table independently if it is
> mapped in e820?
>

I don't know what 'mapped in e820' means.

Let's forget about what the memory attributes table actually contains,
and just assume we can live without it, ok?

So when booting x86 via kexec (which is already detected in
arch/x86/platform/efi/efi.c), the kernel should pretend that the table
does not exist.

