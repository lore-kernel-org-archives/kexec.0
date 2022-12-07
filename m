Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD3C352A1
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 03:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BOvLXrQcAyQ4J5pqjyJnj3mnAvFH+9Dezm2aLcQfpow=; b=m9PxoI0CLfxmy/
	g64OnHnQvkVW7T0H62ag4YzdRlY/Sx74w1Qzdk0V4s1c7p1uNTDZPRcjW9sfesK27YT5f9EaSqOc1
	TThlXQgvIiU8hEzrHtckhOacYi/JlA97vTYtI8afTKdaJIwdIgVG+WoQwMW9PLD12I2e95R15onLf
	M8nsDR6KrzBKs7JiiPnyE7uccupgirDZ6zx4jcfQdeHPJkj1hAFo5kY7tJg0zkD134l536s4sou5i
	1HmNKWWlbup055QODrNrLKhZbQCms2BapoLQd+xwqURgeiNjb/ihPDUMv0OTjzn0yy439sLG6XhsK
	cIctAnzdIZGrsF9NHcAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2lDK-009gFK-Iw; Wed, 07 Dec 2022 03:35:18 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2lDI-009gDv-5j; Wed, 07 Dec 2022 03:35:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id ECFCBB81CB9;
	Wed,  7 Dec 2022 03:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE48C4314E;
	Wed,  7 Dec 2022 03:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670384111;
	bh=jjhc7Y1PVNMbgXEZgFw82tejJpkbGa48gUtRIhqm8SI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sFjMYSBw4IZv/8gm4iYTF/aCs9nLblf2mR+O3NMHxTWtyBxz3f5f7Vpza89wVr6Bh
	 srnuUIHlfx7Ld3vsjvQ0HR0VFSudqD2gqs/5ggcBw1XA0vmmLxYCWzXPJkA3BV1V9f
	 9bhdMqr7ug6AaB0nT86eYEeHZxgiI7gdwk7jjh+dU2FDsV5Ei45CI6lslHozk7Pjk5
	 2HDA4tSvGgUsrCvXD1ShO4jUimDzI4R4InZYAdbot/F+GPwCRjCpH+yBG9lRrNXz11
	 cKSKwBSfrUOGUyqzHlRC4iJKu4uTjN8SbKyIv0dm2WR3Eqd5k+9jvlg5y8+RWfcaYJ
	 SyM+f5Pa0GOVg==
Received: by mail-ed1-f54.google.com with SMTP id f7so23143861edc.6;
        Tue, 06 Dec 2022 19:35:11 -0800 (PST)
X-Gm-Message-State: ANoB5pmIsmheqQ4V66OnHyus3nq/RpVYO1mVDjQMUobj0+EvqIRmAtcR
	fRAfd4kz4JPAHac6wcKgwoK+1/t9VPq6nb+Bsgw=
X-Google-Smtp-Source: AA0mqf6K2XjutXe3T4psbIGhFvGGoXKLPBc10tnHpjB5dxtXJMy3RO1253LIGiKiiGgrtRQQ1/MZOUormc7bxIVFcVs=
X-Received: by 2002:a05:6402:538a:b0:458:fbd9:e3b1 with SMTP id
 ew10-20020a056402538a00b00458fbd9e3b1mr23895842edb.6.1670384109611; Tue, 06
 Dec 2022 19:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
 <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com> <Y4/KoiFhdvRBDdzH@spud>
In-Reply-To: <Y4/KoiFhdvRBDdzH@spud>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 7 Dec 2022 11:34:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQX6361ME9UkOykvUEQifqioLMqovbfpqugkk174pKqfA@mail.gmail.com>
Message-ID: <CAJF2gTQX6361ME9UkOykvUEQifqioLMqovbfpqugkk174pKqfA@mail.gmail.com>
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
To: Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Xianting Tian <xianting.tian@linux.alibaba.com>, 
	mick@ics.forth.gr, corbet@lwn.net, alexandre.ghiti@canonical.com, 
	vgoyal@redhat.com, bhe@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Conor Dooley <conor.dooley@microchip.com>, bagasdotme@gmail.com, dyoung@redhat.com, 
	Palmer Dabbelt <palmer@dabbelt.com>, heiko@sntech.de, anup@brainfault.org, 
	aou@eecs.berkeley.edu, hschauhan@nulltrace.org, yixun.lan@gmail.com, 
	kexec@lists.infradead.org, heinrich.schuchardt@canonical.com, 
	linux-doc@vger.kernel.org, crash-utility@redhat.com, 
	linux-kernel@vger.kernel.org, k-hagio-ab@nec.com, 
	linux-riscv@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_193516_527064_18449380 
X-CRM114-Status: GOOD (  22.45  )
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

On Wed, Dec 7, 2022 at 7:05 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Palmer, Xianting,
>
> On Fri, Dec 02, 2022 at 04:49:39PM -0800, Palmer Dabbelt wrote:
> > On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> > > As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> > > need to update according to Bagas's comments.
> > > https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> > >
> > > As others patches in above patch set already applied, so this patch set only contains below two
> > > patches.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
> >       https://git.kernel.org/palmer/c/649d6b1019a2
>
> So this patch seems to be causing issues for the nommu build:
> https://lore.kernel.org/oe-kbuild-all/202212062250.tR0otHcz-lkp@intel.com/
>
> I had a bit of a poke at trying to see if there were some headers we
> could pull in before actually checking the .config only to see:
> # CONFIG_MMU is not set
>
> Do we have to wrap the whole thing in a `#ifdef CONFIG_MMU` to fix
> compilation here?
The problem does not belong to the patch.

Could I send a fixup patch? like this?

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ef8d66de5f38..d8c07999426c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -512,6 +512,7 @@ config ARCH_HAS_KEXEC_PURGATORY

 config CRASH_DUMP
        bool "Build kdump crash kernel"
+       depends on KEXEC
        help
          Generate crash dump after being started by kexec. This should
          be normally only set in special crash dump kernels which are

>
> Thanks,
> Conor.
>


-- 
Best Regards
 Guo Ren

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
