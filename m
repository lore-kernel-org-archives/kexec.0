Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579E8D216B5
	for <kexec@archiver.kernel.org>; Thu,  4 Dec 2025 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUx19gRPJQTm4oWcB8wA8j6Dup+z8ZZpv7z/N3R45CY=; b=bU0INtkwkwoESTmss/zMJeLpxg
	bAbqmH934HdFo8nfDGy1eu+CG8bomSM/xvTE5oI43KHjOzUIsz4Ax9+knqibHnOn8xVSX5sxSkxME
	DPP/vOEnpdBMwUMFKZ2uS4rnSnl/P5zFyZiUvx3c64OSf/qm+qFZYap3CuSWVrW6Maq7PWIUCB7lR
	b+yaHpgeHv2i7DARCniO6KvrbG0xmDbm+v9wPuo/aWqMBDEA9b1K//Cko7AtAEL3GQc2GHn3b9gER
	KrTo7RChusaYjmCUNJlzRZ9yBQpADGD5z2RYxcJUWagzsu2ooBzuPvWUNxBOYdS74L8vLKceUfoAI
	sFr3beMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCME-00000008Ibi-3zVN;
	Thu, 04 Dec 2025 16:39:06 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRCMC-00000008Iaj-2xVj
	for kexec@lists.infradead.org;
	Thu, 04 Dec 2025 16:39:06 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-42e2b78d45bso580950f8f.0
        for <kexec@lists.infradead.org>; Thu, 04 Dec 2025 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764866342; x=1765471142; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUx19gRPJQTm4oWcB8wA8j6Dup+z8ZZpv7z/N3R45CY=;
        b=kFjSLn01+k3/RZ9yZAGfU3GzFadUdaD6R2YDasOc6FO1/3sewRzobKH69K6YJ3hv88
         GnbYHNw7v1/eenhn8N7em/S4b8zvWzHnBdCEilp32S5EAARdeHW1NQvXXLaHuNghSbhD
         QuCg/Vd8fsRyw/X18Oi8UqUaZ7Z99nMb1/IxJsZ85/dgdUPgk3jV5p+KxZuLyXD/atT6
         2m3/EWexLqvPkE0S6qZOwrZbdMGgNPyzwH9TioCz9v3h/S+MmTqY26f7nDhS5Kefsa9x
         GwOqbpHT17Svw2mfIdlUvtVt9A9rIso6/G708WRF0Tgh2h1myLVwtrkcTzqWwqbMh4bc
         QSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866342; x=1765471142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUx19gRPJQTm4oWcB8wA8j6Dup+z8ZZpv7z/N3R45CY=;
        b=arTjdoVprCdcI5qhSRtW6eGlwoKa/GZlj5HtupM1ylj7okPBdcfwBjYQInFu+D7Pa8
         rWt02D8tj+hK42b5J8WITsld5Q/qtqAKJKzHH07CCfq+8DQUXNVN4zPFWyUol4Q6yPq2
         FYxu5qSsuCX5yKBRRJ9/e9ImYdAXijzLfs8B9rPwcmWW0SoIkks7q5b1vuxDgsimsgVh
         RaRztyQKP9zhztkqOFGfoPMhxT6jH7va6JpCGsDYcOKiCLUo7KK/AmABs5UfBBgeEErv
         9IaSM9tIryNmMubZuMoYiaqHNzst23O6VU4AuLebJUxO+mNvXsCn8UkmL50hWx2cvRL+
         CuKg==
X-Forwarded-Encrypted: i=1; AJvYcCWmIyo7OgIuyWtKF8lxn1vWVAV5nrXx7tl0farHHU1DrtZ+0+Hkibi4mbCepej/XzVxkPRjdw==@lists.infradead.org
X-Gm-Message-State: AOJu0YynFd++ckieCItVP+lVwMNR2I5nQrwQBIBMRKBSewdqBNHNUYZO
	p+Bdf20Hfrnor1E73Ko+xY3Z349bHMEp/IbetIsEGmEuJB6Yyp5hEnB1NdO4+HUMvSrYVL+jVA2
	QR8R3AVLnF0y2J4u7t9mc50GrlqnNUtc=
X-Gm-Gg: ASbGncsATkDvsfLs+khE5Kj+XFWqyeo/6EMycc5VpQgJHAHbeG+5CXY/ZFTnBRnQrke
	iLE0vs7vQooHrdZwymwtxRsiE7SueeuEtog7g4IHqlUKBg4OYW0hPrGlp7ThzFi8749xPKyC2mM
	uETcM0sPAyedLZlNx4cJqjhSFEB4Gspaqjs92Vv2lqZbttE+oN87VD9nz+6wPWGHBcxGg+PmgVj
	CYz/OE3IW4R9EffR+zl7W8BnJnHtMyCzESj8zeBQ5X8deNtrVCV+N+uFF5defWcryWlOGms379w
	EbgoEh93T62KwD6oQ0wsA7XWsBSl
X-Google-Smtp-Source: AGHT+IGchSnUrQ/wDgunFbKiGCgSohOTthx/72He3/1KfLAp2MSCE2NdUITIhsFDOGle4TG+EFrRDmD4Qe376vybhIo=
X-Received: by 2002:a5d:64c5:0:b0:42b:383d:9c8e with SMTP id
 ffacd0b85a97d-42f731c2e72mr7003661f8f.41.1764866342105; Thu, 04 Dec 2025
 08:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20251128033320.1349620-1-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-1-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Dec 2025 17:38:49 +0100
X-Gm-Features: AWmQ_bmhKUWGLOGRduhfezxTuPYTkb1LvtYgmV18KfelSCQT0T4sQ7pI9eJTnYc
Message-ID: <CA+fCnZcVV5=AJUNfy6G2T-UZCbAL=7NivmWkBr6LMSnzzTZ8Kg@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, elver@google.com, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_083904_784598_500D9490 
X-CRM114-Status: GOOD (  38.29  )
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

On Fri, Nov 28, 2025 at 4:33=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=3Don|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
>
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> while in fact it's meaningless to have kasan in kdump kernel
>
> There are two parts of big amount of memory requiring for kasan enabed
> kernel. One is the direct memory mapping shadow of kasan, which is 1/8
> of system RAM in generic mode and 1/16 of system RAM in sw_tags mode;
> the other is the shadow meomry for vmalloc which causes big meomry
> usage in kdump kernel because of lazy vmap freeing. By introducing
> "kasan=3Doff|on", if we specify 'kasan=3Doff', the former is avoided by s=
kipping
> the kasan_init(), and the latter is avoided by not building the vmalloc
> shadow for vmalloc.
>
> So this patchset moves the kasan=3Don|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=3Doff in kdump kernel to reduce the unneeded meomry cost fo=
r
> kasan.
>
> Testing:
> =3D=3D=3D=3D=3D=3D=3D=3D
> - Testing on x86_64 and arm64 for generic mode passed when kasan=3Don or
>   kasan=3Doff.
>
> - Testing on arm64 with sw_tags mode passed when kasan=3Doff is set. But
>   when I tried to test sw_tags on arm64, the system bootup failed. It's
>   not introduced by my patchset, the original code has the bug. I have
>   reported it to upstream.
>   - System is broken in KASAN sw_tags mode during bootup
>     - https://lore.kernel.org/all/aSXKqJTkZPNskFop@MiWiFi-R3L-srv/T/#u

This will hopefully be fixed soon, so you'll be able to test.

>
> - Haven't found hardware to test hw_tags. If anybody has the system,
>   please help take a test.

You don't need hardware to run the HW_TAGS mode, just pass -machine
virt,mte=3Don to QEMU.

I also wonder if we should keep this kasan=3Doff functionality
conservative and limit it to x86 and arm64 (since these are the only
two tested architectures).

>
> Changelog:
> =3D=3D=3D=3D
> v3->v4:
> - Rebase code to the latest linux-next/master to make the whole patchset
>   set on top of
>   [PATCH 0/2] kasan: cleanups for kasan_enabled() checks
>   [PATCH v6 0/2] kasan: unify kasan_enabled() and remove arch-specific im=
plementations

Note that are also:

[PATCH 1/2] kasan: remove __kasan_save_free_info wrapper
[PATCH 2/2] kasan: cleanup of kasan_enabled() checks

But I don't know if there will be any conflicts with these.

>
> v2->v3:
> - Fix a building error on UML ARCH when CONFIG_KASAN is not set. The
>   change of fixing is appended into patch patch 11. This is reported
>   by LKP, thanks to them.
>
> v1->v2:
> - Add __ro_after_init for kasan_arg_disabled, and remove redundant blank
>   lines in mm/kasan/common.c. Thanks to Marco.
> - Fix a code bug in <linux/kasan-enabled.h> when CONFIG_KASAN is unset,
>   this is found out by SeongJae and Lorenzo, and also reported by LKP
>   report, thanks to them.
> - Add a missing kasan_enabled() checking in kasan_report(). This will
>   cause below KASAN report info even though kasan=3Doff is set:
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>      BUG: KASAN: stack-out-of-bounds in tick_program_event+0x130/0x150
>      Read of size 4 at addr ffff00005f747778 by task swapper/0/1
>
>      CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #8 PREEMPT(=
voluntary)
>      Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F31n (SCP: 2.1=
0.20220810) 09/30/2022
>      Call trace:
>       show_stack+0x30/0x90 (C)
>       dump_stack_lvl+0x7c/0xa0
>       print_address_description.constprop.0+0x90/0x310
>       print_report+0x104/0x1f0
>       kasan_report+0xc8/0x110
>       __asan_report_load4_noabort+0x20/0x30
>       tick_program_event+0x130/0x150
>       ......snip...
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Add jump_label_init() calling before kasan_init() in setup_arch() in th=
ese
>   architectures: xtensa, arm. Because they currenly rely on
>   jump_label_init() in main() which is a little late. Then the early stat=
ic
>   key kasan_flag_enabled in kasan_init() won't work.
>
> - In UML architecture, change to enable kasan_flag_enabled in arch_mm_pre=
init()
>   because kasan_init() is enabled before main(), there's no chance to ope=
rate
>   on static key in kasan_init().
>
> Baoquan He (12):
>   mm/kasan: add conditional checks in functions to return directly if
>     kasan is disabled
>   mm/kasan: move kasan=3D code to common place
>   mm/kasan/sw_tags: don't initialize kasan if it's disabled
>   arch/arm: don't initialize kasan if it's disabled
>   arch/arm64: don't initialize kasan if it's disabled
>   arch/loongarch: don't initialize kasan if it's disabled
>   arch/powerpc: don't initialize kasan if it's disabled
>   arch/riscv: don't initialize kasan if it's disabled
>   arch/x86: don't initialize kasan if it's disabled
>   arch/xtensa: don't initialize kasan if it's disabled
>   arch/um: don't initialize kasan if it's disabled
>   mm/kasan: make kasan=3Don|off take effect for all three modes
>
>  arch/arm/kernel/setup.c                |  6 ++++++
>  arch/arm/mm/kasan_init.c               |  2 ++
>  arch/arm64/mm/kasan_init.c             |  6 ++++++
>  arch/loongarch/mm/kasan_init.c         |  2 ++
>  arch/powerpc/mm/kasan/init_32.c        |  5 ++++-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  3 +++
>  arch/powerpc/mm/kasan/init_book3s_64.c |  3 +++
>  arch/riscv/mm/kasan_init.c             |  3 +++
>  arch/um/kernel/mem.c                   |  5 ++++-
>  arch/x86/mm/kasan_init_64.c            |  3 +++
>  arch/xtensa/kernel/setup.c             |  1 +
>  arch/xtensa/mm/kasan_init.c            |  3 +++
>  include/linux/kasan-enabled.h          |  6 ++++--
>  mm/kasan/common.c                      | 20 ++++++++++++++++--
>  mm/kasan/generic.c                     | 17 ++++++++++++++--
>  mm/kasan/hw_tags.c                     | 28 ++------------------------
>  mm/kasan/init.c                        |  6 ++++++
>  mm/kasan/quarantine.c                  |  3 +++
>  mm/kasan/report.c                      |  4 +++-
>  mm/kasan/shadow.c                      | 11 +++++++++-
>  mm/kasan/sw_tags.c                     |  6 ++++++
>  21 files changed, 107 insertions(+), 36 deletions(-)

One part that's still missing is a Documentation change.


>
> --
> 2.41.0
>

