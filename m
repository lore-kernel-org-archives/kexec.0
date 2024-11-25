Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF3D3B7F5
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I//hAEE8MKxBMqwX3GwD9LChxJf4k3K/9I/S2YVPyFE=; b=OkPmv/z+ONiRKolEqCESzYKOVU
	nAQJDNw7wojk41MROgf2Xxa5SektUp7Ob7AQup8Fydbi7wY0UueGFw3SrWeUPaC2m0w9FqAl/J6s/
	zhPRVCTATLr0rNnqbo/h8uMcbCo11benZ/HfoFzzcINbgkBX38zW2klB5evYNG68lrIOB4vcCDHZv
	OwopZJ7MHVgtFWSHeR96XyqCpbA6InVBGOoJ9zniIiCEhkYIvrUl5Ki+kkv4FJ5uXt3Xa3ERdACEd
	/K+QwrwDU0qBPh1fMkHX7zjA6L92PvKj/K3aLOhKFnCuAgf3XKo+mi0NWIvwJrENMoTHsNEdgEclE
	AMuK2m7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFVHl-00000007Xk6-0x9G;
	Mon, 25 Nov 2024 09:21:37 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFVHj-00000007Xj9-07H2
	for kexec@lists.infradead.org;
	Mon, 25 Nov 2024 09:21:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2D6F3A40341;
	Mon, 25 Nov 2024 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0721C4CECE;
	Mon, 25 Nov 2024 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732526493;
	bh=41tMkIJtT7b3R8KkSORNC7wCoYnqYUvK888UHmzzwMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egsdHaO9hZDI3pmBuKqMoQhZINxlIXxL39nYSriz94LFkWtkgA1I+jBuVfvPRPmGr
	 0Dexh+04FduuOEehqPdKm/lqXYtyv5eme18jVGcmgnNNq8VbWrPIOCtOex4RB04kLo
	 YDZCo0G4Vnu5WW1oofSmYkeaqhqLol2rOsXVQb+cQaVrBPH+g/AUmqKQqq3N30t+Wv
	 h4ZHTs+uNqEBTunWBhdKoaVYoYTJSEEdtZ5gSzClHmMp/W0emJbBvrNJfaDyEHWGDw
	 2y9mned0Z6oj7U6bhMj5qw7bkkY48CYJ/x5P42oMQl1z+x11BDRKlaQE7EzStoeyyQ
	 j9OZIhjJ3rg/Q==
Date: Mon, 25 Nov 2024 10:21:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 16/16] [DO NOT MERGE] x86/kexec: enable DEBUG
Message-ID: <Z0RBl6pzNf5irop9@gmail.com>
References: <20241122224715.171751-1-dwmw2@infradead.org>
 <20241122224715.171751-17-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122224715.171751-17-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_012135_128210_B64388C7 
X-CRM114-Status: GOOD (  17.96  )
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


* David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 67f6853c7abe..ebbd76c9a3e9 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -14,6 +14,8 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/unwind_hints.h>
>  
> +#define DEBUG
> +
>  /*
>   * Must be relocatable PIC code callable as a C function, in particular
>   * there must be a plain RET and not jump to return thunk.
> @@ -191,6 +193,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	pushw	$0xff
>  	lidt	(%rsp)
>  	addq	$10, %rsp
> +
> +	int3
>  #endif /* DEBUG */

That's a really nice piece of debugging code written in assembly, 
combined with the exception handling feature that generates debug 
output to begin with. Epic effort. :-)

Just curious: did you write this code to debug the series, or was there 
some original hair-tearing regression that motivated you? Is there's an 
upstream fix to marvel at and be horrified about in equal measure?

I'd argue that this debugging code probably needs a default-off Kconfig 
option, even with the obvious hard-coded environmental limitations & 
assumptions it has. Could be useful to very early debugging & would 
preserve your effort without it bitrotting too obviously.

Thanks,

	Ingo

