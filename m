Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A5ECD5BD0
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/TRhXlL7M+bh0nA0422zvkrUv8DgtfhlLo+sCPkC9ec=; b=PvHTwA3Z43r0ASbMXaD7piaoZt
	YuWM1VRsD+ij3rr+eO4d93QuOOs727eZq8pXahzh56KW71h+xPBzz0B2DXr1jlIgyp3dkTnn7jESf
	ZzC2r6RhIo4YBSNg2HgG6zBMRbT0WYZe+m+OnvBikGKKcuA4ZHj//sixtXL2l5JH2hNxOw829aAMf
	yBQ/hMZZmwhh6+i4XZKWomh9v8ZFTMBxkQnoSRW35dv29/1D2VKWR58O2S7O6w1m7goBWVh0B4cKE
	7CHHgX6wrgbu1sD6ke3JXDV5vw6yteikqlOt7MxNps0g98aWyhK4TR8BePmzMgPZ3Uuy1zL5ILvLE
	e810QiFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRSUO-0000000GwXL-2Ipz;
	Mon, 25 May 2026 10:24:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRSUL-0000000GwWf-1wSF
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 10:24:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B50443E70
	for <kexec@lists.infradead.org>; Mon, 25 May 2026 10:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DA31F00A3D
	for <kexec@lists.infradead.org>; Mon, 25 May 2026 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779704688;
	bh=/TRhXlL7M+bh0nA0422zvkrUv8DgtfhlLo+sCPkC9ec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bf8jOchER9UmNKlRNawyfjT1ivoJbbX7MT8VhTo5F9z75N9pO7kJWma7lGm2m/kHn
	 I1QhvcGCNQQ959H+Iprj7T7YtUPqToevhsV9cjOvPTugFQcrE4VSaJ9e89NtmJ2Gbn
	 wSoQIo7Mk/kQscLsnw8D6Hn2AD+T8usnAbwODg84DK057URyMq/ffh3YrYex4N5fou
	 fU0q/B2ilf3olT08OalSriAvL81oPOcPhZl8UoCm0VfjJDFtwrx6jrgIw0M3w4zgwC
	 gnRyCF3XJTAt0kYZ0+YH+4dXUoPDSLFQrGOiIEMVZJ5nS6ixOvnuIJ1vnYN8E9LDkh
	 VFyPdNxtyHRRQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso1713180066b.1
        for <kexec@lists.infradead.org>; Mon, 25 May 2026 03:24:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/KLTgzkBPdcplqrSf6Q1McRw+R/6vAfSjPilXxKAqRhYqLnISwTzxY2ITArPwQR1hToqPrw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwSp3YJFSNSfy7tbNsrtGVqM9jAAwIoMXpyKU2FgHEItJPCKn1u
	oP4nf0b8+kRq9AR/p521VsR4CMi24VUzy0PFAwq9Ey9Ggqv36tauGrq6+ok23BJM3ls1Q1VdlkH
	dqKsRjvR3X2LdbHnf+MthQ2obuOoJ6Jw=
X-Received: by 2002:a17:906:dc8b:b0:bd2:aeaf:470c with SMTP id
 a640c23a62f3a-bdd267c8024mr853835966b.40.1779704687546; Mon, 25 May 2026
 03:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260525062810.103367-1-dongtai.guo@linux.dev> <177969529480.4047269.2120994507098781563.b4-review@b4>
In-Reply-To: <177969529480.4047269.2120994507098781563.b4-review@b4>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 25 May 2026 18:25:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4p8xe_Hfx81kjxNrp5g7RKvi4f1QM7avLvnf_r+VazFA@mail.gmail.com>
X-Gm-Features: AVHnY4LTd0Kg3PKCCZqbfiXECjfM-2DhE2l34GPEKNdQUAn6_sdoLxbmWOkvxmI
Message-ID: <CAAhV-H4p8xe_Hfx81kjxNrp5g7RKvi4f1QM7avLvnf_r+VazFA@mail.gmail.com>
Subject: Re: [PATCH 0/7] LoongArch: add KHO support and selftests
To: Mike Rapoport <rppt@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	kernel@xen0n.name, graf@amazon.com, shuah@kernel.org, 
	loongarch@lists.linux.dev, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_032449_539678_44E99193 
X-CRM114-Status: GOOD (  25.04  )
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

Hi, Mike,

On Mon, May 25, 2026 at 3:48=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Mon, 25 May 2026 14:28:03 +0800, George Guo <dongtai.guo@linux.dev> wr=
ote:
>
> Hi,
>
> > [...]
> >
> > Bug fixes (patches 3-4)
> > ------------------------
> > Patch 3 fixes a build failure with CONFIG_KFENCE=3Dy: virt_to_phys() an=
d
> > phys_to_virt() in asm/io.h expand to use offset_in_page() and
> > page_address(), which require <linux/mm.h> that was not included.
>
> This fix looks unrelated to KHO, it makes sense to send it as a separate
> patch.
He tried, but it causes new problems, but I agree this patch has
nothing to do with KHO.
https://lore.kernel.org/loongarch/202605211925.DbDvQ6ii-lkp@intel.com/T/#t

>
> >
> > Patch 4 moves KEXEC_CONTROL_CODE from 0x100000 to 0x180000.  QEMU
> > places its machine FDT at 0x100000 when booting with '-kernel'; the
> > previous placement silently overwrote the FDT with the relocation
>
> And I believe that patch 2 and patch 4 can be folded into patch 1 so
> that addition of KHO support will be a single patch.
Patch 2 should be folded, but Patch 4 can be separate, because it
should be backported.

>
> > trampoline, breaking earlycon in the kexec'd kernel.
> >
> > Selftest support (patches 5-7)
> > -------------------------------
> > Patch 5 adds loongarch.conf and extends vmtest.sh to recognise
> > loongarch64 as a build target.  QEMU's LoongArch virt machine is
> > FDT-only (no ACPI), so 'earlycon' must appear on the kernel cmdline or
> > the console UART is never discovered and the test log stays empty.
> >
> > Patch 6 disables SERIO_I8042 and its dependents in the QEMU_KCONFIG
> > fragment.  QEMU's LoongArch virt machine has no i8042 controller; the
> > fallback port probe hits a page fault on the memory-mapped I/O range an=
d
> > panics before reaching userspace.
>
> This should be folded into patch 5 for sure.
I completely don't know why Patch 6 is needed, for normal use I8042
doesn't cause problems in virtual machines.

Huacai

>
> >
> > Patch 7 polls the serial output for the test verdict and kills QEMU onc=
e
> > it appears.  QEMU provides no EFI runtime services on LoongArch, so
> > machine_restart() falls through to an infinite idle loop and QEMU never
> > exits after kexec.
>
> And since without this selftest would hang on loongarch, the timeout
> handing should be folded into patch 5.
>
> In general, the rationale when adding new features is to make sure that
> after each patch there are no regressions and the new functionality
> either works or cannot be enabled until completely implemented.
>
> --
> Sincerely yours,
> Mike.
>

