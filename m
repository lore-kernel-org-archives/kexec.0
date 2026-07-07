Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7347C43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 02:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F14JO9nGyTlFXoLxpH2eT/ze9Y3JqkTbj4bOHl+/ark=; b=qDdd/MNTEmcbcqnPx+71wgJ6O7
	NTd/UXznJr721B0lztyQZsohp35vkExWVoQH45vM8TTtmajmcE3nsZhnA0fY4ucY4i86GsCZDDEDD
	q7f8YeYSQHfk6tMngtdFSUFhTHhO0Hqd8b49KVUT9ToKAwfw1eDW2qa5Pu63Vak8TQqLzLC/+vvBM
	MErYv9QgzqBBuH+AN1UA7nmCwG2mcI7YQLjyIElmuza1rEj09/C+5DIlKoSG7+mzkxuSGq79KMscg
	i7LR1vfNiVlmuoz27mYZmKteVBA/+8oeOgeyb2SXKNo5AbJ7rMX0hIXcC27V3rPnHK85Z+7ADMKVe
	hbs/WkNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgvOz-0000000DvLm-3n2d;
	Tue, 07 Jul 2026 02:19:13 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgvOt-0000000DvKi-46zo
	for kexec@lists.infradead.org;
	Tue, 07 Jul 2026 02:19:10 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9506140E016E;
	Tue,  7 Jul 2026 02:18:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XB9zng_J9kHA; Tue,  7 Jul 2026 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783390725; bh=F14JO9nGyTlFXoLxpH2eT/ze9Y3JqkTbj4bOHl+/ark=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArxExbVtB5AsaAfW1bXi41/OnaQ7mm251wIblwAyw89xi2Gpzqkv1YvWTuU+9FdeX
	 5fGEam8gDRi4wwOJGMPUh4jJiO3bfbn+hT3K2GmhNsKTR5nzDpXhWv1sPkn3RzLZdL
	 MNRVojwPbo2qX1CoA1RFM8WBCbD7iQly8al/oyNeNZQeg/LPYo3fQAvmmnQE2nvl0g
	 hpL2BUCyJ542dCJO+CaTJlADCubyPy+ja5ldJXe/hoCf/iqgOWqxe4zwaF7VoERw7K
	 Qg58Suv54AHlqVNyJA7driouH8MWYG9D1AsmLZPWgOutSvGdvFf4DVuTIzufFkqTbb
	 64Qgmiv/ccpU3csgwFtWOZqD2WMeIDMhLXlbJwyFut7wx3kPFCNbkQEI6Ts2wAhl8S
	 AdznCCCpcWH42+c9ZwT90T3wFhJaRBlQcwZhD9h6XchTKE/v4DK3t2NEcjEmYeOEsS
	 /fLX6FhqRMS5bEgHvlTe4vGNEJVnLohKLWQktDgxIRTAVlGlmO0uK4uy4k6ZnM71Bz
	 75b1I31HzOWhllHDgdyJa1Xq40DljTUOaPeBdxUWB6/tucqQnIM1IjkMV1hVjJZG49
	 2ZBBxnM/pjGvsCy5EqKQHhA7riYn7ZbDG/F2htJA/9DX/zGOXtqCU8wyACSTRrnUVD
	 XnPCDsojrTYK25gVVm4ozs3w=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50FE240E00DC;
	Tue,  7 Jul 2026 02:18:35 +0000 (UTC)
Date: Mon, 6 Jul 2026 19:18:32 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v3] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-ID: <20260707021832.GFakxh-I-NNNTujBMH@fat_crate.local>
References: <20260706153751.1166003-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706153751.1166003-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_191908_179846_92A9D35F 
X-CRM114-Status: GOOD (  25.65  )
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

On Mon, Jul 06, 2026 at 05:37:49PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> x86 asm/setup.h includes linux/kexec_handover.h. This is because it is
> used by setup.c and kaslr.c. But this inclusion is problematic. The
> header is included in many places, so it results in the KHO header being
> propagated there. Also, the setup header is used by realmode code. If
> KHO header includes things like mm.h, it causes a big dump of
> compilation failures.
> 
> Nothing in setup.h uses anything from KHO. Remove the header from
> setup.h, and directly include it in setup.c. which does use things from
> KHO. Since kaslr.c is a part of the decompressor, avoid including linux
> headers there directly. Instead, split out struct kho_scratch, which is
> the only thing the kaslr.c uses, and move it to
> include/asm-generic/kexec_handover.h.
> 
> This should also help reduce files recompiled when kexec_handover.h
> changes.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> 
> Notes:
>     Thomas/Ingo/Borislav/Dave, is it okay if we take this patch through the
>     live update tree? I have a patch series for KHO that depends on this,
>     but it is 20 odd patches and I don't want to spam the x86 list with
>     them. So I am sending this change out separately. It is an improvement
>     on its own anyway since it reduces recompilation on kexec_handover.h
>     changes.
>     
>     All the changed files see relatively low patch traffic so chances of
>     conflicts should minimal I think. And if there are any, I imagine they
>     will be relatively simple to resolve.
>     
>     Changes in v3:
>     - Fix changelog nitpicks.
>     - Add kexec_handover.h to generic-y and use asm/kexec_handover.h in
>       kaslr.c
>     
>     Changes in v2:
>     - Do not include linux/kexec_handover.h in kaslr.c. Instead, split out
>       struct kho_scratch, which is the only thing kaslr uses. Move it to its
>       own header in include/asm-generic/kexec_handover.h
> 
>  MAINTAINERS                          |  1 +
>  arch/x86/boot/compressed/kaslr.c     |  2 ++
>  arch/x86/include/asm/Kbuild          |  1 +
>  arch/x86/include/asm/setup.h         |  2 --
>  arch/x86/kernel/setup.c              |  1 +
>  include/asm-generic/kexec_handover.h | 12 ++++++++++++
>  include/linux/kexec_handover.h       |  6 +-----
>  7 files changed, 18 insertions(+), 7 deletions(-)
>  create mode 100644 include/asm-generic/kexec_handover.h

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

