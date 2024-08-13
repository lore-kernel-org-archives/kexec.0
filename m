Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F24BC52D7C
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 03:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o/+qZ8cZVxiTa/4LpCi2tzmpVrFSKkHFtLxm6IT4mzA=; b=hpsMIpUYxX9gpD
	ZlhkBRcPWPhp1JPzOx2oZrQNZfFQcKDqFmya7wV0TYr3NN5kYOqqS6CEsEvaS9wYKLApliqbVzyb9
	qdy3VVc0S8TxBgi6+HIANFTuwQ3fE7EZIbqUBcER0WQj4EQDz7F7pCMiVId5/RbfDjtZaNiJjVElL
	yNT3xjrqkb/RmxEu6+FEeNrnDweP6wJd4fXqO/vBltwtway8FVVcOcJDa2CzhCyMP+Zp3bB6s5o5P
	n+wGMiCl4pLF+ZNLqmlOV6/GcsVQ7b3O4SD7Kkhd/b7RJLCiOgK1hEVLoeyu7WHmlIDQnQqD0Up3Z
	JWSjlyWSkp+cmCdjCCEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdiGU-00000002D2W-24ps;
	Tue, 13 Aug 2024 03:32:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdiGS-00000002D1j-1UP2
	for kexec@lists.infradead.org;
	Tue, 13 Aug 2024 03:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723519923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ImjO3P8y5HQjjz6vvHUXt04IUaXtaxVKMc6ROVHnaII=;
	b=he+PoMHI2sgiEx79kBARPV/TtoTIPPoJ64MLSjIpEOexMktPxRvFUqhZR5UMbFCXG+RN9E
	qm2g4/yvx7XoaOfTiTHEsUSzHyofKJOAF4UpE4jaaUEZ0t0WNuB8xFF2bh+22pJd8Cd4Zm
	PabKKrxjZGCDfBwKdv8IAZYZIM6F6gM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-9qR12zzKML6SmeAHm7fOZg-1; Mon,
 12 Aug 2024 23:32:00 -0400
X-MC-Unique: 9qR12zzKML6SmeAHm7fOZg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3657195420C;
	Tue, 13 Aug 2024 03:31:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49669196BE80;
	Tue, 13 Aug 2024 03:31:54 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH -next v2] crash: Fix riscv64 crash memory reserve dead
 loop
Message-ID: <ZrrTpgvC/buAY/OV@MiWiFi-R3L-srv>
References: <20240812062017.2674441-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240812062017.2674441-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_203204_487946_82DBEAD5 
X-CRM114-Status: GOOD (  22.25  )
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

On 08/12/24 at 02:20pm, Jinjie Ruan wrote:
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
> 
> 	-> reserve_crashkernel_generic() and high is true
> 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly
> 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> 
> As Catalin suggested, do not remove the ",high" reservation fallback to
> ",low" logic which will change arm64's kdump behavior, but fix it by
> skipping the above situation similar to commit d2f32f23190b ("crash: fix
> x86_32 crash memory reserve dead loop").
> 
> After this patch, it print:
> 	cannot allocate crashkernel (size:0x1f400000)
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> v2:
> - Fix it in another way suggested by Catalin.
> - Add Suggested-by.
> ---
>  kernel/crash_reserve.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 5387269114f6..aae4a9e998d1 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -427,7 +427,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
>  			search_end = CRASH_ADDR_LOW_MAX;
>  			search_base = 0;
> -			goto retry;
> +			if (search_end != CRASH_ADDR_HIGH_MAX)
> +				goto retry;
>  		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
> -- 
> 2.34.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
