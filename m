Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059A6C28B28
	for <kexec@archiver.kernel.org>; Thu, 13 Mar 2025 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2wVH/+uVa56tL6a/6AWA++ewImTFb95ux60x2+KI2M=; b=1V4cX1AgyuLKUZfGGORVKjKZl6
	vhM3zGkOr6MEthYv2fPHnagPbthVkBMc9kqS8rEjOYxcDK+ABnjaTyXKjmsj8JwzDBmm4HbzT0lbQ
	ajxq+ljyGUjWiFfGOwJHFqqwwmQQ0Fw8ctgMPCLTXnm1d7nG4FLYS5KMsx2aFobR+1Iw1ZGzd1JJh
	sDExD0ow8gEv1yki8Z6uyly07Gmsaf8bgqG+a64QawaRNmGtenPSfbP1He8gBH0vKhFExLyaNOUf8
	n3uet60HiI8M+Te1YNt0kzEwwHgOgmtIvTTeSWoXjx/fReW3k4KLv9L/IjQFEynlFXQvHagiMk5J9
	I2xHz6Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsgES-0000000AxKT-46Vg;
	Thu, 13 Mar 2025 10:56:08 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsg3V-0000000AvCc-0p2r
	for kexec@lists.infradead.org;
	Thu, 13 Mar 2025 10:44:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 86DE1A4657A;
	Thu, 13 Mar 2025 10:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E27C4CEDD;
	Thu, 13 Mar 2025 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741862688;
	bh=Ea/nF/6yF8q+yD6HjryxJLrzxjPzAhV6V2F/wso++vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfwuO4E7CBH0225uI4SAo32VIdUKvpQ2GRBTZkOarnahlXaW9r933s3zWIgLiurhe
	 /RZbf0TQLYgyWwGN9gqyZ067XyA3AUe60Z8xL9UB1KynBpWSH4tReS6K+hvnwgxUMj
	 RQEFKCEbTeXXH7uyPtnlm/aqiZ+hAZFrJLW/WS2JLmVS2Ouc4QKk9vY3dRLzykS2a7
	 1PJsvBSbGr53MrI9FvxGdwaDom62AUo68cqHlP3dHM2G6cIwm3WH1fskmz0nubAen/
	 F5XtF8pZjchZ5e2ZHS83RaIVya7AcB73xx3N3IR/0JYmJVXdsZx+KjYGCVdMP2pQc/
	 2x86DWb/qTzwQ==
Date: Thu, 13 Mar 2025 11:44:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v7 7/8] [DO NOT MERGE] x86/kexec: Add int3 in kexec path
 for testing
Message-ID: <Z9K3GXSaZUcVr8cb@gmail.com>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
 <20250312144257.2348250-8-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312144257.2348250-8-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_034449_342157_247FA87C 
X-CRM114-Status: GOOD (  17.43  )
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
>  arch/x86/kernel/relocate_kernel_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 17d41e6e1a4b..2b7fc59af373 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -158,7 +158,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	lidt	(%rsp)
>  	addq	$10, %rsp
>  
> -	//int3
> +	int3

So this is all boot-serialized functionality with no SMP concerns 
whatsoever, right?

If yes then we could use something like this:

	static int exception_selftest = 1;

and add the INT3 point:

	int3
.globl after_int3
after_int3:

And do this in the early exception handler:

	...
	
	if (exception_selftest) {
		exception_selftest = 0;

		print_something_warm_and_fuzzy();

		IRET-to-after_int3;
	}

	...

	... regular exception path ...

... but all in assembly or so ;-)

This would make it reasonably certain that the most complex bits of 
this new debuging code are in working order, all the time.

Thanks,

	Ingo

