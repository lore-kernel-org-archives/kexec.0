Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1374DC05027
	for <kexec@archiver.kernel.org>; Fri, 20 Jan 2023 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NAukZBNHuOHYmarijEVTX8R2vGvgLyM1xHsEg+WnqKc=; b=SSBTa6rj3pOBbo
	um3N8gY0kvEYSKGb/qCiHaE8pRqELOAc3Bb8PG4LT8hYCqFAnzJClopX4ugcnZo9TS6ZrB4Hm4laV
	ootDcORUpC9y8+Dil7avM+DxdKNVsoL8sZ135xkX6ylnYSH80BABw5M3LbWQlBD2BjqhqRizx1t3h
	xnyHCBS9oOxRgiuS1LHbjV4Y0EtmbcigIyegzwmQ03eycma2qlE1KxJDXJ9Rm5u8goH8TwlL/uzKA
	ysdMT9VWhbPs0MpD05Wu6r2ozC5CVMWlZiBmV6YqW73NaC6/k4vunEjQxqzTsbNwKM1YurxXEfaMe
	e2E/R/u/JNCSiRtgvhgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pInKz-009CSH-2v; Fri, 20 Jan 2023 09:05:29 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pInKw-009CR4-FH; Fri, 20 Jan 2023 09:05:28 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id AFDB420099;
	Fri, 20 Jan 2023 09:04:50 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 4606D94030F; Fri, 20 Jan 2023 10:04:49 +0100 (CET)
Date: Fri, 20 Jan 2023 10:04:49 +0100
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y8pZMQoJOdgz+Xba@vergenet.net>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230117034921.185150-2-bhe@redhat.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_010526_707702_632A6893 
X-CRM114-Status: GOOD (  30.70  )
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

On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region up down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> This looks very strange because we have two low memory regions
> [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> why that happened.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region above the high and low memory boundary. If failed, try reserving
> the suitable region below the boundary. Like this, the crashkernel high
> region will only exist in high memory, and crashkernel low region only
> exists in low memory. The reservation behaviour for crashkernel=,high is
> clearer and simpler.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/mm/init.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..26a05af2bfa8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_low_size = 0;
> +	unsigned long long crash_base, crash_size, search_base;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_low_size = 0;
>  	char *cmdline = boot_command_line;
> -	int ret;
>  	bool fixed_base = false;
> +	bool high = false;
> +	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_ADDR_LOW_MAX;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
> +		high = true;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
>  		return;
> @@ -166,31 +169,44 @@ static void __init reserve_crashkernel(void)
>  	/* User specifies base address explicitly. */
>  	if (crash_base) {
>  		fixed_base = true;
> +		search_base = crash_base;
>  		crash_max = crash_base + crash_size;
>  	}
>  
>  retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> +					       search_base, crash_max);
>  	if (!crash_base) {
> +		if (fixed_base) {
> +			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
> +				search_base, crash_max);
> +			return;
> +		}
> +
>  		/*
>  		 * If the first attempt was for low memory, fall back to
>  		 * high memory, the minimum required low memory will be
>  		 * reserved later.
>  		 */
> -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}
>  
> +		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {

nit: unnecessary (and inconsistent with code just above) parentheses.

> +			crash_max = CRASH_ADDR_LOW_MAX;
> +			search_base = 0;
> +			goto retry;
> +		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> +	     reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
