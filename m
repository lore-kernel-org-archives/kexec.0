Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D698CA5FF0
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJzdUZty6pYJK11/lPzPTzDr7Xt32K0nm4/oMFSsZrQ=; b=G7xUiczd5PwkovVFNUURcz/DRf
	ODEChwPrQWbnCPntd16G7mB0DzxizdnJ/GhqHgFSKfVJUnw9RzRZLRKES3aCbmudkOpeg3HPRij6h
	9ZoRGIjEvx6oUG2guUhwl38Ch8x17my0vKCWyGaV6tAyhUEs4EG9iwZ+YPrNi21Uo7WIocUHDlKAR
	ShzWeFaT46gfUskeT/o6Pt8U81xg7u4n+adzCpFojWM3VD1hEhgKKgAHCVd2NWW68ukOLqh1Mywsv
	H51Qo07JrEBrowNVRVUW3ltXzxxxQK1DziVIJPSlLcEW0IKCOh/OeNzedI94FVex2itIW8/hl9+aH
	yIMtGEMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeL8-0000000Fufu-41Lr;
	Mon, 05 Oct 2026 08:46:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeL8-0000000Fufo-0rtM
	for kexec@lists.infradead.org;
	Mon, 05 Oct 2026 08:46:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98E7C43C8A;
	Mon,  5 Oct 2026 08:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19001F000FF;
	Mon,  5 Oct 2026 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791189989;
	bh=FJzdUZty6pYJK11/lPzPTzDr7Xt32K0nm4/oMFSsZrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TgQoCJ6hE1v9wYf9EeHGJSYgOM6rN1ip3BxsYF+QPAnbEV/+kqnlrDN1i7bIcIu+3
	 anpZ0+NkV/UuBJbzgVn7uSkB0BDBmO31yC5gyQpcYIYh3BUVbwTmCINo+Ycd7jKBr9
	 8R8lW/wqNIBtxl1RMjURlIUokZiS80dk1iPi47lfMLQtqc8Nrtje2WVc7CIJjk9zXq
	 rCFGrtkSnJ3nnsT75wXpMJnNemprt1U+/K72+Iplk+c3dou4NUZ+LxsrLFo7/luo3e
	 0q3hDjek2i+2zeCO3kRaWxJAW2271gobN0OEiilMIBNxwTWr6DTjPt4zk/g9e2hM9u
	 X/QGC0NVR2qeQ==
Date: Mon, 5 Oct 2026 09:46:26 +0100
From: Simon Horman <horms@kernel.org>
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] arm: use the zImage tag's real TEXT_OFFSET for kernel
 placement
Message-ID: <20261005084626.GB184916@horms.kernel.org>
References: <20260831125828.1524463-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831125828.1524463-1-tom@tom-fitzhenry.me.uk>
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

On Mon, Aug 31, 2026 at 12:58:27PM +0000, Tom Fitzhenry wrote:
> The zImage loader assumes TEXT_OFFSET is 0x8000 and sizes the kernel
> reservation as if the decompressed kernel lands at RAM base + 0x8000.
> Multiplatform armv7 kernels, however, are built with a per-platform
> TEXT_OFFSET: arch/arm/Makefile warns that "this offset is critical to
> the functioning of kexec-tools", and e.g. ARCH_MESON uses 0x00208000.
> 
> With such a kernel the decompressor places the inflated kernel ~2 MB
> higher than kexec-tools assumed, so the initrd placed at the estimated
> end of the kernel image lands inside the decompressor's scratch area
> or the new kernel's own reservation. The kexec'd kernel then fails
> with "RAMDISK: Couldn't find valid RAM disk image" or "INITRD: ...
> overlaps in-use memory region", as seen kexec'ing an armv7 NixOS
> kernel on a Netgear RN102 (its multiplatform config selects
> ARCH_MESON).
> 
> The zImage extension tag has recorded TEXT_OFFSET since v5.10 (commit
> 83dfeedb6663, "ARM: add TEXT_OFFSET to decompressor kexec image
> structure"), but the loader only reads size_ptr and bss_size from it.
> Read the real value and place the zImage there. Older kernels do not
> carry it and keep the historical 0x8000 default, just as the arm64
> loader falls back to 0x80000 for older kernels (commit 522df5f7217f,
> "arm64: Add arm64 kexec support").
> 
> Note on tooling: this patch was developed with assistance from
> DeepSeek LLM, which helped diagnose the failure and draft the fix.
> Tested by kexec'ing arm zImages with non-default TEXT_OFFSET under
> QEMU with both a synthetic config and the affected RN102's config,
> asserting the kexec'd initrd runs.
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> Link: https://git.kernel.org/torvalds/c/83dfeedb6663
> Link: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=522df5f7217fda01ece3f6ac3e9987b0320c2bb0

Thanks, applied.
Sorry for the delay.

- arm: use the zImage tag's real TEXT_OFFSET for kernel placement
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=c1a526c87eb1

