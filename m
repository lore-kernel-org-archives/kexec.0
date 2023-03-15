Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C55C61DA4
	for <kexec@archiver.kernel.org>; Wed, 15 Mar 2023 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ghuSOSK6dcd4o74JpFGktCIgVFQhmvM/PYkLrjjqPRc=; b=jOnHFUx8JWIPoR
	aJA1KIa7Ah2r/f0TmEgSb1gadWrI4zPWUwJIjStUEsRGS3frPN90VjRq/RkWkwlOTtqo2K9G1PSuf
	L3uNNSEDgF+0wHgNl7da6ct0zu77XCUvD96NcsMz7MBGf30rT9pmM6K/fHBqrDobNrdhjAU1qpHsv
	JLYqLs5qHyCZrUzGVqEWcDvTjBWMMW7KYyswUkVzu984Wou3kQWWDZjndCyLSWbJZwSK4pxFKTfuh
	M8I7jtLlcUYxt4yT1lNXKdQsxXR8Jr1hFnWEXSQIJy/S2O/wbLjzuKC5Etai55qZu6kMdyW3jiTuk
	Jm6L6rgZok56FaMZw9UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSV3-00Dg26-1y;
	Wed, 15 Mar 2023 14:53:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcSUr-00DftL-1h;
	Wed, 15 Mar 2023 14:52:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 68E9061DC5;
	Wed, 15 Mar 2023 14:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C28C433EF;
	Wed, 15 Mar 2023 14:52:54 +0000 (UTC)
Date: Wed, 15 Mar 2023 14:52:51 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <ZBHbw3Vp4dxukGOD@arm.com>
References: <20230306084124.300584-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230306084124.300584-1-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_075257_617928_616A721E 
X-CRM114-Status: GOOD (  18.77  )
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

On Mon, Mar 06, 2023 at 04:41:24PM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crashkernel high region crossing low and high memory boudary will bring
> issues:
[...]
> Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
> system, or 4G if other normal systems.

I'm mostly ok with the reworking but I'm not sure about the non-fixed
low memory boundary. As I mentioned on v2, the user doesn't (need to)
know about the ZONE_DMA limit on a specific platform, that's supposed to
be fairly transparent. So on RPi4, specifying 'high' still allows
allocation below 4G which some users may treat as 'low'. The
kernel-parameters.txt doc also only talks about the 4G limit.

> +		/*
> +		 * For crashkernel=size[KMG], if the first attempt was for
> +		 * low memory, fall back to high memory, the minimum required
> +		 * low memory will be reserved later.
> +		 */
> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}

So I'm more tempted to set the search_base to 4G here rather than
CRASH_ADDR_LOW_MAX. The crashkernel=x,high option on a RPi4 with all
memory below 4G will fall back to low allocation. But RPi4 is the odd
one out, so I think we can live with this.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
