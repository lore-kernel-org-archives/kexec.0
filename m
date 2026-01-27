Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA766D2595A
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMs202ls6I1mHL4u4/keg5ULSM/qkR7dvbuMz1TL4NU=; b=jUvuZyWEI5iArzk7DHErgySIVG
	4xkQmLNO5uf4YUQ7s5kZXQaVQCA8JkAXfj+yoT9nYwF0aECiw1N0LdP45EF4ImlSRLQ/1fBVUwdqN
	CTKZmrdsPNDEhzT2b8j6MkatMJVegOZxaaVmM3saR4/6wraM919n0I9FVM/fPPsmqxX6Qwjh8LgqQ
	JxKoseKfS2XmLC988K/nhr0bvoxt+lsXCmyTLAn2/v7F4HK9EWs/dulepgoTOCAq33IIfgBN25N9a
	COsLkHp7lpzLKC/zdmRqvVCWSrsNRESDLSoq7ORs6XdhMSmIg16DMNfnjBNUuuc/OwV586k/bnwJE
	yKtC3DyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdYQ-0000000DmZc-1IvV;
	Tue, 27 Jan 2026 07:32:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdYO-0000000DmZW-40lk
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 07:32:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DB8F660097;
	Tue, 27 Jan 2026 07:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC3CC116C6;
	Tue, 27 Jan 2026 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769499119;
	bh=RlBJGa1qa6Olo8efDWcRWJLbj1v7PDFyAEadNj37KbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6woip7ntNeXOmzDiTKg3LLAfc1enMO4l8ZkLD2IKmLhRIaGTQOQvYA4CiXPXZjgt
	 DKWYmoaCFW2rn8hQv4qzVYcYbjcxYtm8BG6fUH9hG4h6J0lUe4qAC/FXmwMbZz+oCC
	 ElqCSjF48IHd2ul9DumyOGhjWSUQ35xOnKmcJ42LGz0iRulL+3QdTsqWqnPYyKapgo
	 5ZRWCtHBfmzCk3skHSDMXACnzFSoAnMo89jW0zHKUdNqIhG3oiQ6SEpjP+jaeGQipI
	 H7XuBMPcU/m+fredxnl0Xo8advRkI/i9Ks8cVRNHAWeh9R8M27F1Nkx2Y5Idvo+0C+
	 e2gk+E5OQwEvw==
Date: Tue, 27 Jan 2026 09:31:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v5 3/4] kho: kexec-metadata: track previous kernel chain
Message-ID: <aXhp5ZDKtXG5n9sB@kernel.org>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
 <20260126-kho-v5-3-7cd0f69ab204@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-kho-v5-3-7cd0f69ab204@debian.org>
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

On Mon, Jan 26, 2026 at 08:07:25AM -0800, Breno Leitao wrote:
> Use Kexec Handover (KHO) to pass the previous kernel's version string
> and the number of kexec reboots since the last cold boot to the next
> kernel, and print it at boot time.
> 
> Example output:
>     [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)
> 
> Motivation
> ==========
> 
> Bugs that only reproduce when kexecing from specific kernel versions
> are difficult to diagnose. These issues occur when a buggy kernel
> kexecs into a new kernel, with the bug manifesting only in the second
> kernel.
> 
> Recent examples include the following commits:
> 
>  * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
>  * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
>  * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
> 
> As kexec-based reboots become more common, these version-dependent bugs
> are appearing more frequently. At scale, correlating crashes to the
> previous kernel version is challenging, especially when issues only
> occur in specific transition scenarios.
> 
> Implementation
> ==============
> 
> The kexec metadata is stored as a plain C struct (struct kho_kexec_metadata)
> rather than FDT format, for simplicity and direct field access. It is
> registered via kho_add_subtree() as a separate subtree, keeping it
> independent from the core KHO ABI. This design choice:
> 
>  - Keeps the core KHO ABI minimal and stable
>  - Allows the metadata format to evolve independently
>  - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
>    when the metadata format changes
> 
> The struct kho_metadata contains two fields:
>  - previous_release: The kernel version that initiated the kexec
>  - kexec_count: Number of kexec boots since last cold boot
> 
> On cold boot, kexec_count starts at 0 and increments with each kexec.
> The count helps identify issues that only manifest after multiple
> consecutive kexec reboots.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

with a small nit below

> ---
>  include/linux/kho/abi/kexec_handover.h | 31 ++++++++++++++
>  kernel/liveupdate/kexec_handover.c     | 74 ++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 2201a0d2c159a..1f017756e9991 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -11,6 +11,7 @@
>  #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
>  
>  #include <linux/types.h>
> +#include <linux/utsname.h>
>  
>  /**
>   * DOC: Kexec Handover ABI
> @@ -84,6 +85,36 @@
>  /* The FDT property for sub-FDTs. */
>  #define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
>  
> +/**
> + * DOC: Kexec Metadata ABI
> + *
> + * The "kexec-metadata" subtree stores optional metadata about the kexec chain.
> + * It is registered via kho_add_subtree(), keeping it independent from the core
> + * KHO ABI. This allows the metadata format to evolve without affecting other
> + * KHO consumers.
> + *
> + * The metadata is stored as a plain C struct rather than FDT format for
> + * simplicity and direct field access.
> + */
> +
> +/**
> + * struct kho_kexec_metadata - Kexec metadata passed between kernels
> + * @previous_release: Kernel version string that initiated the kexec
> + * @kexec_count: Number of kexec boots since last cold boot
> + *
> + * This structure is preserved across kexec and allows the new kernel to
> + * identify which kernel it was booted from and how many kexec reboots
> + * have occurred.
> + *
> + * __NEW_UTS_LEN is part of UAPI, so it safe to use it in here.

Nit: it's usually referred to as uABI.

> + */
> +struct kho_kexec_metadata {
> +	char previous_release[__NEW_UTS_LEN + 1];
> +	u32 kexec_count;
> +} __packed;
> +
> +#define KHO_METADATA_NODE_NAME "kexec-metadata"
> +
>  /**
>   * DOC: Kexec Handover ABI for vmalloc Preservation
>   *

-- 
Sincerely yours,
Mike.

