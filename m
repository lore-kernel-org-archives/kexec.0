Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732F4C87FD1
	for <kexec@archiver.kernel.org>; Tue,  5 Aug 2025 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEkty5pSjbHOXfLGK3b/2w7zBcSKfL70/F2JFetNvmo=; b=h66cfQcRPovDWL5cMJCG/q2huY
	qYJYjvfVjFupEsx4cNd75wLy7+tA4vEB2UQab4fFG7Sliy4rsL5Ucpe7sX8q4z2zIKzYf3Rzt0ltd
	+rDrANN8up6lCqw8FzdoA+fAtQTrS9qW9b27lSh+X+r7HgYvnEqEkVWX+3g0qD/KGpiGrUMPVodiB
	eP0IsFxG7VoCXEqvOG/UES9ITUKUeaYBXO3qCqgKT+ORRzPUkBB1W99E1giAnyEnbU+6aLFWK+LwK
	IC0zm4kR33LXhe20lilYhjPYlw4K0XpFwwnsRihuOgG0fT00J8kF1dv2pds2CLKvxNjCKUMvLTS0S
	Q/DRh2Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujHID-0000000CmGt-44UN;
	Tue, 05 Aug 2025 13:01:25 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujHIC-0000000CmFw-0eUr
	for kexec@lists.infradead.org;
	Tue, 05 Aug 2025 13:01:25 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-af949bdf36cso552391566b.0
        for <kexec@lists.infradead.org>; Tue, 05 Aug 2025 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754398882; x=1755003682; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEkty5pSjbHOXfLGK3b/2w7zBcSKfL70/F2JFetNvmo=;
        b=B+fDmCrDmuZXxWkpNbxfRVi4gK3/qdImZaoJjtPbLLdpv0C6lr0oMXrHkV6uvfAcBs
         i5vl9bUagvriTEyN67c72U+qAKe+/t46DYONptX50jsPj2HmfYoA1vNvW2pFT0bGtnVt
         3uuHmU60oSy1JRDZx1NFX8jeh0zczH8T7eeX6yAra6ug+IRH28ikFXVwzPDgcXAOfeUO
         eIQ/lBGIhPFjpmcJokSJ3UD7E/StzkpNpV38WAILzBY7PI7EK6Lj6nKEI8sVFY38MdCF
         iJ+mTPBZIhvKoAk8FKIWd2m+QZ309Ov/ji6jWfZR/duxluIH/sW7DxE5Iukr9SrXyqdL
         vcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398882; x=1755003682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEkty5pSjbHOXfLGK3b/2w7zBcSKfL70/F2JFetNvmo=;
        b=tF3jF1iHgTj3k9Rv/AsVKg/Ug8lU7mgE14/4mmRMyS+EAw5Er7FakrxW/K9ZzJTMGL
         55/C2PuWTzTG/4CUdjl1+Lqwm0+82csQvNLOelqIYGRsdF5KhDLSN5F+YMcbO5DRLYy/
         /1LpCxtRW767+GkYIbE4WKc3HjPqwkILnLpPRQvSq8zBms2hwdXx/Sbx+NOfmOZVjy2O
         xCpwnNIc/K1hOzWGL9tkJsmZW9TYBdT+omCk2T7Z92bHilffKfzP6/kDg+5RWN4nM85R
         cj0+4rRz4YL5WLHh7cjdK3FuNYSkvQ/1H5vkRyypp8y2gFyLDjBJtggPDjuOZcOPGoix
         S6gg==
X-Forwarded-Encrypted: i=1; AJvYcCWxOdKI3AN6shhUW41Ck1TZzPES6ZMYhDp14N1hcLPuEF7HJWzJ///NrkLD97LK6Avt3Tsj6w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8SrlZetYa0YpnHco84iYf/I1EHhO8OybzwPqiqbZsF78Q5qb2
	DGc+lp9WsyhPtuyZpV/BJ+bU59O3UM/buV4p5PCUyw+iU3NNsSdXxl/kjjH8i3YqJXfFPXQQ2Yk
	lRwdGDhw8eGDXKPMI3KiVa1zQFKxU/O4=
X-Gm-Gg: ASbGncs9NiVttKoZkjYVLgDOBzUxHsh3ntvMVRf35Yz5qknkFZepMore4TwKk2mEvIB
	P7+YQhWavCo2a94LO5uPDsAdzePvg360Bfh89OI07qMEwvFEzl0N9QE0GnPVRu/BUgw3EPWLPlX
	DjonyJmJ/iI2YKXqqtVaVctQccHLdP2Hr31+h1Oo47fNTMZ6/F5y47UlDklMYUaBpfipazj4qL7
	vbMyrClOrOAD6lbJyov
X-Google-Smtp-Source: AGHT+IFZwwwsK6g6+SlIt5VcGjB6Vy07FNc49GbdBGU1A8Q3c7tLSzyDIsrwVFCxrGxdzxLtmpsLg5QkULs927S1HYs=
X-Received: by 2002:a17:907:d8d:b0:af6:ecd1:9e1f with SMTP id
 a640c23a62f3a-af94017d7a2mr1297301666b.29.1754398881998; Tue, 05 Aug 2025
 06:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250805124722.11193-1-safinaskar@zohomail.com>
In-Reply-To: <20250805124722.11193-1-safinaskar@zohomail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Aug 2025 15:00:45 +0200
X-Gm-Features: Ac12FXx1sKFoz4JoBDBRNFphDQBjNLLFJ-yfX1HijzW5x3eLTK__qq19RLCA924
Message-ID: <CAHp75VcUmOrfp21gij_-Ysrk5P=smTpfxmZHWgHU+z_VFZzc+w@mail.gmail.com>
Subject: Re: [PATCH] fix printf string specifiers, otherwise kexec doesn't
 work on my laptop
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_060124_194080_81B4D20E 
X-CRM114-Status: GOOD (  28.52  )
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

On Tue, Aug 5, 2025 at 2:47=E2=80=AFPM Askar Safin <safinaskar@zohomail.com=
> wrote:

Thanks for your report and the fix! My comments below.

> TL;DR: this patch fixes regression, introduced by aecc554e7ba8bd449dceaf3=
eeecacc09b9b77fc4 .

Please, use Fixes tag instead (just before your Signed-off-by) as
Fixes: aecc554e7ba8 ("Correct string specifiers")

> This patch should be backported to all distributions, which packaged v2.0=
.31, otherwise
> kexec doesn't work at all at my laptop with pretty common setup with v2.0=
.31.
> v2.0.31 is broken without this patch.
>
> Recently I found a bug: kexec doesn't work at my laptop.
> Here is my setup:
> * Laptop Dell Precision 7780
> * CPU Intel Raptor Lake-S
> * i915 GPU
> * x86_64
> * UEFI
> * Linux d632ab86aff2cef21f794e337a8e7f2320ac3973 (this is current mainlin=
e)

We don't read cryptic SHA sums, nobody does. Please, use proper tags,
like v6.16.

> * linux-firmware 37b63dc35d98e1fc5c2be95ab7468bf470c20dfd (this is curren=
t main)

Ditto. And so on, all over the commit message which should be more
condensed and have only facts (report) and the summary on how it does
address that. Everything else either should go as a cover letter or as
a comment (after '---' line in the formatted patch),

> * I do kexec from this kernel to the same kernel
> * Kernel is UEFI PE image
> * Secure boot is disabled
> * Kernel config is minimized Debian config
> * I use command 'kexec --debug --kexec-syscall -l /disk/vmlinuz --initrd=
=3D/disk/initramfs.cpio.gz --append=3D"..."', then I execute 'kexec --debug=
 -e'
>
> When I execute "kexec --debug -e", nothing happens.
>
> Bug reproduces on kexec-tools daa29443819d3045338792b5ba950ed90e79d7a5 (i=
. e. current main).
>
> Also it reproduces on kexec-tools aecc554e7ba8bd449dceaf3eeecacc09b9b77fc=
4 , but
> doesn't reproduce on kexec-tools 6aecc32c6db895b1c0b1f522d82c8810ece65542=
 .
>
> I. e. it is regression, introduced by aecc554e7ba8bd449dceaf3eeecacc09b9b=
77fc4 .
>
> Okay, why the bug happens? I suspect this is because aecc554e7b introduce=
d "%lux"
> string specifiers, which are totally wrong. The author meant "print in he=
xademical"
> here, but this specifier prints number in decimal, followed by literal "x=
". Oops.
> And this seems to break kexec.
>
> Okay, how to fix this? Well, this is not easy. In 07821da7cf and d2f42971=
66 Andy Shevchenko
> observed compilation warnings, when %lx is used with uint64_t, so he repl=
aced %lx with %llx.
>
> Then in aecc554e7b Jeremy Linton observed warnings with %llx and replaced=
 it with %lux.
> (Yes, C is nightmare.)
>
> So, uint64_t is sometimes defined as long unsigned, and thus needs %lx, a=
nd sometimes as
> long long unsigned and thus needs %llx.
>
> How to fix this once and for all?
>
> I see three ways.
>
> 1. uint64_t a; printf ("%llx", (unsigned long long)a);

Bad due to explicit castings for POD types.

> 2. uint64_t a; printf ("%" PRIx64, a);

Good.

> 3. uint64_t a; printf ("%w64x", a);

Haven't heard about it. Which C/POSIX/etc standard is this?
(But again, no based on your own words)

> %w64x is most clean and beautiful of all, but it causes compilation warni=
ngs on clang. (Facepalm.)

In one sentence you have a contradiction. If it's nice, clean and
beautiful, it should work, but it doesn't.

> PRIx64 is ugly, and other people will probably fail to understand it.

It's a standard and it works. This is how we should address this.

> So I chose explicit conversion to unsigned long long.
>
> Also this patch does these things:

Please, make this a series, we usually don't combine / squash patches.
It's not a GitHub flow.

> * Remove extra whitespace in kexec/arch/arm64/crashdump-arm64.c introduce=
d in aecc554e7b
> * Remove duplicate <stdio.h> in kexec/arch/i386/kexec-x86-common.c
> * Fix "prink" typo in util_lib/elf_info.c
> * Fix %lux in kexec/kexec-elf-exec.c , introduced long before aecc554e7b
>
> I tested this patch on my laptop.
>
> Fixes: aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4

Please, use a better format (see above).

...

And thanks for Cc'ing me, I really appreciate your analysis and work,
just style issues and approach should be changed.

--=20
With Best Regards,
Andy Shevchenko

