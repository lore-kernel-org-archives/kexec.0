Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79580C43217
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sfUdcdNRVUQMFF7gWGRTbSh5En/OvK+USnTTQdI3Kwc=; b=CK+DmqlGRPy3u9
	U/1MesHm9eDg/t+sDcSA9T5uBG4yZQONE1E36mYQ83779vgjFLCDMEqtus35IhcUb3U3xi4W50Z5d
	AbJEsBIf4XRCZT8UCcsNAAIZTRvHhYL09Fw0VMFUKSVVNaaEogPAc9cbl0KAVpX13TIfr/WdDLPyp
	geBvrarNTkP/dXbnsbOxF+3CTL1FP7uaEfuZ4dWpqHhRxOaQqKKdTd/DIzcP/o+TjcK+s05dEavfP
	FWPLBJs7qDML0EDuEc6nsB+6Dxnp3x2yYfD0lMJuEwKRTLvV27DW9jjWtaRGLsy8dXHgPMSgyaK7C
	rQw9BLBWRqPoOzxY7zWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5h7-00GZ9x-1L; Mon, 07 Nov 2022 17:13:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os5h4-00GZ8R-Bl; Mon, 07 Nov 2022 17:13:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A07FE611CD;
	Mon,  7 Nov 2022 17:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E92C433C1;
	Mon,  7 Nov 2022 17:13:50 +0000 (UTC)
Date: Mon, 7 Nov 2022 17:13:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v3 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
Message-ID: <Y2k8yuUghrbQE6da@arm.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220711090319.1604-3-thunder.leizhen@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_091354_468344_04F9E75A 
X-CRM114-Status: GOOD (  18.98  )
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

On Mon, Jul 11, 2022 at 05:03:19PM +0800, Zhen Lei wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 5390f361208ccf7..8539598f9e58b4d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -138,6 +138,7 @@ static void __init reserve_crashkernel(void)
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	char *cmdline = boot_command_line;
>  	int ret;
> +	bool fixed_base;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -166,15 +167,28 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> +	fixed_base = !!crash_base;
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	/* User specifies base address explicitly. */
> -	if (crash_base)
> +	if (fixed_base)
>  		crash_max = crash_base + crash_size;

Not a fan of '!!', it is converted automatically. If you don't like the
conversion, just initialise fixed_base to false and here:

	if (crash_base) {
		fixed_base = true;
		crash_max = crash_base + crash_size;
	}

> +retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);
>  	if (!crash_base) {
> +		/*
> +		 * Attempt to fully allocate low memory failed, fall back
> +		 * to high memory, the minimum required low memory will be
> +		 * reserved later.
> +		 */

I'm not sure this comment makes sense. If !crash_base, it doesn't mean
the kernel failed to fully allocate low memory. crash_max here could be
CRASH_ADDR_HIGH_MAX if crashkerne=X,high was specified. Maybe says
something like "If the first attempt was for low memory, fall back to
high ..."

> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +			crash_max = CRASH_ADDR_HIGH_MAX;
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +			goto retry;
> +		}

The retry logic looks fine, it only happens once as crash_max is
updated.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
