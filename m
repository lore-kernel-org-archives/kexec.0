Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD7FCD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmAXHxNUwUqsynWpUSTF048mwQXqT/HeYN0OxRXzNeU=; b=o+V65hzC1bG9dEwZIEeOJ07ILy
	9BPb68+9kwF4uBleco7Sjj8nymqq8+3RWuzJg9JWtctdg2E7DQdX8osX1+n/50q6FjVDEIgDOfwwT
	M9FD8bXnOvCVVOsa2dd+hORBBNiGH7rZ6koi+K8k0/SJmvtoDvSVb8bgbykwA64WoO0jkKXQPXkOc
	N83XL33zyCP1TcF9iBXcwYjaMs1GONhIxy6yZijYkaCfya+obwi/DVaVngCoanRDZQ/HU+7LmslP7
	7ZPKoouno/BELvYsb20JAI2TgFYyaMoRPabuyZ6yfQSUxuUqwmHSHz0f0tLlwl1L68wnClnD4ck5z
	j6SjpvAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY34X-0000000B5l1-0Tpd;
	Fri, 12 Jun 2026 14:41:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY34W-0000000B5kn-2gzD;
	Fri, 12 Jun 2026 14:41:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A4AC66008A;
	Fri, 12 Jun 2026 14:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1B61F00A3A;
	Fri, 12 Jun 2026 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275283;
	bh=hmAXHxNUwUqsynWpUSTF048mwQXqT/HeYN0OxRXzNeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fpZHwZpFSlFKHdhrHL86Fm31xIkwf0H4w8rmAoLhBCpFarhQbgz1y1KdDDny+d2sW
	 susCcVgWIy78O5jtOqfUedAA7WR1FePmSBXfBRk+R1QpKN865CL2/9Pu1gxXaTRBD1
	 zVRchja2vC9CymI6zJsjihLL+LMuUvIVbPrgKZSeG3uuI/D1jJUHlOVfSsVmfMT5ua
	 nvq7iwjkRhZlpWc+G09dcxbLATjEYGRqCZsCf/wSws1+zdTthAh4aZ/aM3NkufQA/8
	 U+EsuVdjp/ODco/aPFY0X3QPqSkhWFg1aUTUQNjzMarRSr1pV2t7Syd1vl9wvU8qB4
	 FaocY33c9ejVg==
Date: Fri, 12 Jun 2026 09:41:22 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 05/11] of: reserved_mem: split
 alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
Message-ID: <20260612144122.GA974326-robh@kernel.org>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-6-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-6-chenwandun1@gmail.com>
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

On Wed, May 27, 2026 at 11:29:11AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Prepare for storing /memreserve/ entries in the reserved_mem array.
> alloc_reserved_mem_array is skipped if the device tree lacks a
> /reserved-memory node, pointer 'reserved_mem' continues to reference
> the reserved_mem_array which lives in __initdata, storing
> /memreserve/ entries into reserved_mem_array would result in metadata
> loss, and an out-of-bounds memory access will occur if the device
> tree contains more than MAX_RESERVED_REGIONS /memreserve/ entries.
> 
> So split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late(),
> and call alloc_reserved_mem_array() whether or not there is a
> /reserved-memory node.
> 
> No functional change.
> The actual /memreserve/ population is added in a follow-up patch.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> ---
>  drivers/of/fdt.c             | 7 +++++--
>  drivers/of/of_private.h      | 1 +
>  drivers/of/of_reserved_mem.c | 6 +-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 82f7327c59ea..83a2a474831e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1284,8 +1284,11 @@ void __init unflatten_device_tree(void)
>  {
>  	void *fdt = initial_boot_params;
>  
> -	/* Save the statically-placed regions in the reserved_mem array */
> -	fdt_scan_reserved_mem_late();
> +	/* Attempt dynamic allocation of a new reserved_mem array */
> +	if (fdt && alloc_reserved_mem_array()) {
> +		/* Save the statically-placed regions in the reserved_mem array */
> +		fdt_scan_reserved_mem_late();

Can we make this just:

alloc_reserved_mem_array();
fdt_scan_reserved_mem_late();

We already check !fdt in fdt_scan_reserved_mem_late().

Rob

