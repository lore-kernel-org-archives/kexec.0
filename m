Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10DF606A31A
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W0dLfOhh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUEsZ5IW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yaahl2NjM7LYJ3/VUSQG13ODgqUJA5kkV/j2CsiAkwA=; b=W0dLfOhhwjo/XKrrAg3Ttp95mq
	tM6AzklEYmUTG/iZhMGiWSQVIWulAqKMGjpTjH8SgNtNe3TMSTB2f9hMz4++eUuq45Xw1NPbJJFMW
	COTfppFm+zKRVeaQ5mIuxdQR7oaNoioTqLO5qDM/72OTgwGeFuJW7x4NsomKRp9JrrY5MV2AmRfYR
	9NE6QNTuCm+tWpKupuEZTEIuSxNZtdbviICkyqUgFMy+NUWL4f28nftqVgJXnXELQz3hBWBYswqOp
	B8UIQdf05d1tgt7vphjThtyhTq4450lnN0yfaZB+/rV0+ZxoM9WEmkJVPq0//UJLwd/8khvRXDe36
	3AOghKOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJQj9-0000000BFfF-0w0x;
	Wed, 21 Oct 2026 07:27:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJQj7-0000000BFep-30aO;
	Wed, 21 Oct 2026 07:27:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DFC9640334;
	Wed, 21 Oct 2026 07:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F48F1F000CA;
	Wed, 21 Oct 2026 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792567628;
	bh=Yaahl2NjM7LYJ3/VUSQG13ODgqUJA5kkV/j2CsiAkwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bUEsZ5IW9a3Szer7bK9RTRwykZPLZWByrbcqBn+bd0n7lP4ZRRuV5OQXQGjOwoy8E
	 BIYtLTNMkx8NTeMmbPOBJnWZRjkwca+gcJ1h0haQ7prOXdpniffU9ztJAo/CPtxhcl
	 iAVVU1n60X+gDOtLmaGmW3wQAAiu05os2br3vplaE3SNIZ922wcZXuJMf6DQ8CAFou
	 4JhAjGFaXE3LG+yhA2TCRhXT5gy9PB4rmZ4KRLa9JQTUL87C5Ox7r7ojsB9kcdE568
	 EYPrtBF/A2MmJ6LvO0xUa19vYnNWp1tseqSuVUhflIGb996+bdy1xHcA3NUPK49+zR
	 CV67lqrjbae+Q==
Date: Wed, 21 Oct 2026 00:27:07 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: mhklinux@outlook.com, wei.liu@kernel.org, catalin.marinas@arm.com,
	baoquan.he@linux.dev, will@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, arnd@arndb.de, hpa@zytor.com, maz@kernel.org,
	mark.rutland@arm.com, linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	broonie@kernel.org, kees@kernel.org, brads@mainlining.org,
	namjain@linux.microsoft.com
Subject: Re: [PATCH v4 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
Message-ID: <20261021072707.GH851443@liuwe-devbox-debian-v2.local>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 09, 2026 at 03:22:11AM -0700, Shradha Gupta wrote:
> Kexec reboot fails on ARM64 Hyper-V guests because the VMBus connection
> and SynIC CPU hotplug state are not torn down before the secondary CPUs
> are stopped. Move this cleanup into the VMBus syscore shutdown callback,
> which runs after device shutdown and before architecture-specific machine
> shutdown.
> 
> Patch 1 adds an exported helper for checking whether a normal kexec reboot
> is in progress. Patch 2 runs the VMBus cleanup from the common syscore
> shutdown path on x86 and ARM64, removes the old x86 handler interface, and
> documents the shutdown ordering.
> 
> On x86, VMBus teardown now precedes hv_stimer_global_cleanup(). This relies
> on commit be0cfab740e5 ("clocksource: hyper-v: Remove support for stimer
> interrupts in message mode"). Older kernels that retain message-mode
> stimer interrupts need an ARM64-specific backport to preserve the existing
> x86 ordering.
> 
> Changes in v4:
>   - Document the VMBus kexec cleanup path in the Hyper-V overview.
>   - Combine adjacent kexec_in_progress checks in the x86 shutdown path.
> 
> Changes in v3:
>   - Use the existing common VMBus syscore operations on all
>     architectures, as suggested by Michael.
>   - Remove the x86 handler pointer and the weak setup/remove interface.
>   - Add an exported read-only helper for modular VMBus builds.
>   - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
> 
> Changes in v2:
>   - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
>     suggested by Catalin.
> 
> Shradha Gupta (2):
>   kexec: Add helper to report an active kexec reboot
>   Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
> 
>  Documentation/virt/hyperv/overview.rst | 12 +++++++-----
>  arch/x86/kernel/cpu/mshyperv.c         | 27 ++++++---------------------
>  drivers/hv/hv_common.c                 | 10 ----------
>  drivers/hv/vmbus_drv.c                 | 22 ++++++++++++++--------
>  include/asm-generic/mshyperv.h         |  2 --
>  include/linux/kexec.h                  |  2 ++
>  kernel/kexec_core.c                    |  7 +++++++
>  7 files changed, 36 insertions(+), 46 deletions(-)

Applied. Thanks.

Wei

