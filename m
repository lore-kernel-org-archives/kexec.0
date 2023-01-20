Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF23C05027
	for <kexec@archiver.kernel.org>; Fri, 20 Jan 2023 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TAi4x0aJQkVJnH/EwJGBafE7MNHBdTOjppKOD0BOkZg=; b=xpEJPWPgm8SFFo
	5aSvb17CGcZuSXrP598pne8/7wMIp0+YIUV42VM/IPcdhUJcR3+Gzpn6+8qskRa+IrwfgKVkwmrCj
	c6K47/NEe37Nne+OlabQ+Lt1PrUHLdWn+8XybK0qO2blytcXOCQqhAchNuDKiFXayRlGZuGNbcpNU
	NR5fiFYlHmmHXVW9fr7mnQkzJJojxy2SIfd1LG93W/XBGAGu0YJ4gIxYR9G/H6+UDrlRZx7lbNdZR
	yK4c6M/cJ1ek3i4Wk/jUAK9QuUSIrIeTzLeaTFpQgzIpikAQQj6HSeXZ6LrdjdlJ20WlDRLfCAK+J
	Mc3a40YtUOWGwBzHx10g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pInJF-009BgE-8C; Fri, 20 Jan 2023 09:03:41 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pInJ8-009Bc9-FS; Fri, 20 Jan 2023 09:03:36 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id EBCFE20095;
	Fri, 20 Jan 2023 09:02:53 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 0E8C794030F; Fri, 20 Jan 2023 10:02:53 +0100 (CET)
Date: Fri, 20 Jan 2023 10:02:52 +0100
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH 2/2] arm64/kdump: add code comments for crashkernel
 reservation cases
Message-ID: <Y8pYvBvDonUya1mx@vergenet.net>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230117034921.185150-3-bhe@redhat.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_010334_706806_6C8E9397 
X-CRM114-Status: GOOD (  24.79  )
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

On Tue, Jan 17, 2023 at 11:49:21AM +0800, Baoquan He wrote:
> This will help understand codes on crashkernel reservations on arm64.

FWIIW, I think you can fold this into the first patch.

And, although I have no good idea at this moment, I do wonder
if the logic can be simplified - I for one really needed the
comments to understand the retry logic.

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/mm/init.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 26a05af2bfa8..f88ad17cb20d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -177,6 +177,10 @@ static void __init reserve_crashkernel(void)
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       search_base, crash_max);
>  	if (!crash_base) {
> +		/*
> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> +		 * message if can't reserve the specified region.
> +		 */
>  		if (fixed_base) {
>  			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
>  				search_base, crash_max);
> @@ -188,6 +192,11 @@ static void __init reserve_crashkernel(void)
>  		 * high memory, the minimum required low memory will be
>  		 * reserved later.
>  		 */
> +		/*
> +		 * For crashkernel=size[KMG], if the first attempt was for
> +		 * low memory, fall back to high memory, the minimum required
> +		 * low memory will be reserved later.
> +		 */

I think this duplicates the preceding comment.
Perhaps just replace the earlier comment with this one.

>  		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
>  			search_base = CRASH_ADDR_LOW_MAX;
> @@ -195,6 +204,10 @@ static void __init reserve_crashkernel(void)
>  			goto retry;
>  		}
>  
> +		/*
> +		 * For crashkernel=size[KMG],high, if the first attempt was for
> +		 * high memory, fall back to low memory.
> +		 */
>  		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
>  			crash_max = CRASH_ADDR_LOW_MAX;
>  			search_base = 0;
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
