Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52805C369C2
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H9iXRvvlMp61keyB43OuJP77K0mIuP0I0t1mbGGxgIM=; b=XxRZm0UOvWv8xVLC/3mqYabuUT
	LD5SxfO2UAktgSLjhk/9TNdKd5qOskfhEn2GDII/roGqr9vDCuTNvfV8oXRn6a59ZWurAnpkXDdnm
	aMipe2octKivn2GkYGTXoRERG9AxTxDraMQZFrJynJ6x7wyaAg7gYen22QK58xDTBz3oqh4Y9HH8S
	xY6ItG8o23v/FrimMXP1nlo6qn7CsGlh0eyy3/cop8mNKQrSzbNdEmaIp2BFrKJoQAWVF23H5zAOC
	Ko87U1tQqoRi38VRMw6Mi7emgkq20zCao6J0lsUQFJjo3kDqCZRmlDjURqGSA45ndwZga4qwJF44k
	j3W+7vFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7BRW-00000006se6-483h;
	Tue, 22 Apr 2025 11:05:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Amn-00000006jrm-1s6Y
	for kexec@lists.infradead.org;
	Tue, 22 Apr 2025 10:23:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D88735C5AC9;
	Tue, 22 Apr 2025 10:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A9C4CEE9;
	Tue, 22 Apr 2025 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745317408;
	bh=GZxrYBqQBXppm3LaGAF4B92nKPIRJYF2oXWlcivlKC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ag4snIpJc0wi0Vkbeqrb9C7HG7rcmyD7Rs8taAmOeswZEPSGBBiyKdQ21tTSx0l1M
	 eH9uB4VcNGU7GHooIL5lb0cJ8QB8eaWdKggPaijDQkhURZrgPdMNIBmESee3O2z9zN
	 LRi+41s+VOZjMEHGDJvPHOhX1+OZSPwg3Ydjo7b9FHriVxvjRpRwg4ojsGMpDBMbRa
	 4kq/lWGFpa8kw8W4/tamw3N2aLl+ylJotzNaKPw56oGiV6sor+11KGqKdB1vk4Pyoq
	 EKiQ6mmnjNSB6Bng6CvOEVcC6tFdGfUrPzbsr1qwVBVggAcGCT1R5axLKqreRmJL4/
	 SsrqwuhSRCovA==
Date: Tue, 22 Apr 2025 11:23:25 +0100
From: Simon Horman <horms@kernel.org>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] x86_64: Use the x86-64 level for purgatory
Message-ID: <20250422102325.GS2789685@horms.kernel.org>
References: <20250417083140.697272-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417083140.697272-1-ross.lagerwall@citrix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_032329_541794_FD175F10 
X-CRM114-Status: GOOD (  11.87  )
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

On Thu, Apr 17, 2025 at 09:31:40AM +0100, Ross Lagerwall wrote:
> The compiler may be configured by default to use a newer
> microarchitecture level such as x86-64-v3. Set purgatory to compile
> using the baseline x86-64 level since the environment isn't set up
> correctly to use SSE and AVX instructions.  At the same time, be a bit
> paranoid and add some additional flags to ensure that the compiler
> doesn't use any such instructions.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Thanks Ross, applied for inclusion in v2.0.32.

