Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24430CA6007
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1TofRB7x1qaNWTsiyxmXKQQRnhq0vGxdzx2nkOgB4Q=; b=vdVZlizXTIKNjVeea7HnAPxOhn
	c5FQN9qQfnmurdxiAaC88r9aBiITaztixUlQRU8/XIDE5/AolZRNoZNvx6wb+HxsRBUifgA2FK0Zh
	yaeKFfhRZBP+SwA7vgQPqg7SA88On+RN+smCMVBDVmlSRi8JfhATs3dbvGaHSVB6Ft5o1+no9BZR5
	nJMcBYyHY2pUs/mu2r/G0jiVObF/rh4B2kl//WlhhU6s3uA42KvaB7rq/552OGQeaopcLIYoHK510
	AvtzxsCtra+Ti8odNjbr69JCbLw+gC8wxRLKTKhwcO23aJTQRe+CUcXwOUr4yRQrHDz7UMdeT1KmJ
	KO+kX/YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEj2f-00000003oXz-3UTy;
	Thu, 08 Oct 2026 07:59:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEj2d-00000003oXr-44dB
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 07:59:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 207856025A;
	Thu,  8 Oct 2026 07:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A531F000FF;
	Thu,  8 Oct 2026 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791446390;
	bh=J1TofRB7x1qaNWTsiyxmXKQQRnhq0vGxdzx2nkOgB4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g1ieSFMzBrY7PWf0HK4HAy2hAAPiuXAUq9CvkQravrF6SlpsKYNTIkZFK4NZaz/Tk
	 WaBvmR7/w0o1SppUOokiSfdlhBbFXSMWDl8PtHknAP/BqpheMsPDzLWa5db1BmtYaB
	 nLmQopIl7oRWNsON8OZcFNB+j458oozkuCIlwk1zZBPjo5ikUpxcN0T8J4L0S9E5yZ
	 drv54UJOsqbacEKzaKLfUm418M4hkIfM2HdeEyP/G0kAaZ4QNj+lG8KWIg9DoHyBob
	 RMDlAKhURKuy+6vJhbpE1ZNShwV6KoH78DwrO5EhQOcS4X7k4tQyNOp6V3R55Q08m3
	 npxuh54+Dyf0g==
Date: Thu, 8 Oct 2026 09:59:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org, jgg@nvidia.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
	robin.murphy@arm.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com, pasha.tatashin@soleen.com,
	pratyush@kernel.org, skhawaja@google.com, praan@google.com,
	baolu.lu@linux.intel.com, dwmw2@infradead.org, kevin.tian@intel.com,
	dmatlack@google.com, vipinsh@google.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] liveupdate: parse the incoming handover tree
 before late_time_init()
Message-ID: <asdNbLNz7zPaQYXX@kernel.org>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
 <20261005064018.1558-3-Ankit.Soni@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005064018.1558-3-Ankit.Soni@amd.com>
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

Hi,

On Mon, Oct 05, 2026 at 06:40:12AM +0000, Ankit Soni wrote:
> LUO parses the handover tree from an early_initcall, which runs inside
> rest_init() -- the last statement of start_kernel(). Anything earlier in
> start_kernel() cannot see the incoming state, and cannot tell that it
> cannot see it: luo_flb_retrieve_one() returns -ENODATA both before the
> parse and when the previous kernel handed nothing over.
> 
> On x86 the IOMMU is such a consumer, because it is also the interrupt
> remapping provider. amd_iommu_prepare() runs from late_time_init() via
> enable_IR_x2apic() -> irq_remapping_prepare(), and reaches
> init_iommu_one_late() long before any initcall.
> 
> Fix the ordering rather than teaching each consumer to cope. Call the
> parse directly from start_kernel(), immediately before late_time_init().

Why do you suggest to call it exactly here?
Order of the calls in start_kernel() is quite sensitive and placing a call
in a certain place needs more elaborate explanation.

> Rename it to liveupdate_init_early() at the same time, since
> liveupdate_early_init() was named after the early_initcall that no longer
> exists.

No strong feeling about this, but we do have other _early_init() functions
unrelated to initcalls.
 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  include/linux/liveupdate.h   | 4 ++++
>  init/main.c                  | 2 ++
>  kernel/liveupdate/luo_core.c | 5 +----
>  3 files changed, 7 insertions(+), 4 deletions(-)

-- 
Sincerely yours,
Mike.

