Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7141CF34D6
	for <kexec@archiver.kernel.org>; Fri,  4 Oct 2024 00:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sqM30hbYhrK31G6k7Lm6HyBaYhpx2DVfwBU6QaKqmTk=; b=umiBzPY1mJdHHr
	l0LHjN6G6VLgvFvUWXB3q7qHcnzz1j/Sqw0iDLDBckp3sSbh8kC8C9GsVul9V2LQ2xdYx0Y02+6sw
	CIxdYX1EIKKm9uP7vcStzSRYWy7pO1uPqi147qokvKy7bADkJ2bwYFnsmK11r1oFdj0Sgv9Lxl6IT
	bW1b7CdgQxXt90pz2t0KdAQ3TP8Xu9Vo6ath2p6bFJpKThwUCGGeRGw18U6nxSk/f7JHZpHaC5/55
	kJU89pd0GMQ6GwS5m3b4IvggQ01RgvK0CKn8R4m1d6itkUcJcM2RFn9dR7lew2J+STS76x5Y1Sojq
	bFYawLKw+wuSDv7tZP1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swVrX-0000000AiA6-1gVa;
	Fri, 04 Oct 2024 00:08:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swVmw-0000000AhJh-0F6l;
	Fri, 04 Oct 2024 00:03:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2949E5C5C61;
	Fri,  4 Oct 2024 00:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D672AC4CEC5;
	Fri,  4 Oct 2024 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000197;
	bh=SNrvlogFlg3d5o+tg0qQnk7NnFWIl9VQl1VbaDJnDgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMdzorrDPhHDsZkbSRBXh7eDHyOllgtmi71lMaV764yDzF/xTrgCLutg+cydsTuE3
	 N8lG88FyjnhppugZnTjoBtFXkoRShhpQVXnDAeNZJMhVSUrExke7LXNNhhW9jVv3FW
	 tnkJbYrQDj/Kqj0xY3gWcet9cN60KtQq0IYix2MTuYFBy8IKxWbQHQ/kySTqzg6NDc
	 rTzEwawwqizTQt9DKpLrYMQ6LRoLEVP76dJe/wxP5CZrky1uBHg/+0aBsFKZIXDSaw
	 wyiNKmogMLoXeJ4XBhsIrfMHa84CGYeoPjoBn/0aP+g+f/7sQtMJPrkM/jHVKvfGLA
	 aLFDoDy1ZK53w==
Date: Thu, 3 Oct 2024 19:03:16 -0500
From: Rob Herring <robh@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
	catalin.marinas@arm.com, saravanak@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
Message-ID: <20241004000316.GA1910499-robh@kernel.org>
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241003113840.2972416-1-usamaarif642@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_170318_187865_52B8E5A7 
X-CRM114-Status: GOOD (  18.50  )
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

On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>  __pa() is only intended to be used for linear map addresses and using
> it for initial_boot_params which is in fixmap for arm64 will give an
> incorrect value. Hence stash the physical address when it is known at
> boot time and use it at kexec time instead of converting the virtual
> address using __pa().
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> ---
>  arch/arm64/kernel/setup.c | 8 ++++++++
>  drivers/of/fdt.c          | 6 ++++++
>  drivers/of/kexec.c        | 8 ++++++--
>  include/linux/of_fdt.h    | 2 ++
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index b22d28ec8028..a4d96f5e2e05 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>  	/* Early fixups are done, map the FDT as read-only now */
>  	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>  
> +	/*
> +	 * Save dt_phys address so that it can be used later for kexec. This
> +	 * is done as __pa() is only intended to be used for linear map addresses
> +	 * and using it for initial_boot_params which is in fixmap will give an
> +	 * incorrect value.
> +	 */
> +	set_initial_boot_params_pa(dt_phys);

No new arch->dt functions please. If we need to save off the PA, then do 
that when we set initial_boot_params.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
