Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49B0C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B0pffB1QSJNfKenNayqb6HHqBKQaFztAnU/0phK3Zg8=; b=X5ADHZfpCfvVqTCWUkKHrznieP
	HSat+++pvsdMnpYk+3hdZcPoZjATnmmF/DaRfxg6SvLIXUp+AeNcI+Vjeg4ZgJtZzz5J5H74VVWDZ
	Ii1UzFnH10E3AzigQ4oBg6Bxan+5zY11x+7DXnYCgqNzA2WUadcPZx0UA4BmQGCVHcRzpHzGX9IkO
	VSiCFOSVYeg47k7uHUw3hm3ZagoYYaUGDt7QV0P61jw2ImGR8wa//nUmveSwYOLS584eL0UZQR+2c
	qr4WKjdO//vJTqo9h42Kgm8sXaZWjeQaUJn4sMHWtCoCpQgnt2D9xDE0V0UKubC5Nog+Nk22yIq+h
	UaBBOdNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfhqb-00000007cC2-1xHL;
	Fri, 03 Jul 2026 17:38:41 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfhqY-00000007cBJ-3Ntv
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 17:38:40 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1E58E40E022C;
	Fri,  3 Jul 2026 17:38:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IRKCZMeHY5ye; Fri,  3 Jul 2026 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783100305; bh=B0pffB1QSJNfKenNayqb6HHqBKQaFztAnU/0phK3Zg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzCd6HrH80StngfmF2An7RwLfMOsHtiWZIJBybG4oxBedWa1rojsh7UecaE7aLQjD
	 YBGF43MSC00MREu0BbYWT9Hzfwc7eeo8EUiO2K1SYY72uY3WPINIWXiPadpLz7jc/8
	 oH8h16Vc0nEs7I8LVMQdyRYewNix7HeKJOKbhqPaHGWJumpf55090Pa2Q6JYXzJud8
	 4y/Jcq9ggNRuFIqkmi5LOv/2BX3SC9gQLqCChpSiOJcHAAx5mYF80RESO7ZLAGGCw0
	 3saxbpEHBntl899shr51OqWzArSQVUKB/wt4cea9TsJumg5boDRtqooS2wSrjYOKJq
	 Iy/i8oFEoJsIkARbSV+4EfOW7sIhrGZuAJrLoLOApgRR0JVYmSnr0evjhVQLxj5rSu
	 X0YJwoonGqnRIk4uFBDZ4F62TDQ6ZpEr9QgCTRMbXW/LcHQJcY5bL5MzkRUOqCncYh
	 QY1Q/hi9xA3Cfo7cNde3989D0+K16ZJaEz4wxHE8ANE3XVVUMdEiKZQIDM8QP7Edl4
	 580pndnuqJUmEUtZWq7vOhORxQKr07sHP8DsC60d955V9g6/w8o/PcJKJbi9MgvAyX
	 YXj3/RxEKtnP0UHPjzb8qHMMlOHvzqWUT/3xVZLtqPSjQYGe0HgWF2mcAMBaGkR2oS
	 yHhFB4jUxo0Xv8mOdcvheYX0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6000E40E016E;
	Fri,  3 Jul 2026 17:38:14 +0000 (UTC)
Date: Fri, 3 Jul 2026 10:38:10 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-ID: <20260703173810.GDakfzgqRx9e9kiUpF@fat_crate.local>
References: <20260703143705.2525168-1-pratyush@kernel.org>
 <20260703153044.GCakfVpO_egX4B9y_1@fat_crate.local>
 <2vxzjyrcf3ei.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2vxzjyrcf3ei.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_103839_006244_1030072B 
X-CRM114-Status: GOOD (  21.26  )
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

On Fri, Jul 03, 2026 at 06:23:33PM +0200, Pratyush Yadav wrote:
> On Fri, Jul 03 2026, Borislav Petkov wrote:
> 
> > On Fri, Jul 03, 2026 at 04:37:03PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> x86 asm/setup.h includes linux/kexec_handover.h. This is because it is
> >> used by setup.c and kaslr.c. But this inclusion is problematic. The
> >> header is included in many places, so it results in the KHO header being
> >> propagated there. Also, the setup header is used by realmode code. If
> >> KHO header includes things like mm.h, it causes a big dump of
> >> compliation failures.
> >
> >> Nothing in setup.h uses anything from KHO. Remove the header from
> >> setup.h, and directly include it in setup.c. which does use things from
> >> KHO. Since kaslr.c is a part of the decompressor, avoid including linux
> >> headers there directly. Instead, split out struct kho_scratch, which is
> >> the only thing the kaslr.c uses, and move it to
> >> include/asm-generic/kexec_handover.h.
> >> 
> >> This change should also help reduce files recompiled when
> >
> >> kexec_handover.h changes.
> >> 
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> ---
> >> 
> >> Notes:
> >>     Thomas/Ingo/Borislav/Dave, is it okay if we take this patch through the
> >
> > See my reply to Mike about using the generic-y infrastructure.
> 
> To double check I got your point correctly, is this what you mean?
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index ac02aed8757b..22267a83e064 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -32,7 +32,7 @@
>  #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
>  #undef _SETUP
>  
> -#include <asm-generic/kexec_handover.h>
> +#include <asm/kexec_handover.h>
>  
>  extern unsigned long get_cmd_line_ptr(void);
>  
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
> index 078fd2c0d69d..47ef8cb482e3 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -15,3 +15,4 @@ generic-y += fprobe.h
>  generic-y += mcs_spinlock.h
>  generic-y += mmzone.h
>  generic-y += ring_buffer.h
> +generic-y += kexec_handover.h
> 
> -- 

Looks about right, AFAICT.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

