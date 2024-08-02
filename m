Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53274C3DA4A
	for <kexec@archiver.kernel.org>; Fri,  2 Aug 2024 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1T5vWw8k/SjjszQENzJRSit7P7p4jPBMp63GK/3I8kg=; b=ctUQWuOTl3w8gKNf1t5GblHb/f
	vC0FVSN/NyfQIB2JTnVTyo4BA0sotskZ/BgEyhOmyHw0Fhu3w4cDbtdjjLVDcUHY/OiRPmJ/IEcLD
	K7ziDQTo0x0TLWfvJwxznH5K2uvX0dnTJhLrzl0qd8DZegtnJ48XIH3q3kYcGkE7Wa2uiGrqxcMvx
	K+Udv0TldcOlBqtseqjbnts2jnsfGcjCXIsAMPvrmThs8LQaGoJiMLo5uDSpqPniHFLNJwGZzciSc
	ghOuQmbH/ZSgWYwC/kOTVyS2AIIOMNkjyKjHXBJ3iZIjHIYmyogmwu3A/EkJWPcc4UbFKO7AxfOrk
	uVUZXYOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZrKf-00000008nUd-0cyo;
	Fri, 02 Aug 2024 12:24:29 +0000
Received: from relay1-d.mail.gandi.net ([217.70.183.193])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZrKa-00000008nSH-2gHj;
	Fri, 02 Aug 2024 12:24:27 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FA4124000B;
	Fri,  2 Aug 2024 12:24:20 +0000 (UTC)
Message-ID: <ce86ad6b-5f56-4856-9756-fa8867d0d1df@ghiti.fr>
Date: Fri, 2 Aug 2024 14:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, chenjiahao16@huawei.com, akpm@linux-foundation.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240802090105.3871929-1-ruanjinjie@huawei.com>
X-GND-Sasl: alex@ghiti.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_052424_848551_CD20A4F6 
X-CRM114-Status: GOOD (  23.09  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Jinjie,

On 02/08/2024 11:01, Jinjie Ruan wrote:
> On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> will cause system stall as below:
>
> 	 Zone ranges:
> 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> 	   Normal   empty
> 	 Movable zone start for each node
> 	 Early memory node ranges
> 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> 	(stall here)
>
> commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop


I can't find this revision, was this patch merged in 6.11?


> bug") fix this on 32-bit architecture. However, the problem is not
> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> architecture, for example, when system memory is equal to
> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:
>
> 	-> reserve_crashkernel_generic() and high is true
> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
>
> Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
> to simplify crashkernel reservation code"), x86 do not try to reserve crash
> memory at low if it fails to alloc above high 4G. However before refator in
> commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
> crashkernel reservation"), arm64 try to reserve crash memory at low if it
> fails above high 4G. For 64-bit systems, this attempt is less beneficial
> than the opposite, remove it to fix this bug and align with native x86
> implementation.
>
> After this patch, it print:
> 	cannot allocate crashkernel (size:0x1f400000)
>
> Fixes: 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")


Your patch subject indicates "-next" but I see this commit ^ landed in 
6.7, so I think we should merge it now, let me know if I missed something.

Thanks,

Alex


> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   kernel/crash_reserve.c | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5387269114f6..69e4b8b7b969 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -420,15 +420,6 @@ void __init reserve_crashkernel_generic(char *cmdline,
>   				goto retry;
>   		}
>   
> -		/*
> -		 * For crashkernel=size[KMG],high, if the first attempt was
> -		 * for high memory, fall back to low memory.
> -		 */
> -		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
> -			search_end = CRASH_ADDR_LOW_MAX;
> -			search_base = 0;
> -			goto retry;
> -		}
>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>   			crash_size);
>   		return;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
