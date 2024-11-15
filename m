Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C06D6DDEC
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UQVkmvFUb7omt6BspZ1f4lT2Qkjrgza0x8w6T4qgeNs=; b=aTVWNmJp9BgrE4ep1erswYBWkJ
	9IlWTIR60VOJ2x8wwXSNoSyzvpiYEIzzYF8AmLYFuW3o+9CiatdS6HCmw96/SumyIbqo5hdAN0E60
	NH/dxt5vmvuie+kK9slqneiialtrj33FSkbBKApf9BNNI28y5qLBUaHwIDg0KhxheL9m38GCXLPPm
	RwdoNkGBVWxiNsqGvWo580UdlRC05+GGdR9Dk2pdg7Oatlv1UJpQsi3hu/roEGx2piEmrUiYzjoeA
	l9+psd4ne9Sb18dBDvkkk9QkPEKqBGRrX2vmkRx6v5lPN3g7GW0hiiJwPO9M1Q0DZUie+ESQ96ziX
	fQQCB0Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBst8-00000002Ega-2YBF;
	Fri, 15 Nov 2024 09:45:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBst6-00000002Ef4-0ccW
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 09:45:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 203035C6261;
	Fri, 15 Nov 2024 09:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FBDC4CECF;
	Fri, 15 Nov 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731663911;
	bh=fGGdFnBPXWrfufp78HOuQV0Y/XfBoTWQMxhvdckWiC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3RC8YaEyrc9FrcTR96n2iVq393c63ZGB//mC3IbVTP4CJtgPV458pXfq5IlhOtci
	 GDBmSiUhIja64DqCJ9zNsrbuOfza3ZWlCdhtg1mYEkgwUNTX6HgPdFH3AUae4A//Nk
	 8rNcPce4YUd+x2x2x7uwlPeT6Mvu7gnvWfjGoOCEecmt9j3Cf6w+9sq83mJgbLJ4IB
	 5lJtvtg8Sut+k3BmznnMhSVx4icbbL1tbbYnzkxExH9wluhwKGN+62dNezyz0ynj6Q
	 MxDTAZi6SNUQWbigBav+6j/BjYXmuYC16r7aTXbm1ZZb7HLtZ8vEO2wPHFoDLjix83
	 OODyz+QZloKKg==
Date: Fri, 15 Nov 2024 09:45:08 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v1 1/1] kexec: x86: Include pref_address when looking for
 a memory hole
Message-ID: <20241115094508.GG1062410@kernel.org>
References: <20241113154437.2860694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113154437.2860694-1-andriy.shevchenko@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_014512_270232_765FCFF4 
X-CRM114-Status: GOOD (  20.06  )
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

On Wed, Nov 13, 2024 at 05:44:37PM +0200, Andy Shevchenko wrote:
> When the kernel is built relocatable, the starting address can be
> anything above 1Mb on x86. However, the startup_*() entries consider
> that the minumum address for the kernel for the decompression has to
> be at least LOAD_PHYSICAL_ADDR which is turn the value that is provided
> as pref_address in boot protocol. The boot protocol itself says:
> 
>   This field, if nonzero, represents a preferred load address for the
>   kernel.  A relocating bootloader should attempt to load at this
>   address if possible.
> 
> Besides that the code in the kernel (arch/x86/kernel/kexec-bzimage64.c)
> has these lines (in bzImage64_load() function):
> 
>     if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
>         kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
>     else
>         kbuf.buf_min = header->pref_address;
> 
> All that said, do the same in kexec tools. Without this patch
> the relocatable kernel may end up in the memory hole that is
> not enough for in-place decompression and Bad Things will happen
> as it's proven on Intel Merrifield, that has a reserved memory
> block starting at 64Mb.
> 
> Note, it doesn't mean that kernel has no issues itself in this particular
> stage, but at least we may work around some corner cases for kexec.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy, applied.

