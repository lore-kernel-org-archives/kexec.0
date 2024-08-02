Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ECCC3DA49
	for <kexec@archiver.kernel.org>; Fri,  2 Aug 2024 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zCXTAW1nMXAR9r1I//1YFL3qG44c6s0jFlvDP3frm8k=; b=zUVjCCVpkz0Tth
	Qr65WOb5VEIOIiCfPfKs6mgA0yrUr7TAtF5S5Y4RG9xu2waACdk5dx0FeUROuHBMC4zA418bfxKyd
	PgfCT3Eo1fsPgxUrkXe8Tb/gLwNb3DT0WEc4CWCUQ6VSc5KHFcVHKqz2KZi+OhO5PR3tCiIgQSS5R
	cTqFe4JgmDX//201oAtz2wCGLxw1yH77J0b/lkKbNSzdX5XMPvgsQnQ6vzzPOV0kA+2GLd0A5E7cL
	hVd7E735973pEu57JtSiJzfKFuZQDxNYJrvLuk/LZb2eYY7cPkM4eTeNxkC6pmiRrjpHFeXImDwz4
	2ASXFZDy7w4N/oJZdj2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZpGB-00000008Pwk-0eKz;
	Fri, 02 Aug 2024 10:11:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZpFr-00000008Psl-1Yjk
	for kexec@lists.infradead.org;
	Fri, 02 Aug 2024 10:11:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722593481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdrYwGhdrYt4Wjbem5gAPO4p6O6XbcLYXDqwBckiuuI=;
	b=OdQGUMJu0b+j2PADCdy6I23Hp5PxD5/s872GDVz5b6cwbPQyyrxAZd3Z4btDN5LYDIeDSz
	NovpCNnWrBP0Aiuv5SVcW2Su5G2n/5gfzZR7aFdiyDdhNb8kw2gjBAnwvqyHIoq+8HMVwX
	Yn/kRT3t2wwHcsB3g3Ms+RFvLss+5pw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-9Yi1FeTJOAmOBbhfGMXroA-1; Fri,
 02 Aug 2024 06:11:17 -0400
X-MC-Unique: 9Yi1FeTJOAmOBbhfGMXroA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B95419560B1;
	Fri,  2 Aug 2024 10:11:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.126])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 398CC1955D44;
	Fri,  2 Aug 2024 10:11:12 +0000 (UTC)
Date: Fri, 2 Aug 2024 18:11:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802090105.3871929-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_031123_509139_87B4BF03 
X-CRM114-Status: GOOD (  24.51  )
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

On 08/02/24 at 05:01pm, Jinjie Ruan wrote:
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
> bug") fix this on 32-bit architecture. However, the problem is not
> completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> architecture, for example, when system memory is equal to
> CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:

Interesting, I didn't expect risc-v defining them like these.

#define CRASH_ADDR_LOW_MAX              dma32_phys_limit
#define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()
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

And I don't like the idea crashkernel=,high failure will fallback to
attempt in low area, so this looks good to me.

> 
> After this patch, it print:
> 	cannot allocate crashkernel (size:0x1f400000)
> 
> Fixes: 39365395046f ("riscv: kdump: use generic interface to simplify crashkernel reservation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/crash_reserve.c | 9 ---------
>  1 file changed, 9 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5387269114f6..69e4b8b7b969 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -420,15 +420,6 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  				goto retry;
>  		}
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
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
